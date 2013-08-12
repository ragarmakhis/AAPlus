//
//  AARiseTransitSet.m
//  AAPlus
//
//  Created by Logger 1 on 27.07.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

#import "AARiseTransitSet.h"
#import "AASidereal.h"
#import "AADynamicalTime.h"
#import "AACoordinateTransformation.h"
#import "AAInterpolate.h"
#import "AA2DCoordinate.h"

@implementation AARiseTransitSet

+(AARiseTransitSetDetails *)calculateForJulianDay:(CGFloat)julianDay lastRightAscension:(CGFloat)alpha1 lastDeclination:(CGFloat)delta1 presentRightAscension:(CGFloat)alpha2 presentDeclination:(CGFloat)delta2 nextRightAscension:(CGFloat)alpha3 nextDeclination:(CGFloat)delta3 longitude:(CGFloat)longitude latitude:(CGFloat)latitude altitude:(CGFloat)h0{
    
    //What will be the return value
    AARiseTransitSetDetails *details = [AARiseTransitSetDetails riseTransitSetDetails];
    
    //Calculate the sidereal time
    CGFloat theta0 = [AASidereal apparentGreenwichSiderealTimeFromJulianDay:julianDay];
    theta0 *= 15;//Express it as degrees
    
    //Calculate deltat
    CGFloat deltaT = [AADynamicalTime deltaT:julianDay];
    
    //Convert values to radians
    CGFloat delta2InRadian = [AACoordinateTransformation degreesToRadian:delta2];
    CGFloat latitudeInRadian = [AACoordinateTransformation degreesToRadian:latitude];
    
    //Convert the standard altitude to radians
    CGFloat h0InRadian = [AACoordinateTransformation degreesToRadian:h0];
    
    //Calculate cosH0
    CGFloat cosH0 = (sin(h0InRadian) - sin(latitudeInRadian) * sin(delta2InRadian)) / (cos(latitudeInRadian) * cos(delta2InRadian));
    
    //Calculate M0
    CGFloat m0 = [self calculateTransitByPresentRightAscension:alpha2 sideralTime:theta0 longtitude:longitude];
    
    //Calculate M1 & M2
    CGFloat m1 = 0;
    CGFloat m2 = 0;
    [self calculateRiseSetByM0:m0 cosH0:cosH0 riseTransitSetDetailes:details m1:&m1 m2:&m2];
    
    //Ensure the RA values are corrected for interpolation. Due to important Remark 2 by Meeus on Interopolation of RA values
    [self correctRightAscensionValuesForInterpolationByLastRightAscension:&alpha1 presentRightAscension:&alpha2 nextRightAscension:&alpha3];
    
    //Do the main work
    [self calculateTransitHelperBySideralTime:theta0 deltaT:deltaT lastRightAscension:alpha1 presentRightAscension:alpha2 nextRightAscension:alpha3 longitude:longitude m0:&m0];
    [self calculateRiseHelperByRiseTransitSetDetailes:details sideralTime:theta0 deltaT:deltaT lastRightAscension:alpha1 lastDeclination:delta1 presentRightAscension:alpha2 presentDeclination:delta2 nextRightAscension:alpha3 nextDeclination:delta3 longitude:longitude latitude:latitude latitudeInRadian:latitudeInRadian altitude:h0 m1:&m1];
    [self calculateSetHelperByRiseTransitSetDetailes:details sideralTime:theta0 deltaT:deltaT lastRightAscension:alpha1 lastDeclination:delta1 presentRightAscension:alpha2 presentDeclination:delta2 nextRightAscension:alpha3 nextDeclination:delta3 longitude:longitude latitude:latitude latitudeInRadian:latitudeInRadian altitude:h0 m2:&m2];
    
    details.rise = details.riseValid ? (m1 * 24) : 0.0;
    details.set = details.setValid ? (m2 * 24) : 0.0;
    details.transit = m0 * 24; //We always return the transit time even if it occurs below the horizon
    
    return details;
}

+(CGFloat)calculateTransitByPresentRightAscension:(CGFloat)alpha2 sideralTime:(CGFloat)theta0 longtitude:(CGFloat)longtitude{
    //Calculate and ensure the M0 is in the range 0 to +1
    CGFloat m0 = (alpha2 * 15 + longtitude - theta0) / 360;
    return [self constraintM:m0];
}

+(void)calculateRiseSetByM0:(CGFloat)m0 cosH0:(CGFloat)cosH0 riseTransitSetDetailes:(AARiseTransitSetDetails *)detailes m1:(CGFloat *)m1 m2:(CGFloat *)m2{
    *m1 = 0;
    *m2 = 0;
    
    if ((cosH0 > -1) && (cosH0 < 1)) {
        detailes.riseValid = YES;
        detailes.setValid = YES;
        detailes.transitAboveHorizon = YES;
        
        CGFloat h0 = acos(cosH0);
        h0 = [AACoordinateTransformation radianToDegrees:h0];
        
        //Calculate and ensure the M1 and M2 is in the range 0 to +1
        *m1 = m0 - h0/360;
        *m2 = m0 + h0/360;
        
        *m1 = [self constraintM:*m1];
        *m2 = [self constraintM:*m2];
    } else if (cosH0 < 1) {
        detailes.transitAboveHorizon = YES;
    }
    
}

+(void)correctRightAscensionValuesForInterpolationByLastRightAscension:(CGFloat *)alpha1 presentRightAscension:(CGFloat *)alpha2 nextRightAscension:(CGFloat *)alpha3{
    //Ensure the RA values are corrected for interpolation. Due to important Remark 2 by Meeus on Interopolation of RA values
    if ((*alpha2 - *alpha1) > 12.0) {
        *alpha1 += 24;
    } else if ((*alpha2 - *alpha1) < -12.0) {
        *alpha2 += 24;
    }
    if ((*alpha3 - *alpha2) > 12.0) {
        *alpha2 += 24;
    } else if ((*alpha3 - *alpha2) < -12.0) {
        *alpha3 += 24;
    }
}

+(void)calculateTransitHelperBySideralTime:(CGFloat)theta0 deltaT:(CGFloat)deltaT lastRightAscension:(CGFloat)alpha1 presentRightAscension:(CGFloat)alpha2 nextRightAscension:(CGFloat)alpha3 longitude:(CGFloat)longitude m0:(CGFloat *)m0{
    for (int i = 0; i < 2; i++) {
        //Calculate the details of transit
        CGFloat theta1 = theta0 + 360.985647 * *m0;
        theta1 = [AACoordinateTransformation mapTo0To360Degrees:theta1];
        
        CGFloat n = *m0 + deltaT/86400;
        
        CGFloat alpha = [AAInterpolate interpolateByN:n y1:alpha1 y2:alpha2 y3:alpha3];
        
        CGFloat h = theta1 - longitude - alpha * 15;
        h = [AACoordinateTransformation mapTo0To360Degrees:h];
        if (h > 180) {
            h -= 360;
        }
        
        CGFloat deltaM  = -h / 360;
        *m0 += deltaM;
    }
}

+(void)calculateRiseHelperByRiseTransitSetDetailes:(AARiseTransitSetDetails *)detailes sideralTime:(CGFloat)theta0 deltaT:(CGFloat)deltaT lastRightAscension:(CGFloat)alpha1 lastDeclination:(CGFloat)delta1 presentRightAscension:(CGFloat)alpha2 presentDeclination:(CGFloat)delta2 nextRightAscension:(CGFloat)alpha3 nextDeclination:(CGFloat)delta3 longitude:(CGFloat)longitude latitude:(CGFloat)latitude latitudeInRadian:(CGFloat)latitudeInRad altitude:(CGFloat)h0 m1:(CGFloat *)m1{
    for (int i=0; i<2; i++) {
        //Calculate the details of rising
        if (detailes.riseValid) {
            CGFloat theta1 = theta0 + 360.985647 * *m1;
            theta1 = [AACoordinateTransformation mapTo0To360Degrees:theta1];
            
            CGFloat n = *m1 + deltaT/86400;
            
            CGFloat alpha = [AAInterpolate interpolateByN:n y1:alpha1 y2:alpha2 y3:alpha3];
            CGFloat delta = [AAInterpolate interpolateByN:n y1:delta1 y2:delta2 y3:delta3];
            
            CGFloat h = theta1 - longitude - alpha * 15;
            AA2DCoordinate *horizontal = [AA2DCoordinate coordinate];
            horizontal = [AACoordinateTransformation equatorialToHorizontalBylocalHourAngle:h/15 declination:delta standardLatitude:latitude];
            
            CGFloat deltaM  = (horizontal.y - h0) / (360 * cos([AACoordinateTransformation degreesToRadian:delta])*cos(latitudeInRad)*sin([AACoordinateTransformation degreesToRadian:h]));
            *m1 += deltaM;
        }
    }
}

+(void)calculateSetHelperByRiseTransitSetDetailes:(AARiseTransitSetDetails *)detailes sideralTime:(CGFloat)theta0 deltaT:(CGFloat)deltaT lastRightAscension:(CGFloat)alpha1 lastDeclination:(CGFloat)delta1 presentRightAscension:(CGFloat)alpha2 presentDeclination:(CGFloat)delta2 nextRightAscension:(CGFloat)alpha3 nextDeclination:(CGFloat)delta3 longitude:(CGFloat)longitude latitude:(CGFloat)latitude latitudeInRadian:(CGFloat)latitudeInRad altitude:(CGFloat)h0 m2:(CGFloat *)m2{
    for (int i=0; i<2; i++) {
        //Calculate the details of setting
        if (detailes.setValid) {
            CGFloat theta1 = theta0 + 360.985647 * *m2;
            theta1 = [AACoordinateTransformation mapTo0To360Degrees:theta1];
            
            CGFloat n = *m2 + deltaT/86400;
            
            CGFloat alpha = [AAInterpolate interpolateByN:n y1:alpha1 y2:alpha2 y3:alpha3];
            CGFloat delta = [AAInterpolate interpolateByN:n y1:delta1 y2:delta2 y3:delta3];
            
            CGFloat h = theta1 - longitude - alpha * 15;
            AA2DCoordinate *horizontal = [AA2DCoordinate coordinate];
            horizontal = [AACoordinateTransformation equatorialToHorizontalBylocalHourAngle:h/15 declination:delta standardLatitude:latitude];
            
            CGFloat deltaM  = (horizontal.y - h0) / (360 * cos([AACoordinateTransformation degreesToRadian:delta])*cos(latitudeInRad)*sin([AACoordinateTransformation degreesToRadian:h]));
            *m2 += deltaM;
        }
    }
}

+(CGFloat)constraintM:(CGFloat)m{
    while (m > 1) {
        m -= 1;
    }
    while (m < 0) {
        m += 1;
    }
    return m;
}

@end
