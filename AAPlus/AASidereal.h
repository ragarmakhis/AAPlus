//
//  AASidereal.h
//  AAPlus
//
//  Created by Logger 1 on 27.07.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

/**
 This class provides for the calculation of sidereal time. This refers to Chapter 12 in the book.
 */

#import <Foundation/Foundation.h>

@interface AASidereal : NSObject

/**
 @param julianDay The Julian Day in Universal time to calculate for.
 
 @return The Mean Greenwich Sidereal Time, that is, the Greenwich hour angle of the mean vernal point (the intersection of the ecliptic of the date with the mean equator of the date), expressed in hours.
 */
+(CGFloat)meanGreenwichSiderealTimeFromJulianDay:(CGFloat)julianDay;
/**
 @param julianDay The Julian Day in Universal time to calculate for.
 
 @return The Apparent Greenwich Sidereal Time, that is, the Greenwich hour angle of the true vernal equinox, expressed in hours.
 */
+(CGFloat)apparentGreenwichSiderealTimeFromJulianDay:(CGFloat)julianDay;

@end
