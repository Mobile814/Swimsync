//
//  MYSGoalTime.h
//  MySwimTimes
//
//  Created by hanjinghe on 10/3/14.
//  Copyright (c) 2014 Kerofrog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MYSProfile;

@interface MYSGoalTime : NSManagedObject

@property (nonatomic, retain) NSNumber * distance;
@property (nonatomic, retain) NSNumber * stroke;
@property (nonatomic, retain) NSNumber * time;
@property (nonatomic, retain) NSNumber * courseType;
@property (nonatomic, retain) MYSProfile *profile;

@end
