//
//  MYSSettingViewController.m
//  MySwimTimes
//
//  Created by hanjinghe on 10/30/14.
//  Copyright (c) 2014 Kerofrog. All rights reserved.
//

#import "MYSSettingViewController.h"

#import "JSStoreManager.h"

#import "MYSContentViewController.h"

#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>

@interface MYSSettingViewController ()<JSStoreManagerDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, assign) IBOutlet UITableView *tvSettings;

@property (nonatomic, assign) UISwitch *swtNotification;

@end

@implementation MYSSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    if([segue.identifier isEqualToString:@"content"])
    {
        MYSContentViewController *vc = segue.destinationViewController;
        vc.contentType = [sender intValue];
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    // transparent navigation
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    //self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
}

- (IBAction)onBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) onResture
{
    JSStoreManager *jsStoreManager = [JSStoreManager sharedManager];
    jsStoreManager.delegate = self;
    
    [jsStoreManager Restore];
}

- (void) onRemoveAds
{
    JSStoreManager *jsStoreManager = [JSStoreManager sharedManager];
    
    jsStoreManager.delegate = self;
    
    [jsStoreManager BuyRemoveAds];
}

- (void) onNotification
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs setBool:self.swtNotification.isOn forKey:@"notification"];
    
    [prefs synchronize];
    
    if(self.swtNotification.isOn)
    {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
    else
    {
        [[MYSDataManager shared] updateLocalNotifications];
    }
}

- (void) contactUs
{
    if (![MFMailComposeViewController canSendMail])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:@"Your device doesn't support this feature."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        
        alert.tag = -1;
        [alert show];
        alert = nil;
        return;
    }
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    [picker setToRecipients:[NSArray arrayWithObjects:@"swimsync.app@gmail.com", nil]];
    
    NSString* strSubject = [NSString stringWithFormat:@"swimsync"];
    [picker setSubject:strSubject];
    
    picker.navigationBar.barStyle = UIBarStyleDefault;
    
    [self presentViewController:picker animated:YES completion:nil];
    
    picker = nil;
}

#pragma mark MFMailControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
            break;
        case MFMailComposeResultFailed:
            break;
            
        default:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Sending Failed - Unknown Error :-("
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            alert.tag = -1;
            [alert show];
            alert = nil;
        }
            
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - === UITableView Datasource ===

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    BOOL isPurchased = [prefs boolForKey:@"purchased"];
    
    if(isPurchased)
        return 2;
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 1;
    else if(section == 1)
        return 2;
    else if(section == 2)
    {
        return 2;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        if(indexPath.section == 0)
        {
            UISwitch *switchView = [[UISwitch alloc] init];
            [switchView addTarget:self action:@selector(onNotification) forControlEvents:UIControlEventValueChanged];
            
            cell.accessoryView = switchView;
            self.swtNotification = switchView;
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            
            BOOL isNotification =[prefs boolForKey:@"notification"];
            
            self.swtNotification.on = isNotification;
        }
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        cell.textLabel.text = @"Notifications";
        cell.imageView.image = [UIImage imageNamed:@"setting_notification"];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else if(indexPath.section == 1)
    {
        if(indexPath.row == 0)
        {
            cell.textLabel.text = @"swimsync FAQs";
            cell.imageView.image = [UIImage imageNamed:@"setting_faq"];
        }
        else if(indexPath.row == 1)
        {
            cell.textLabel.text = @"Contact us";
            cell.imageView.image = [UIImage imageNamed:@"setting_email"];
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if(indexPath.section == 2)
    {
        if(indexPath.row == 0)
        {
            cell.textLabel.text = @"Restore";
        }
        else if(indexPath.row == 1)
        {
            cell.textLabel.text = @"Remove Ads for $0.99 US";
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    cell.selectionStyle = UITableViewCellEditingStyleNone;
}

#pragma mark - === UITableView Delegate methods ===

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        
    }
    else if(indexPath.section == 1)
    {
        if(indexPath.row == 0)
            [self performSegueWithIdentifier:@"content" sender:[NSNumber numberWithInt:indexPath.row]];
        else if(indexPath.row == 1)
                [self contactUs];
    }
    else if(indexPath.section == 2)
    {
        if(indexPath.row == 0)
        {
            [self onResture];
        }
        else if(indexPath.row == 1)
        {
            [self onRemoveAds];
        }
    }
}

#pragma mark InAppPurchaseDelegate

-(void)Failed:(NSString*)errMsg
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:errMsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alertView show];
    alertView = nil;
}

-(void)Successed
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Success to purchase." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alertView show];
    alertView = nil;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:YES forKey:@"purchased"];
    [prefs synchronize];
    
    [self.tvSettings reloadData];
}

@end
