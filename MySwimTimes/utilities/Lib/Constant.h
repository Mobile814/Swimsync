//
//  Constant.h
//  MySwimTimes
//
//  Created by SmarterApps on 3/20/14.
//  Copyright (c) 2014 SmarterApps. All rights reserved.
//

#import <Foundation/Foundation.h>

/* ================================================ */


#define kCurrentProfile                             @"CurrentProfile"

// Date time
#define kDateTimeFormatServer                       @"yyyy-MM-dd HH:mm:ss"
#define kDateTimeFormat                             @"yyyy-MM-dd HH:mm:ss"

// File in comment
#define FILE_THUMBNAIL              @"thumbnail"
#define FILE_ORIGIN                 @"origin"

// Fonts
#define FONT_CABIN_BOLD             @"Cabin-Bold"
#define FONT_CABIN_BOLD_ITALIC      @"Cabin-BoldItalic"
#define FONT_CABIN_ITALIC           @"Cabin-Italic"
#define FONT_CABIN_MEDIUM           @"Cabin-Medium"
#define FONT_CABIN_MEDIUM_ITALIC    @"Cabin-MediumItalic"
#define FONT_CABIN_REGULAR          @"Cabin-Regular"
#define FONT_CABIN_SEMIBOLD         @"Cabin-SemiBold"
#define FONT_CABIN_SEMIBOLD_ITALIC  @"Cabin-SemiBoldItalic"

#define FONT_CABIN_REGULAR_16       [UIFont fontWithName:FONT_CABIN_REGULAR size:13]
#define DARK_BLUE                   [UIColor colorWithRed:36.0/255.0 green:106.0/255.0 blue:154.0/255.0 alpha:1.0]
#define NAVIGATION_GRAY_COLOR       [UIColor colorWithRed:242.0/256.0 green:242.0/256.0 blue:242.0/256.0 alpha:1.0]
#define GRAY_TEXT_COLOR             [UIColor colorWithRed:105.0/256.0 green:105.0/256.0 blue:105.0/256.0 alpha:1.0]
#define BLUE_TEXT_COLOR             [UIColor colorWithRed:38.0/256.0 green:116.0/256.0 blue:169.0/256.0 alpha:1.0]
#define SYSTEM_FONT_13              [UIFont systemFontOfSize:13.0]
#define SYSTEM_FONT_15              [UIFont systemFontOfSize:15.0]


// font
#define FONT_OPTIMABOLD_DEMI        @"Helvetica-Bold"
#define FONT_OPTIMA_REGULAR         @"Helvetica"

#define kCornerRadius        6.0


// Connect link
#define FACEBOOK_LINK   @"https://www.facebook.com/cocacola"
#define TWITTER_LINK   @"https://twitter.com/CocaCola"
#define EMAIL_ADD   @"myswimtime2014@gmail.com"

//************
// Stoke enum
//************
typedef NS_ENUM(NSInteger, MYSStrokeTypes) {
    /**
     Fly stroke
     */
    MYSStroke_FLY,
    /**
     BK stroke
     */
    MYSStroke_BK,
    /**
     BR stroke
     */
    MYSStroke_BR,
    /**
     FR stroke
     */
    MYSStroke_FR,
    /**
     IM stroke
     */
    MYSStroke_IM,
    
    MYSStroke_Max
};

//************
// Course enum
//************
typedef NS_ENUM(NSInteger, MYSCourseType) {
    MYSCourseType_Short,
    MYSCourseType_Long,
    MYSCourseType_Open,
};

typedef NS_ENUM(NSInteger, MYSStageType) {
    MYSStageType_Heat,
    MYSStageType_Semi_Final,
    MYSStageType_Final,
};

@interface Constant : NSObject

@end
