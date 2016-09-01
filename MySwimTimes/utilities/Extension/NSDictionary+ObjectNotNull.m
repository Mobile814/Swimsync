//
//  NSDictionary+ObjectNotNull.m
//
//  Created by Cliff Viegas on 12/12/12.
//

#import "NSDictionary+ObjectNotNull.h"

@implementation NSDictionary (ObjectNotNull)

-(id)objectNotNullForKey:(id)key {
    id obj = [self objectForKey:key];
    if (obj == nil || [obj isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return obj;
}

-(NSArray *)arrayForKey:(id)aKey {
    id obj = [self objectForKey:aKey];
    if (obj == nil || [obj isKindOfClass:[NSNull class]]) {
        return nil;
    }
    if ([obj isKindOfClass:[NSArray class]]) {
        return obj;
    }
    return nil;
}

@end
