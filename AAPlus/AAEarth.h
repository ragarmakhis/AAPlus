//
//  AAEarth.h
//  AAPlus
//
//  Created by Logger 1 on 10.08.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

/**
 AAEarth
 
 This class provides for calculation of the heliocentric position of the Earth. This refers to Chapter 32 and parts of Chapter 26 and 47 in the book.
 */

#import <Foundation/Foundation.h>

@interface AAEarth : NSObject

/**
 @return the ecliptic longitude in degrees referred to the mean dynamical ecliptic and equinox of the date defined in the VSOP theory.
 
 @param julianDay The date in Dynamical time to calculate for.
 */
+(CGFloat)eclipticLongitude:(CGFloat)julianDay;
/**
 @return the ecliptic latitude in degrees referred to the mean dynamical ecliptic and equinox of the date defined in the VSOP theory.
 
 @param julianDay The date in Dynamical time to calculate for.
 */
+(CGFloat)eclipticLatitude:(CGFloat)julianDay;
/**
 @return the radius vector in astronomical units.
 
 @param julianDay The date in Dynamical time to calculate for.
 */
+(CGFloat)radiusVector:(CGFloat)julianDay;
/**
 @return the ecliptic longitude in degrees referred to the mean dynamical ecliptic and equinox of J2000 in the VSOP theory.
 
 @param julianDay The date in Dynamical time to calculate for.
 */
+(CGFloat)eclipticLongitudeJ2000:(CGFloat)julianDay;

/**
 @return the ecliptic latitude in degrees referred to the mean dynamical ecliptic and equinox of J2000 defined in the VSOP theory.
 
 @param julianDay The date in Dynamical time to calculate for.
 */
+(CGFloat)eclipticLatitudeJ2000:(CGFloat)julianDay;

/**
 @return the eccentricity of Earth's orbit.
 
 @param julianDay The date in Dynamical time to calculate for.
 */
+(CGFloat)eccentricity:(CGFloat)julianDay;

/**
 @return the mean anomaly of the Sun in degrees.
 
 @param julianDay The date in Dynamical time to calculate for.
 */
+(CGFloat)sunMeanAnomaly:(CGFloat)julianDay;

@end
