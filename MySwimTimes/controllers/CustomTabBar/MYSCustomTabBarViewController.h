//
//  MYSCustomTabBarViewController.h
//  MySwimTimes
//
//  Created by SmarterApps on 3/5/14.
//  Copyright (c) 2014 SmarterApps. All rights reserved.
//

/**
 This is a custom tabbar class
 */

#import <UIKit/UIKit.h>

/** Skinning new UI **/
#define kSkinningTimesBG                    @"tab_times"
#define kSkinningTimesTapBG                 @"tab_times_focus"
#define kSkinningMeetsBG                    @"tab_meets"
#define kSkinningMeetsTapBG                 @"tab_meets_focus"
#define kSkinningProfilesBG                 @"tab_swimmer"
#define kSkinningProfilesTapBG              @"tab_swimmer_focus"
#define kSkinningChartsBG                   @"tab_charts"
#define kSkinningChartsTapBG                @"tab_charts_focus"
#define kSkinningStopwatchBG                @"tab_stopwatch"
#define kSkinningStopwatchTapBG             @"tab_stopwatch_focus"


@interface MYSCustomTabBarViewController : UITabBarController

@property (nonatomic, assign) UIView *myTabBar;

//Button times
@property (nonatomic, assign) UIButton *btnTimes;

//Button meets
@property (nonatomic, assign) UIButton *btnMeets;

//Button stopwatch
@property (nonatomic, assign) UIButton *btnStopwatch;

//Button profiles
@property (nonatomic, assign) UIButton *btnProfiles;

//Button share
@property (nonatomic, assign) UIButton *btnCharts;

@property (nonatomic, assign) int initMenuIndex;

#pragma mark - Intance Methods

//Hide tabbar
-(void) hideTabBarView:(UIViewController *) controller;
//Show tabbar
-(void) showTabBarView:(UIViewController *) controller;

- (void)btnTimesTapped;
- (void)btnMeetsTapped;
- (void)btnStopwatchTapped;
- (void)btnProfilesTapped;
- (void)btnChartsTapped;

@end
