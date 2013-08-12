//
//  AA2DCoordinate.h
//  AAPlus
//
//  Created by Logger 1 on 05.08.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//
/**
 Class for 2D coordinate
 */
#import <Foundation/Foundation.h>

@interface AA2DCoordinate : NSObject
/**
 x coordonate
 */
@property CGFloat x;
/**
 y coordinate
 */
@property CGFloat y;

/**
 
 @return A new 2DCoordinate object
 */
+(id)coordinate;

@end
