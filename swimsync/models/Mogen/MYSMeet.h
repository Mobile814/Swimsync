//
//  MYSMeet.h
//  MySwimTimes
//
//  Created by hanjinghe on 9/25/14.
//  Copyright (c) 2014 Kerofrog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

extern const struct MYSMeetAttributes {
    __unsafe_unretained NSString *city;
    __unsafe_unretained NSString *courseType;
    __unsafe_unretained NSString *endDate;
    __unsafe_unretained NSString *enteredDate;
    __unsafe_unretained NSString *id;
    __unsafe_unretained NSString *location;
    __unsafe_unretained NSString *startDate;
    __unsafe_unretained NSString *title;
} MYSMeetAttributes;

extern const struct MYSMeetRelationships {
    __unsafe_unretained NSString *qualifytimes;
    __unsafe_unretained NSString *times;
} MYSMeetRelationships;

extern const struct MYSMeetFetchedProperties {
} MYSMeetFetchedProperties;

@class MYSQualifyTime, MYSTime;

@interface MYSMeet : NSManagedObject

@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSNumber * courseType;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSDate * enteredDate;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *qualifytimes;
@property (nonatomic, retain) NSSet *times;
@end

@interface MYSMeet (CoreDataGeneratedAccessors)

- (void)addQualifytimesObject:(MYSQualifyTime *)value;
- (void)removeQualifytimesObject:(MYSQualifyTime *)value;
- (void)addQualifytimes:(NSSet *)values;
- (void)removeQualifytimes:(NSSet *)values;

- (void)addTimesObject:(MYSTime *)value;
- (void)removeTimesObject:(MYSTime *)value;
- (void)addTimes:(NSSet *)values;
- (void)removeTimes:(NSSet *)values;

@end
