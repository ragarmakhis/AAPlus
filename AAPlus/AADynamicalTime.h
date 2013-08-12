//
//  AADynamicalTime.h
//  AAPlus
//
//  Created by Logger 1 on 29.07.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//


/**
 This class provides for conversion between Universal Time (both UT1 and UTC) and Terrestrial Time (TT) aka Terrestrial Dynamical Time (TDT) aka Ephemeris Time (ET). This refers to Chapter 10 in the book.
 */
#import <Foundation/Foundation.h>

@interface AADynamicalTime : NSObject

/**
 @return The difference DeltaT which is equal to TT - UT1 in seconds of time.
 
 @param julianDay The Julian day to calculate DeltaT for. Because DeltaT changes so slowly, the time used can be in the TT, the UTC or UT1 timeframes.
 */
+(CGFloat)deltaT:(CGFloat)julianDay;

/**
 @return The cumulative total of Leap seconds which have been applied to this point in seconds of time.
 
 @param julianDay The Julian day to calculate Cumulative leap seconds for. Because Leap seconds change so slowly, the time used can be in the TT, the UTC or UT1 timeframes although technically leap seconds are only relevant to the UTC timescale.
 */
+(CGFloat)cumulativeLeapSeconds:(CGFloat)julianDay;

@end
