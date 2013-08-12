//
//  AAMoonPhases.m
//  AAPlus
//
//  Created by Logger 1 on 22.07.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

#import "AAMoonPhases.h"
#import "AACoordinateTransformation.h"

@implementation AAMoonPhases

+(CGFloat)calculateKFromDecimalYear:(CGFloat)year{
    return 12.3685*(year - 2000);
}

+(CGFloat)meanPhaseFromK:(CGFloat)k{
    CGFloat t = k/1236.85;
    CGFloat t2 = t*t;
    CGFloat t3 = t2*t;
    CGFloat t4 = t3*t;
    
    return 2451550.09766 + 29.530588861*k + 0.00015437*t2 - 0.000000150*t3 + 0.00000000073*t4;
}

+(CGFloat)truePhaseFromK:(CGFloat)k{
    CGFloat julianDay = [self meanPhaseFromK:k];
    
    CGFloat t = k/1236.85;
    CGFloat t2 = t*t;
    CGFloat t3 = t2*t;
    CGFloat t4 = t3*t;
    
    CGFloat e = 1 - 0.002516*t - 0.0000074*t2;
    CGFloat e2 = e*e;
    
    CGFloat m = 2.5534 + 29.10535670*k - 0.0000014*t2 - 0.00000011*t3;
    m = [AACoordinateTransformation degreesToRadian:[AACoordinateTransformation mapTo0To360Degrees:m]];
    CGFloat mdash = 201.5643 + 385.81693528*k + 0.0107582*t2 + 0.00001238*t3 - 0.000000058*t4;
    mdash = [AACoordinateTransformation degreesToRadian:[AACoordinateTransformation mapTo0To360Degrees:mdash]];
    CGFloat f = 160.7108 + 390.67050284*k - 0.0016118*t2 - 0.00000227*t3 + 0.000000011*t4;
    f = [AACoordinateTransformation degreesToRadian:[AACoordinateTransformation mapTo0To360Degrees:f]];
    CGFloat omega = 124.7746 - 1.56375588*k + 0.0020672*t2 + 0.00000215*t3;
    omega = [AACoordinateTransformation degreesToRadian:[AACoordinateTransformation mapTo0To360Degrees:omega]];
    CGFloat a1 = 299.77 + 0.107408*k - 0.009173*t2;
    a1 = [AACoordinateTransformation degreesToRadian:[AACoordinateTransformation mapTo0To360Degrees:a1]];
    CGFloat a2 = 251.88 + 0.016321*k;
    a2 = [AACoordinateTransformation degreesToRadian:[AACoordinateTransformation mapTo0To360Degrees:a2]];
    CGFloat a3 = 251.83 + 26.651886*k;
    a3 = [AACoordinateTransformation degreesToRadian:[AACoordinateTransformation mapTo0To360Degrees:a3]];
    CGFloat a4 = 349.42 + 36.412478*k;
    a4 = [AACoordinateTransformation degreesToRadian:[AACoordinateTransformation mapTo0To360Degrees:a4]];
    CGFloat a5 = 84.66 + 18.206239*k;
    a5 = [AACoordinateTransformation degreesToRadian:[AACoordinateTransformation mapTo0To360Degrees:a5]];
    CGFloat a6 = 141.74 + 53.303771*k;
    a6 = [AACoordinateTransformation degreesToRadian:[AACoordinateTransformation mapTo0To360Degrees:a6]];
    CGFloat a7 = 207.14 + 2.453732*k;
    a7 = [AACoordinateTransformation degreesToRadian:[AACoordinateTransformation mapTo0To360Degrees:a7]];
    CGFloat a8 = 154.84 + 7.306860*k;
    a8 = [AACoordinateTransformation degreesToRadian:[AACoordinateTransformation mapTo0To360Degrees:a8]];
    CGFloat a9 = 34.52 + 27.261239*k;
    a9 = [AACoordinateTransformation degreesToRadian:[AACoordinateTransformation mapTo0To360Degrees:a9]];
    CGFloat a10 = 207.19 + 0.121824*k;
    a10 = [AACoordinateTransformation degreesToRadian:[AACoordinateTransformation mapTo0To360Degrees:a10]];
    CGFloat a11 = 291.34 + 1.844379*k;
    a11 = [AACoordinateTransformation degreesToRadian:[AACoordinateTransformation mapTo0To360Degrees:a11]];
    CGFloat a12 = 161.72 + 24.198154*k;
    a12 = [AACoordinateTransformation degreesToRadian:[AACoordinateTransformation mapTo0To360Degrees:a12]];
    CGFloat a13 = 239.56 + 25.513099*k;
    a13 = [AACoordinateTransformation degreesToRadian:[AACoordinateTransformation mapTo0To360Degrees:a13]];
    CGFloat a14 = 331.55 + 3.592518*k;
    a14 = [AACoordinateTransformation degreesToRadian:[AACoordinateTransformation mapTo0To360Degrees:a14]];
    
    CGFloat kInt;
    CGFloat kFrac = modf(k, &kInt);
    if (kFrac < 0) {
        kFrac++;
    }
    if (kFrac == 0) {
        CGFloat deltaJulianDay = -0.40720*sin(mdash) +
                0.17241*e*sin(m) +
                0.01608*sin(2*mdash) +
                0.01039*sin(2*f) +
                0.00739*e*sin(mdash - m) +
                -0.00514*e*sin(mdash + m) +
                0.00208*e2*sin(2*m) +
                -0.00111*sin(mdash - 2*f) +
                -0.00057*sin(mdash + 2*f) +
                0.00056*e*sin(2*mdash + m) +
                -0.00042*sin(3*mdash) +
                0.00042*e*sin(m + 2*f) +
                0.00038*e*sin(m - 2*f) +
                -0.00024*e*sin(2*mdash - m) +
                -0.00017*sin(omega) +
                -0.00007*sin(mdash + 2*m) +
                0.00004*sin(2*mdash - 2*f) +
                0.00004*sin(3*m) +
                0.00003*sin(mdash + m - 2*f) +
                0.00003*sin(2*mdash + 2*f) +
                -0.00003*sin(mdash + m + 2*f) +
                0.00003*sin(mdash - m + 2*f) +
                -0.00002*sin(mdash - m - 2*f) +
                -0.00002*sin(3*mdash + m) +
                0.00002*sin(4*mdash);
        julianDay += deltaJulianDay;
    } else if ((kFrac == 0.25) || (kFrac == 0.75)) {
        CGFloat deltaJulianDay = -0.62801*sin(mdash) +
                0.17172*e*sin(m) +
                -0.01183*e*sin(mdash + m) +
                0.00862*sin(2*mdash) +
                0.00804*sin(2*m) +
                0.00454*e*sin(mdash - m) +
                0.00204*e2*sin(2*m) +
                -0.00180*sin(mdash - 2*f) +
                -0.00070*sin(mdash + 2*f) +
                -0.00040*sin(3*mdash) +
                -0.00034*e*sin(2*mdash - m) +
                0.00032*e*sin(m + 2*f) +
                0.00032*e*sin(m - 2*f) +
                -0.00028*e2*sin(mdash + 2*m) +
                0.00027*e*sin(2*mdash + m) +
                -0.00017*sin(omega) +
                -0.00005*sin(mdash - m - 2*f) +
                0.00004*sin(2*mdash + 2*f) +
                -0.00004*sin(mdash + m + 2*f) +
                0.00004*sin(mdash - 2*m) +
                0.00003*sin(mdash + m - 2*f) +
                0.00003*sin(3*m) +
                0.00002*sin(2*mdash - 2*f) +
                0.00002*sin(mdash - m + 2*f) +
                -0.00002*sin(3*mdash + m);
        julianDay += deltaJulianDay;
        
        CGFloat w = 0.00306 - 0.00038*e*cos(m) + 0.00026*cos(mdash) - 0.00002*cos(mdash - m) + 0.00002*cos(mdash + m) + 0.00002*cos(2*f);
        
        if (kFrac == 0.25) {
            julianDay += w;
        } else {
            julianDay -= w;
        }
    } else if (kFrac == 0.5) {
        CGFloat deltaJulianDay = -0.40614*sin(mdash) +
                0.17302*e*sin(m) +
                0.01614*sin(2*mdash) +
                0.01043*sin(2*f) +
                0.00734*e*sin(mdash - m) +
                -0.00514*e*sin(mdash + m) +
                0.00209*e2*sin(2*m) +
                -0.00111*sin(mdash - 2*m) +
                -0.00057*sin(mdash + 2*m) +
                0.00056*e*sin(2*mdash + m) +
                -0.00042*sin(3*mdash) +
                0.00042*e*sin(m + 2*f) +
                0.00038*e*sin(m - 2*f) +
                -0.00024*e*sin(2*mdash - m) +
                -0.00017*sin(omega) +
                -0.00007*sin(mdash + 2*m) +
                0.00004*sin(2*mdash - 2*f) +
                0.00004*sin(3*m) +
                0.00003*sin(mdash + m - 2*f) +
                0.00003*sin(2*mdash + 2*f) +
                -0.00003*sin(mdash + m + 2*f) +
                0.00003*sin(mdash - m + 2*f) +
                -0.00002*sin(mdash - m - 2*f) +
                -0.00002*sin(3*mdash + m) +
                0.00002*sin(4*mdash);
        julianDay += deltaJulianDay;
    } else {
//        [NSAssert(NO, @"")];
    }
    
    CGFloat deltaJulianDay2 = 0.000325*sin(a1) +
            0.000165*sin(a2) +
            0.000164*sin(a3) +
            0.000126*sin(a4) +
            0.000110*sin(a5) +
            0.000062*sin(a6) +
            0.000060*sin(a7) +
            0.000056*sin(a8) +
            0.000047*sin(a9) +
            0.000042*sin(a10) +
            0.000040*sin(a11) +
            0.000037*sin(a12) +
            0.000035*sin(a13) +
            0.000023*sin(a14);
    julianDay += deltaJulianDay2;
    
    return julianDay;
}

@end
