//
//  MYSTime.h
//  MySwimTimes
//
//  Created by hanjinghe on 9/28/14.
//  Copyright (c) 2014 Kerofrog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

extern const struct MYSTimeAttributes {
    __unsafe_unretained NSString *course;
    __unsafe_unretained NSString *date;
    __unsafe_unretained NSString *distance;
    __unsafe_unretained NSString *reactionTime;
    __unsafe_unretained NSString *status;
    __unsafe_unretained NSString *stroke;
    __unsafe_unretained NSString *time;
} MYSTimeAttributes;

extern const struct MYSTimeRelationships {
    __unsafe_unretained NSString *laps;
    __unsafe_unretained NSString *meet;
    __unsafe_unretained NSString *profile;
} MYSTimeRelationships;

extern const struct MYSTimeFetchedProperties {
} MYSTimeFetchedProperties;

@interface MYSTimeID : NSManagedObjectID {}
@end

@class MYSLap, MYSMeet, MYSProfile;

@interface MYSTime : NSManagedObject

@property (nonatomic, retain) NSNumber * course;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * distance;
@property (nonatomic, retain) NSNumber * reactionTime;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSNumber * stroke;
@property (nonatomic, retain) NSNumber * time;
@property (nonatomic, retain) NSNumber * stage;
@property (nonatomic, retain) NSSet *laps;
@property (nonatomic, retain) MYSMeet *meet;
@property (nonatomic, retain) MYSProfile *profile;
@end

@interface MYSTime (CoreDataGeneratedAccessors)

- (void)addLapsObject:(MYSLap *)value;
- (void)removeLapsObject:(MYSLap *)value;
- (void)addLaps:(NSSet *)values;
- (void)removeLaps:(NSSet *)values;

@end
