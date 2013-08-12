//
//  AAMoonPhases.h
//  AAPlus
//
//  Created by Logger 1 on 22.07.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

/**
 AAMoonPhases
 
 This class provides algorithms which obtain the dates for the phases of the Moon. This refers to Chapter 49 in the book.
 
*/

#import <Foundation/Foundation.h>

@interface AAMoonPhases : NSObject

/**
 
 @return Returns the approximate value of K (required by the other methods of AAMoonPhases) for calculation of the specified phase.
 
 @param year The Year including decimals to calculate the K value for.
*/
+(CGFloat)calculateKFromDecimalYear:(CGFloat)year;

/**
 
 @return Returns the date in Dynamical time when the specified mean moon phase occurs.
 
 @param k The K value to calculate the phase for.
 
*/
+(CGFloat)meanPhaseFromK:(CGFloat)k;

/**
 
 @return Returns the date in Dynamical time when the specified true moon phase occurs.
 
 @param k The K value to calculate the phase for.
 
 */
+(CGFloat)truePhaseFromK:(CGFloat)k;

@end
