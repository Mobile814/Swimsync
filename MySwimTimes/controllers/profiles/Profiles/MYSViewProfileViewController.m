//
//  MYSViewProfileViewController.m
//  MySwimTimes
//
//  Created by hanjinghe on 9/23/14.
//  Copyright (c) 2014 Kerofrog. All rights reserved.
//

#import "MYSViewProfileViewController.h"

#import "MYSNewProfileViewController.h"

#import "DFPBannerView.h"

@interface MYSViewProfileViewController ()<GADBannerViewDelegate>

@property (nonatomic, assign) IBOutlet UIImageView *ivProfile;
@property (nonatomic, assign) IBOutlet UILabel *lblName;
@property (nonatomic, assign) IBOutlet UILabel *lblAge;

@property (nonatomic, assign) IBOutlet UILabel *lblGender;
@property (nonatomic, assign) IBOutlet UILabel *lblBirthday;
@property (nonatomic, assign) IBOutlet UILabel *lblSwimmerClub;
@property (nonatomic, assign) IBOutlet UILabel *lblCity;
@property (nonatomic, assign) IBOutlet UILabel *lblCountry;

@property (nonatomic, assign) IBOutlet UIImageView *ivImage;

@property (nonatomic, retain) DFPBannerView *bannerView;

- (IBAction)onBack:(id)sender;
- (IBAction)onEdit:(id)sender;

@end

@implementation MYSViewProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.ivProfile.backgroundColor = [UIColor lightGrayColor];
    self.ivProfile.layer.cornerRadius = 5;
    self.ivProfile.clipsToBounds = YES;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        self.bannerView = [[DFPBannerView alloc] initWithAdSize:kGADAdSizeLeaderboard];
    else
        self.bannerView = [[DFPBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    
    self.bannerView.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2, CGRectGetHeight(self.view.frame) - 60 - CGRectGetHeight(self.bannerView.frame) / 2);
    
    self.bannerView.rootViewController = self;
    self.bannerView.adUnitID = EG_ADMOB_BANNERAD;
    [self.view addSubview:self.bannerView];
    [self.bannerView loadRequest:[GADRequest request]];
    self.bannerView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"editprofile"])
    {
        MYSNewProfileViewController *newProfileViewController = segue.destinationViewController;
        newProfileViewController.profile = self.swimmer;
        newProfileViewController.isEdit = YES;
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    BOOL isPurchased = [prefs boolForKey:@"purchased"];
    
    self.bannerView.hidden = isPurchased;
    
    [self loadInformation];
}

- (void) loadInformation
{
    self.ivProfile.image = [UIImage imageWithData:self.swimmer.image];
    
    self.lblName.text = [NSString stringWithFormat:@"%@", self.swimmer.name];
    self.lblAge.text = [NSString stringWithFormat:@"%.0f years",[MethodHelper countYearOld2:self.swimmer.birthday]];
    
    self.lblBirthday.text = [MethodHelper convertFullMonth:self.swimmer.birthday];
    self.lblSwimmerClub.text = self.swimmer.nameSwimClub;
    self.lblCity.text = self.swimmer.city;
    self.lblCountry.text = self.swimmer.country;
    
    self.lblGender.text = [NSString stringWithFormat:@"%@", [self.swimmer.gender intValue] == 0 ? @"Male" : @"Female"];
}

- (IBAction)onBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)onEdit:(id)sender
{
    [self performSegueWithIdentifier:@"editprofile" sender:self.swimmer];
}

#pragma mark - GABDelegate
- (void)adViewDidReceiveAd:(GADBannerView *)view {
    NSLog(@"ADBanner==>adViewDidReceiveAd");
}

- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"ADBanner==>adViewFailed, %@", error.userInfo[@"error"]);
}


@end
