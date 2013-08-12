//
//  AANutation.h
//  AAPlus
//
//  Created by Logger 1 on 27.07.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

/**
 This class provides for calculation of Nutation and the Obliquity of the Ecliptic. This refers to Chapter 22 and parts of Chapter 23 in the book.
 */

#import <Foundation/Foundation.h>

@interface AANutation : NSObject

/**
 The nutation in ecliptic longitude in arc seconds of a degree.
 
 @return The nutation in ecliptic longitude in arc seconds of a degree.
 
 @param julianDay The date in Dynamical time to calculate for.
 */
+(CGFloat)nutationInLongitude:(CGFloat)julianDay;
/**
 The nutation in obliquity in arc seconds of a degree.
 
 @return The nutation in obliquity in arc seconds of a degree.
 
 @param julianDay The date in Dynamical time to calculate for.
 */
+(CGFloat)nutationInObliquity:(CGFloat)julianDay;
/**
 The nutation in right ascension in arc seconds of a degree.
 
 This refers to algorithm 23.1 on page 151.
 
 @return The nutation in right ascension in arc seconds of a degree.
 
 @param alpha The right ascension of the position in hour angles.
 
 @param delta The declination of the position in degrees.
 
 @param obliquity The obliquity of the Ecliptic in degrees.
 
 @param nutationInLongitude The nutation in longitude in arc seconds of a degree.
 
 @param nutationInObliquity The nutation in obliquity in arc seconds of a degree.
 */
+(CGFloat)nutationInRightAscensionByRightAscension:(CGFloat)alpha declination:(CGFloat)delta obliquity:(CGFloat)obliquity nutationInLongitude:(CGFloat)nutationInLongitude nutationInObliquity:(CGFloat)nutationInObliquity;
/**
 The nutation in declination in arc seconds of a degree.
 
 This refers to algorithm 23.1 on page 151.
 
 @return The nutation in right ascension in arc seconds of a degree.
 
 @param alpha The right ascension of the position in hour angles.
 
 @param obliquity The obliquity of the Ecliptic in degrees.
 
 @param nutationInLongitude The nutation in longitude in arc seconds of a degree.
 
 @param nutationInObliquity The nutation in obliquity in arc seconds of a degree.
 */
+(CGFloat)nutationInDeclinationByRightAscension:(CGFloat)alpha obliquity:(CGFloat)obliquity nutationInLongitude:(CGFloat)nutationInLongitude nutationInObliquity:(CGFloat)nutationInObliquity;
/**
 The mean obliquity of the ecliptic in degrees.
 
 @return The mean obliquity of the ecliptic in degrees.
 
 @param julianDay The date in Dynamical time to calculate for.
 */
+(CGFloat)meanObliquityOfEcliptic:(CGFloat)julianDay;
/**
 The true obliquity of the ecliptic in degrees.
 
 @return The true obliquity of the ecliptic in degrees.
 
 @param julianDay The date in Dynamical time to calculate for.
 */
+(CGFloat)trueObliquityOfEcliptic:(CGFloat)julianDay;

@end
