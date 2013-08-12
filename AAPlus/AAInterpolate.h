//
//  AAInterpolate.h
//  AAPlus
//
//  Created by Logger 1 on 03.08.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

/**
 This class provides the algorithms for interpolation. This refers to Chapter 3 in the book.
 */

#import <Foundation/Foundation.h>

@interface AAInterpolate : NSObject

/**
 @return The interpolated Y value.
 
 @param n The interpolating factor.
 
 @param y1 The first Y value to interpolate from.
 
 @param y2 The second Y value to interpolate from.
 
 @param y3 The third Y value to interpolate from.
 */
+(CGFloat)interpolateByN:(CGFloat)n y1:(CGFloat)y1 y2:(CGFloat)y2 y3:(CGFloat)y3;

@end
