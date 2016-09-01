//
//  MYSTimesHomeViewController.m
//  MySwimTimes
//
//  Created by hanjinghe on 10/26/14.
//  Copyright (c) 2014 Kerofrog. All rights reserved.
//

#import "MYSTimesHomeViewController.h"

#import "MYSTimesViewController.h"
#import "MYSOpenTimesViewController.h"

@interface MYSTimesHomeViewController ()

@end

@implementation MYSTimesHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self gotoScreen];
}

- (void) gotoScreen
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    int times = [prefs integerForKey:@"times"];
    
    if(times == 0)
    {
        [self gotoTimesScreen];
    }
    else
    {
        [self gotoOpenTimesScreen];
    }
}

- (void) gotoOpenTimesScreen
{
    MYSOpenTimesViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"OpenTimes"];
    
    [self.navigationController pushViewController:vc animated:NO];
}

- (void) gotoTimesScreen
{
    MYSTimesViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYSTimesViewController"];
    
    [self.navigationController pushViewController:vc animated:NO];
}

@end
