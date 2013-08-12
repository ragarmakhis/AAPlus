//
//  AAInterpolate.m
//  AAPlus
//
//  Created by Logger 1 on 03.08.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

#import "AAInterpolate.h"

@implementation AAInterpolate

+(CGFloat)interpolateByN:(CGFloat)n y1:(CGFloat)y1 y2:(CGFloat)y2 y3:(CGFloat)y3{
    CGFloat a = y2 - y1;
    CGFloat b = y3 - y2;
    CGFloat c = y1 + y3 - 2 * y2;
    
    return y2 + n / 2 * (a + b + n * c);
}

@end
