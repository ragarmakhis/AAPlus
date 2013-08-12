//
//  AARiseTransitSetDetails.m
//  AAPlus
//
//  Created by Logger 1 on 27.07.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

#import "AARiseTransitSetDetails.h"

@implementation AARiseTransitSetDetails

+(id)riseTransitSetDetails{
    return [[self alloc] init];
}

-(id)init{
    self = [super init];
    if (self) {
        self.riseValid = NO;
        self.rise = 0.0;
        self.transitAboveHorizon = NO;
        self.transit = 0.0;
        self.setValid = NO;
        self.set = 0.0;
        
    }
    return self;
}

@end
