//
//  AAMoon.h
//  AAPlus
//
//  Created by Logger 1 on 10.08.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

/**
 AAMoon
 
 This class provides the algorithms which obtain the position of the Moon. This refers to Chapter 47 in the book.
 */

#import <Foundation/Foundation.h>

@interface AAMoon : NSObject
/**
 @return the mean longitude of the Moon in degrees
 
 @param julianDay The date in Dynamical time to calculate for.
 */
+(CGFloat)meanLongitude:(CGFloat)julianDay;
/**
 @return the mean elongation of the Moon in degrees.
 
 @param julianDay The date in Dynamical time to calculate for.
 */
+(CGFloat)meanElongation:(CGFloat)julianDay;
/**
 @return the mean anomaly of the Moon in degrees.
 
 @param julianDay The date in Dynamical time to calculate for.
 */
+(CGFloat)meanAnomaly:(CGFloat)julianDay;
/**
 @return the argument of latitude (mean distance of the Moon from its ascending node) in degrees.
 
 @param julianDay The date in Dynamical time to calculate for.
 */
+(CGFloat)argumentOfLatitude:(CGFloat)julianDay;
/**
 @return the mean longitude of the ascending node of the Moon in degrees.
 
 @param julianDay The date in Dynamical time to calculate for.
 */
+(CGFloat)meanLongitudeAscendingNode:(CGFloat)julianDay;
/**
 @return the mean longitude of the perigee of the lunar orbit in degrees.
 
 @param julianDay The date in Dynamical time to calculate for.
 */
+(CGFloat)meanLongitudePerigee:(CGFloat)julianDay;
/**
 @return the true longitude of the ascending node of the lunar orbit in degrees.
 
 @param julianDay The date in Dynamical time to calculate for.
 */
+(CGFloat)trueLongitudeAscendingNode:(CGFloat)julianDay;


/**
 @return the ecliptic longitude in degrees referred to the mean dynamical ecliptic and equinox of the date.
 
 @param julianDay The date in Dynamical time to calculate for.
 */
+(CGFloat)eclipticLongitude:(CGFloat)julianDay;
/**
 @return the ecliptic latitude in degrees referred to the mean dynamical ecliptic and equinox of the date.
 
 @param julianDay The date in Dynamical time to calculate for.
 */
+(CGFloat)eclipticLatitude:(CGFloat)julianDay;
/**
 @return the radius vector in kilometres.
 
 @param julianDay The date in Dynamical time to calculate for.
 */
+(CGFloat)radiusVector:(CGFloat)julianDay;


/**
 @return RadiusVector The distance to the object in kilometres
 
 @param parallax the parallax of the object (e.g. Moon) in degrees.
 */
+(CGFloat)radiusVectorFromHorizontalParallax:(CGFloat)parallax;
/**
 @return the parallax of the object in degrees
 
 @param radiusVector The distance to the object (e.g. Moon) in kilometres.
 */
+(CGFloat)horizontalParallaxFromRadiusVector:(CGFloat)radiusVector;

@end
