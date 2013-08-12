//
//  AASidereal.m
//  AAPlus
//
//  Created by Logger 1 on 27.07.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

#import "AASidereal.h"
#import "AADate.h"
#import "AACoordinateTransformation.h"
#import "AANutation.h"

@implementation AASidereal

+(CGFloat)meanGreenwichSiderealTimeFromJulianDay:(CGFloat)julianDay{
    
    AADate *date = [AADate dateWithJulianDay:julianDay inGregorianCalendar:[AADate afterPapalReformByJulianDay:julianDay]];
    CGFloat julianDayMidnight = [date julianDay];
    
    //Calculate the sidereal time at midnight
    CGFloat T = (julianDayMidnight - 2451545) / 36525;
    CGFloat T2 = T*T;
    CGFloat T3 = T2*T;
    CGFloat value = 100.46061837 + (36000.770053608*T) + (0.000387933*T2) - (T3/38710000);
    
    //Adjust by the time of day
    value += ( (([date hour] * 15) + ([date minute] * 0.25) + ([date second] * 0.0041666666666666666666666666666667)) * 1.00273790935);
    
    value = [AACoordinateTransformation degreesToHours:value];
    
    return [AACoordinateTransformation mapTo0To24Range:value];
}

+(CGFloat)apparentGreenwichSiderealTimeFromJulianDay:(CGFloat)julianDay{
    CGFloat meanObliquity = [AANutation meanObliquityOfEcliptic:julianDay];
    CGFloat trueObliquity = meanObliquity + [AANutation nutationInObliquity:julianDay] / 3600;
    CGFloat nutationInLongitude = [AANutation nutationInLongitude:julianDay];
    
    CGFloat value = [self meanGreenwichSiderealTimeFromJulianDay:julianDay] + (nutationInLongitude * cos([AACoordinateTransformation degreesToRadian:trueObliquity]) / 54000);
    return [AACoordinateTransformation mapTo0To24Range:value];
    
}

@end
