//
//  AA2DCoordinate.m
//  AAPlus
//
//  Created by Logger 1 on 05.08.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

#import "AA2DCoordinate.h"

@implementation AA2DCoordinate

-(id)init {
    self = [super init];
    if (self) {
        [self setX:0.0];
        [self setY:0.0];
    }
    return self;
}

+(id)coordinate{
    return [[self alloc] init];
}

@end
