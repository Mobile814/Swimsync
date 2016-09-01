//
//  MYSTime.m
//  MySwimTimes
//
//  Created by hanjinghe on 9/28/14.
//  Copyright (c) 2014 Kerofrog. All rights reserved.
//

#import "MYSTime.h"
#import "MYSLap.h"
#import "MYSMeet.h"
#import "MYSProfile.h"

const struct MYSTimeAttributes MYSTimeAttributes = {
    .course = @"course",
    .date = @"date",
    .distance = @"distance",
    .reactionTime = @"reactionTime",
    .status = @"status",
    .stroke = @"stroke",
    .time = @"time",
};

const struct MYSTimeRelationships MYSTimeRelationships = {
    .laps = @"laps",
    .meet = @"meet",
    .profile = @"profile",
};

const struct MYSTimeFetchedProperties MYSTimeFetchedProperties = {
};

@implementation MYSTimeID
@end


@implementation MYSTime

@dynamic course;
@dynamic date;
@dynamic distance;
@dynamic reactionTime;
@dynamic status;
@dynamic stroke;
@dynamic time;
@dynamic stage;
@dynamic laps;
@dynamic meet;
@dynamic profile;

@end
