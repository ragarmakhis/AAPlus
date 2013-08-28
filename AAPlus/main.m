//
//  main.m
//  AAPlus
//
//  Created by Logger 1 on 02.07.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "AADate.h"
#import "AAMoonPhases.h"
#import "AAHelpers.h"
#import "AARiseTransitSet.h"
#import "AAMoon.h"
#import "AACoordinateTransformation.h"
#import "AANutation.h"

CGFloat calcRiseHour(CGFloat JD);

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSDate *myDate = [NSDate date];
//        NSDate *myDate = [NSDate dateWithString:@"1977-02-14 00:00:00 +0000"];
        NSDateFormatter *dateFormate = [[NSDateFormatter alloc] init];
        
        [dateFormate setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        [dateFormate setDateFormat:@"yyyy"];
        NSInteger year = [[dateFormate stringFromDate:myDate] integerValue];
        [dateFormate setDateFormat:@"MM"];
        NSInteger month = [[dateFormate stringFromDate:myDate] integerValue];
        [dateFormate setDateFormat:@"dd"];
        NSInteger day = [[dateFormate stringFromDate:myDate] integerValue];
        [dateFormate setDateFormat:@"HH"];
        NSInteger hour = [[dateFormate stringFromDate:myDate] integerValue];
        [dateFormate setDateFormat:@"mm"];
        NSInteger minute = [[dateFormate stringFromDate:myDate] integerValue];
        [dateFormate setDateFormat:@"ss"];
        CGFloat second = [[dateFormate stringFromDate:myDate] doubleValue];
        
        
        AADate *mainDate = [AADate dateWithYear:year month:month day:day hour:hour minute:minute second:second inGregorianCalendar:YES];
        
        NSLog(@"%@", myDate);
        NSLog(@"%@", [dateFormate timeZone]);
        NSLog(@"%f", mainDate.julianDay);
        NSLog(@"Current date: %ld-%ld-%ld %ld:%ld:%ld", (long)[mainDate year], [mainDate month], [mainDate day], [mainDate hour], [mainDate minute], (long)[mainDate second]);
        CGFloat k = [AAMoonPhases calculateKFromDecimalYear:[mainDate fractionalYear]];
        CGFloat kNewMoon = [AAHelpers toInt:k];
        
        CGFloat julianDayNewMoon = [AAMoonPhases truePhaseFromK:kNewMoon];
        CGFloat julianDayNextNewMoon = [AAMoonPhases truePhaseFromK:kNewMoon + 1];

        AADate *newMoon = [[AADate alloc] initWithJulianDay:julianDayNewMoon inGregorianCalendar:YES];

        
        NSString *currentStrDate = [NSString stringWithFormat:@"%.4ld-%.2ld-%.2ld %.2ld:%.2ld:%.2d", [newMoon year], [newMoon month], [newMoon day], [newMoon hour], [newMoon minute], (int)[newMoon second]];
//        [dateFormate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *dateNewMoon = [NSDate dateWithString:[currentStrDate stringByAppendingString:@" +0000"]];
//        dateNewMoon = [dateFormate dateFromString:currentStrDate];
        

        NSLog(@"%@", dateNewMoon);
        NSLog(@"%@", currentStrDate);
        NSLog(@"New moon date GMT: %ld-%.2ld-%ld %ld:%ld:%f", [newMoon year], [newMoon month], [newMoon day], [newMoon hour], [newMoon minute], [newMoon second]);
        
        
        
        CGFloat riseHour = calcRiseHour(julianDayNewMoon);
        
        NSLog(@"%f", riseHour);
        CGFloat julianDay = [AAHelpers toInt:julianDayNewMoon + 0.5] - 0.5 + riseHour / 24;
        
        if (julianDay < julianDayNewMoon) {
            julianDay = [AAHelpers toInt:julianDayNewMoon + 1 + 0.5] - 0.5 + calcRiseHour(julianDayNewMoon + 1) / 24;
        }
        
        AADate *calcJulianDay = [[AADate alloc] initWithJulianDay:julianDay inGregorianCalendar:YES];
        NSLog(@"%ld-%.2ld-%.2ld %.2ld:%.2ld:%.2f", [calcJulianDay year], [calcJulianDay month], [calcJulianDay day], [calcJulianDay hour], [calcJulianDay minute], [calcJulianDay second]);
        
        while (julianDay < julianDayNextNewMoon) {
            julianDay = [AAHelpers toInt:julianDay + 1 + 0.5] - 0.5 + calcRiseHour(julianDay + 1) / 24;
            [calcJulianDay setDataByJulianDay:julianDay inGregorianCalendar:YES];
            NSLog(@"%ld-%.2ld-%.2ld %.2ld:%.2ld:%.2f", [calcJulianDay year], [calcJulianDay month], [calcJulianDay day], [calcJulianDay hour], [calcJulianDay minute], [calcJulianDay second]);
        }
    }
    return 0;
}

CGFloat calcRiseHour(CGFloat JD) {
    AARiseTransitSetDetails *details = [AARiseTransitSetDetails riseTransitSetDetails];
    CGFloat julianDay = [AAHelpers toInt:JD + 0.5];
    AA2DCoordinate *lastMoonPosition = [AACoordinateTransformation eclipticToEquatorialByEclipticLongitude:[AAMoon eclipticLongitude:julianDay - 1] eclipticLatitude:[AAMoon eclipticLatitude:julianDay - 1] obliquityOfTheEcliptic:[AANutation trueObliquityOfEcliptic:julianDay - 1]];
    CGFloat lastRightAscension = lastMoonPosition.x;
    CGFloat lastDeclination = lastMoonPosition.y;
    AA2DCoordinate *presentMoonPosition = [AACoordinateTransformation eclipticToEquatorialByEclipticLongitude:[AAMoon eclipticLongitude:julianDay] eclipticLatitude:[AAMoon eclipticLatitude:julianDay] obliquityOfTheEcliptic:[AANutation trueObliquityOfEcliptic:julianDay]];
    CGFloat presentRightAscension = presentMoonPosition.x;
    CGFloat presentDeclination = presentMoonPosition.y;
    AA2DCoordinate *nextMoonPosition = [AACoordinateTransformation eclipticToEquatorialByEclipticLongitude:[AAMoon eclipticLongitude:julianDay + 1] eclipticLatitude:[AAMoon eclipticLatitude:julianDay + 1] obliquityOfTheEcliptic:[AANutation trueObliquityOfEcliptic:julianDay + 1]];
    CGFloat nextRightAscension = nextMoonPosition.x;
    CGFloat nextDeclination = nextMoonPosition.y;
    
    
    //        CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    //        [locationManager startUpdatingLocation];
    //
    //        CLLocation *location = locationManager.location;
    //
    //        NSLog(@"Coordinates is %f %f %f %f",
    //              location.coordinate.latitude,
    //              location.coordinate.longitude,
    //              location.horizontalAccuracy,
    //              location.verticalAccuracy);
    //        NSLog(@"%@", location);
    
    
    CGFloat longitude = -[AACoordinateTransformation degreesFromDegrees:37 minutes:37 seconds:04];  //Moscow 37°37'04"E
    CGFloat latitude = [AACoordinateTransformation degreesFromDegrees:55 minutes:45 seconds:06];    //Moscow 55°45'06"N
    CGFloat altitude = [AAMoon horizontalParallaxFromRadiusVector:[AAMoon radiusVector:julianDay]];
    details = [AARiseTransitSet calculateForJulianDay:julianDay lastRightAscension:lastRightAscension lastDeclination:lastDeclination presentRightAscension:presentRightAscension presentDeclination:presentDeclination nextRightAscension:nextRightAscension nextDeclination:nextDeclination longitude:longitude latitude:latitude altitude:altitude];
    return details.rise;    
}


