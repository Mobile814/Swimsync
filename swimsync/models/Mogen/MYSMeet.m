//
//  MYSMeet.m
//  MySwimTimes
//
//  Created by hanjinghe on 9/25/14.
//  Copyright (c) 2014 Kerofrog. All rights reserved.
//

#import "MYSMeet.h"
#import "MYSQualifyTime.h"
#import "MYSTime.h"

const struct MYSMeetAttributes MYSMeetAttributes = {
    .city = @"city",
    .courseType = @"courseType",
    .endDate = @"endDate",
    .enteredDate = @"enteredDate",
    .id = @"id",
    .location = @"location",
    .startDate = @"startDate",
    .title = @"title",
};

const struct MYSMeetRelationships MYSMeetRelationships = {
    .qualifytimes = @"qualifytimes",
    .times = @"times",
};


@implementation MYSMeet

@dynamic city;
@dynamic courseType;
@dynamic endDate;
@dynamic enteredDate;
@dynamic id;
@dynamic location;
@dynamic startDate;
@dynamic title;
@dynamic qualifytimes;
@dynamic times;

@end
