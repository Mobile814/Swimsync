#import "MYSStopWatch.h"


@interface MYSStopWatch ()

// Private interface goes here.

@end


@implementation MYSStopWatch

// Custom logic goes here.
-(NSArray *)getAllSortedLaps {
    NSArray *laps = self.laps.allObjects;
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:MYSLapAttributes.id ascending:YES];
    
    return [laps sortedArrayUsingDescriptors:@[sortDescriptor]];
}

@end
