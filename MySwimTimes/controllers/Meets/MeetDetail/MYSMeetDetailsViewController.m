//
//  MYSMeetDetailsViewController.m
//  MySwimTimes
//
//  Created by SmarterApps on 3/24/14.
//  Copyright (c) 2014 SmarterApps. All rights reserved.
//

#import "MYSMeetDetailsViewController.h"

#import "MYSNewManualTimeViewController.h"
#import "MYSNewMeetViewController.h"

#import "MYSMeetTimeTableViewCell.h"
#import "MYSMeetSwimmerTableViewCell.h"

#import "MYSDataManager.h"

#import "MeetDetailSwimmerHeaderView.h"

@interface MYSMeetDetailsViewController ()<UIActionSheetDelegate>
{
    int _selectedSwimmerIndex;
}

@property (nonatomic, assign) IBOutlet UILabel *lblMeetName;
@property (nonatomic, assign) IBOutlet UILabel *lblLocation;
@property (nonatomic, assign) IBOutlet UILabel *lblDate;
@property (nonatomic, assign) IBOutlet UILabel *lblCourseType;

@property (weak, nonatomic) IBOutlet UITableView *tbvMeetDetails;

@property (nonatomic, retain) NSMutableDictionary *dicMeetDetails;

@end

@implementation MYSMeetDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    _selectedSwimmerIndex = -1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"newtime"])
    {
        MYSNewManualTimeViewController *vc = segue.destinationViewController;
        vc.meet = self.meet;
    }
    else if([segue.identifier isEqualToString:@"editmeet"])
    {
        MYSNewMeetViewController *vc = segue.destinationViewController;
        vc.meet = self.meet;
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadMeetBaseInfo];
    [self loadMeetDatas];
}

- (void) loadMeetBaseInfo
{
    NSLog(@"%@", self.meet);
    
    self.lblMeetName.text = self.meet.title ;
    self.lblLocation.text = [NSString stringWithFormat:@"%@, %@", self.meet.location, self.meet.city];
    self.lblDate.text = [MethodHelper convertMeetDate:self.meet.startDate endDate:self.meet.endDate];
    
    self.lblCourseType.text = [MYSDataManager getCourseTypeStringFromType:[self.meet.courseType integerValue]];
}

- (void) loadMeetDatas
{
    if(self.dicMeetDetails == nil)
    {
        self.dicMeetDetails = [[NSMutableDictionary alloc] init];
    }
    //[self.dicMeetDetails removeAllObjects];
    
    NSMutableArray *aryTimes = (NSMutableArray *)[self.meet.times allObjects];
    
    for (MYSTime *time in aryTimes) {
        
        if(time == nil) continue;
        
        MYSProfile *profile = time.profile;
        
        if(profile == nil || profile.name.length == 0) continue;
        
        int64_t profileId = [profile.userid longLongValue];
        NSString *profileIdString = [NSString stringWithFormat:@"%lld", profileId];
        
        NSMutableDictionary *profileData = [self.dicMeetDetails objectForKey:profileIdString];
        
        if(profileData == nil)
        {
            NSMutableArray *aryTimes = [[NSMutableArray alloc] init];
            [aryTimes addObject:time];
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                        profile, @"profile",
                                        aryTimes, @"times",
                                        [NSNumber numberWithBool:NO], @"expand",
                                        nil];
            
            [self.dicMeetDetails setObject:dic forKey:profileIdString];
        }
        else
        {
            NSMutableArray *aryTimes = [profileData objectForKey:@"times"];
            
            if([aryTimes indexOfObject:time] == NSNotFound)
            {
                [aryTimes addObject:time];
            }
        }
    }
    
    [self.tbvMeetDetails reloadData];
}

- (IBAction)onBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onEdit:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Add a new time", @"Edit meet",  nil];
    
    [actionSheet showInView:self.view];
    actionSheet = nil;
}

- (void) tapSwimmerView:(UITapGestureRecognizer *)tapGesture
{
    int tap = tapGesture.view.tag;
    
    NSString *profileId = [self.dicMeetDetails.allKeys objectAtIndex:tap];
    NSMutableDictionary *profileData = [self.dicMeetDetails objectForKey:profileId];
    
    BOOL expanded = ![[profileData objectForKey:@"expand"] boolValue];
    
    [profileData setObject:[NSNumber numberWithBool:expanded] forKey:@"expand"];
    
    [self.tbvMeetDetails reloadData];
}

#pragma mark - === UITableView Datasource ===

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return [self.dicMeetDetails.allKeys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *profileId = [self.dicMeetDetails.allKeys objectAtIndex:section];
    
    NSMutableDictionary *profileData = [self.dicMeetDetails objectForKey:profileId];
    
    BOOL expand = [[profileData objectForKey:@"expand"] boolValue];
    
    if(!expand)
        return 0;
    
    NSMutableArray *aryTimes = [profileData objectForKey:@"times"];
    
    return  aryTimes.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *profileId = [self.dicMeetDetails.allKeys objectAtIndex:section];
    NSMutableDictionary *profileData = [self.dicMeetDetails objectForKey:profileId];
    
    MYSProfile *profile = [profileData objectForKey:@"profile"];
    
    MeetDetailSwimmerHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"MeetDetailSwimmerHeaderView" owner:self options:nil] objectAtIndex:0];
    headerView.tag = section;
    headerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.tbvMeetDetails.frame), 70.0f);
    
    headerView.ivProfile.image = [UIImage imageWithData:profile.image];
    
    headerView.lblUserName.text = profile.name;
    headerView.lblClub.text = profile.nameSwimClub;
    headerView.lblLocation.text = [NSString stringWithFormat:@"%@, %@", profile.city, profile.country];
    headerView.lblYear.text = [NSString stringWithFormat:@"%.0f years",[MethodHelper countYearOld2:profile.birthday]];
    
    BOOL expanded = [[profileData objectForKey:@"expand"] boolValue];
    
    headerView.ivDeclour.image = [UIImage imageNamed:(expanded ? @"image_up" : @"image_down")];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSwimmerView:)];
    [headerView addGestureRecognizer:tapGesture];
    tapGesture = nil;
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return 60;
    
    return 54.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//        return 80;
    
    return 70.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (MYSMeetTimeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"timecell"];
        
    NSString *profileId = [self.dicMeetDetails.allKeys objectAtIndex:indexPath.section];
    NSMutableDictionary *profileData = [self.dicMeetDetails objectForKey:profileId];
    
    NSMutableArray *aryTimes = [profileData objectForKey:@"times"];
    
    MYSTime *time = [aryTimes objectAtIndex:indexPath.row];

    ((MYSMeetTimeTableViewCell *)cell).lblDistance.text = [NSString stringWithFormat:@"%.0fm", [time.distance floatValue]];

    int strock = [time.stroke integerValue];

    if(strock == 0)
    {
        ((MYSMeetTimeTableViewCell *)cell).ivStrock.image = [UIImage imageNamed:@"icon-FLY-tap"];
        ((MYSMeetTimeTableViewCell *)cell).lblStrock.text = @"Butterfly";
    }
    else if(strock == 1)
    {
        ((MYSMeetTimeTableViewCell *)cell).ivStrock.image = [UIImage imageNamed:@"icon-BK-tap"];
        ((MYSMeetTimeTableViewCell *)cell).lblStrock.text = @"Backstroke";
    }
    else if(strock == 2)
    {
        ((MYSMeetTimeTableViewCell *)cell).ivStrock.image = [UIImage imageNamed:@"icon-BR-tap"];
        ((MYSMeetTimeTableViewCell *)cell).lblStrock.text = @"Breaststroke";
    }
    else if(strock == 3)
    {
        ((MYSMeetTimeTableViewCell *)cell).ivStrock.image = [UIImage imageNamed:@"icon-FR-tap"];
        ((MYSMeetTimeTableViewCell *)cell).lblStrock.text = @"Freestyle";
    }
    else if(strock == 4)
    {
        ((MYSMeetTimeTableViewCell *)cell).ivStrock.image = [UIImage imageNamed:@"icon-IM-tap"];
        ((MYSMeetTimeTableViewCell *)cell).lblStrock.text = @"Individual medley";
    }
    
    ((MYSMeetTimeTableViewCell *)cell).lblDuration.text = [MYSLap getSplitTimeStringFromMiliseconds:[time.time integerValue] withMinimumFormat:NO];
    
    MYSStageType stage = [time.stage integerValue];
    NSString *stageString = @"";
    if(stage == MYSStageType_Heat) stageString = @"Heat";
    else if(stage == MYSStageType_Semi_Final) stageString = @"Semi-Final";
    else if(stage == MYSStageType_Final) stageString = @"Final";
    
    ((MYSMeetTimeTableViewCell *)cell).lblStage.text = stageString;
    ((MYSMeetTimeTableViewCell *)cell).lblMarkPB.hidden = ([time.status integerValue] != MYSTimeStatusLatestPersionalBest);
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - === UITableView Delegate methods ===

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [self performSegueWithIdentifier:@"newtime" sender:nil];
    }
    else if(buttonIndex == 1)
    {
        [self performSegueWithIdentifier:@"editmeet" sender:nil];
    }
}

@end
