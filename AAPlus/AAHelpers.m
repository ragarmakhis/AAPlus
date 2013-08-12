//
//  AAHelpers.m
//  AAPlus
//
//  Created by Logger 1 on 27.07.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

#import "AAHelpers.h"

@implementation AAHelpers

+(NSInteger)toInt:(CGFloat)value{
    NSNumber *v = [NSNumber numberWithDouble:value];
    if (value >= 0) {
        return [v integerValue];
    } else {
        return [v integerValue] - 1;
    }
}

@end
