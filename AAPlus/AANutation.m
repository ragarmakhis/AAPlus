//
//  AANutation.m
//  AAPlus
//
//  Created by Logger 1 on 27.07.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

#import "AANutation.h"
#import "AACoordinateTransformation.h"

struct NutationCoefficient
{
    int d;
    int m;
    int mPrime;
    int f;
    int omega;
    int sincoeff1;
    double sincoeff2;
    int coscoeff1;
    double coscoeff2;
};

const struct NutationCoefficient nutationCoefficients[] =
{
    {  0,  0,  0,  0,  1, -171996,  -174.2,  92025,     8.9    },
    { -2,  0,  0,  2,  2,  -13187,    -1.6,   5736,    -3.1    },
    {  0,  0,  0,  2,  2,   -2274,    -0.2,    977,    -0.5    },
    {  0,  0,  0,  0,  2,    2062,     0.2,   -895,     0.5    },
    {  0,  1,  0,  0,  0,    1426,    -3.4,     54,    -0.1    },
    {  0,  0,  1,  0,  0,     712,     0.1,     -7,       0    },
    { -2,  1,  0,  2,  2,    -517,     1.2,    224,    -0.6    },
    {  0,  0,  0,  2,  1,    -386,    -0.4,    200,       0    },
    {  0,  0,  1,  2,  2,    -301,       0,    129,    -0.1    },
    { -2, -1,  0,  2,  2,     217,    -0.5,    -95,     0.3    },
    { -2,  0,  1,  0,  0,    -158,       0,      0,       0    },
    { -2,  0,  0,  2,  1,     129,     0.1,    -70,       0    },
    {  0,  0, -1,  2,  2,     123,       0,    -53,       0    },
    {  2,  0,  0,  0,  0,      63,       0,      0,       0    },
    {  0,  0,  1,  0,  1,      63,     0.1,    -33,       0    },
    {  2,  0, -1,  2,  2,     -59,       0,     26,       0    },
    {  0,  0, -1,  0,  1,     -58,    -0.1,     32,       0    },
    {  0,  0,  1,  2,  1,     -51,       0,     27,       0    },
    { -2,  0,  2,  0,  0,      48,       0,      0,       0    },
    {  0,  0, -2,  2,  1,      46,       0,    -24,       0    },
    {  2,  0,  0,  2,  2,     -38,       0,     16,       0    },
    {  0,  0,  2,  2,  2,     -31,       0,     13,       0    },
    {  0,  0,  2,  0,  0,      29,       0,      0,       0    },
    { -2,  0,  1,  2,  2,      29,       0,    -12,       0    },
    {  0,  0,  0,  2,  0,      26,       0,      0,       0    },
    { -2,  0,  0,  2,  0,     -22,       0,      0,       0    },
    {  0,  0, -1,  2,  1,      21,       0,    -10,       0    },
    {  0,  2,  0,  0,  0,      17,    -0.1,      0,       0    },
    {  2,  0, -1,  0,  1,      16,       0,     -8,       0    },
    { -2,  2,  0,  2,  2,     -16,     0.1,      7,       0    },
    {  0,  1,  0,  0,  1,     -15,       0,      9,       0    },
    { -2,  0,  1,  0,  1,     -13,       0,      7,       0    },
    {  0, -1,  0,  0,  1,     -12,       0,      6,       0    },
    {  0,  0,  2, -2,  0,      11,       0,      0,       0    },
    {  2,  0, -1,  2,  1,     -10,       0,      5,       0    },
    {  2,  0,  1,  2,  2,     -8,        0,      3,       0    },
    {  0,  1,  0,  2,  2,      7,        0,     -3,       0    },
    { -2,  1,  1,  0,  0,     -7,        0,      0,       0    },
    {  0, -1,  0,  2,  2,     -7,        0,      3,       0    },
    {  2,  0,  0,  2,  1,     -7,        0,      3,       0    },
    {  2,  0,  1,  0,  0,      6,        0,      0,       0    },
    { -2,  0,  2,  2,  2,      6,        0,     -3,       0    },
    { -2,  0,  1,  2,  1,      6,        0,     -3,       0    },
    {  2,  0, -2,  0,  1,     -6,        0,      3,       0    },
    {  2,  0,  0,  0,  1,     -6,        0,      3,       0    },
    {  0, -1,  1,  0,  0,      5,        0,      0,       0    },
    { -2, -1,  0,  2,  1,     -5,        0,      3,       0    },
    { -2,  0,  0,  0,  1,     -5,        0,      3,       0    },
    {  0,  0,  2,  2,  1,     -5,        0,      3,       0    },
    { -2,  0,  2,  0,  1,      4,        0,      0,       0    },
    { -2,  1,  0,  2,  1,      4,        0,      0,       0    },
    {  0,  0,  1, -2,  0,      4,        0,      0,       0    },
    { -1,  0,  1,  0,  0,     -4,        0,      0,       0    },
    { -2,  1,  0,  0,  0,     -4,        0,      0,       0    },
    {  1,  0,  0,  0,  0,     -4,        0,      0,       0    },
    {  0,  0,  1,  2,  0,      3,        0,      0,       0    },
    {  0,  0, -2,  2,  2,     -3,        0,      0,       0    },
    { -1, -1,  1,  0,  0,     -3,        0,      0,       0    },
    {  0,  1,  1,  0,  0,     -3,        0,      0,       0    },
    {  0, -1,  1,  2,  2,     -3,        0,      0,       0    },
    {  2, -1, -1,  2,  2,     -3,        0,      0,       0    },
    {  0,  0,  3,  2,  2,     -3,        0,      0,       0    },
    {  2, -1,  0,  2,  2,     -3,        0,      0,       0    },
};

@implementation AANutation


+(CGFloat)nutationInLongitude:(CGFloat)julianDay{
    CGFloat t = (julianDay - 2451545) / 36525;
    CGFloat t2 = t*t;
    CGFloat t3 = t2*t;
    
    CGFloat d = 297.85036 + 445267.111480*t - 0.0019142*t2 + t3 / 189474;
    d = [AACoordinateTransformation mapTo0To360Degrees:d];
    
    CGFloat m = 357.52772 + 35999.050340*t - 0.0001603*t2 - t3 / 300000;
    m = [AACoordinateTransformation mapTo0To360Degrees:m];
    
    CGFloat mPrime = 134.96298 + 477198.867398*t + 0.0086972*t2 + t3 / 56250;
    mPrime = [AACoordinateTransformation mapTo0To360Degrees:mPrime];
    
    CGFloat f = 93.27191 + 483202.017538*t - 0.0036825*t2 + t3 / 327270;
    f = [AACoordinateTransformation mapTo0To360Degrees:f];
    
    CGFloat omega = 125.04452 - 1934.136261*t + 0.0020708*t2 + t3 / 450000;
    omega = [AACoordinateTransformation mapTo0To360Degrees:omega];
    
    CGFloat value = 0;
    int coefficientsCount = sizeof(nutationCoefficients) / sizeof(struct NutationCoefficient);
    for (int i = 0; i < coefficientsCount; i++) {
        CGFloat argument = nutationCoefficients[i].d * d + nutationCoefficients[i].m * m + nutationCoefficients[i].mPrime * mPrime + nutationCoefficients[i].f * f + nutationCoefficients[i].omega * omega;;
        CGFloat radargument = [AACoordinateTransformation degreesToRadian:argument];
        value += (nutationCoefficients[i].sincoeff1 + nutationCoefficients[i].sincoeff2 * t) * sin(radargument) * 0.0001;
    }
    
    return value;
}

+(CGFloat)nutationInObliquity:(CGFloat)julianDay{
    CGFloat t = (julianDay - 2451545) / 36525;
    CGFloat t2 = t*t;
    CGFloat t3 = t2*t;
    
    CGFloat d = 297.85036 + 445267.111480*t - 0.0019142*t2 + t3 / 189474;
    d = [AACoordinateTransformation mapTo0To360Degrees:d];
    
    CGFloat m = 357.52772 + 35999.050340*t - 0.0001603*t2 - t3 / 300000;
    m = [AACoordinateTransformation mapTo0To360Degrees:m];
    
    CGFloat mPrime = 134.96298 + 477198.867398*t + 0.0086972*t2 + t3 / 56250;
    mPrime = [AACoordinateTransformation mapTo0To360Degrees:mPrime];
    
    CGFloat f = 93.27191 + 483202.017538*t - 0.0036825*t2 + t3 / 327270;
    f = [AACoordinateTransformation mapTo0To360Degrees:f];
    
    CGFloat omega = 125.04452 - 1934.136261*t + 0.0020708*t2 + t3 / 450000;
    omega = [AACoordinateTransformation mapTo0To360Degrees:omega];
    
    CGFloat value = 0;
    int coefficientsCount = sizeof(nutationCoefficients) / sizeof(struct NutationCoefficient);
    for (int i = 0; i < coefficientsCount; i++) {
        CGFloat argument = nutationCoefficients[i].d * d + nutationCoefficients[i].m * m + nutationCoefficients[i].mPrime * mPrime + nutationCoefficients[i].f * f + nutationCoefficients[i].omega * omega;;
        CGFloat radargument = [AACoordinateTransformation degreesToRadian:argument];
        value += (nutationCoefficients[i].coscoeff1 + nutationCoefficients[i].coscoeff2 * t) * cos(radargument) * 0.0001;
    }
    
    return value;
}

+(CGFloat)meanObliquityOfEcliptic:(CGFloat)julianDay{
    CGFloat u = (julianDay - 2451545) / 3652500;
    CGFloat u2 = u*u;
    CGFloat u3 = u2*u;
    CGFloat u4 = u3*u;
    CGFloat u5 = u4*u;
    CGFloat u6= u5*u;
    CGFloat u7 = u6*u;
    CGFloat u8 = u7*u;
    CGFloat u9 = u8*u;
    CGFloat u10 = u9*u;
    
    return [AACoordinateTransformation degreesFromDegrees:23 minutes:26 seconds:21.448] - [AACoordinateTransformation degreesFromDegrees:0 minutes:0 seconds:4680.93] * u
                                                                                                       - [AACoordinateTransformation degreesFromDegrees:0 minutes:0 seconds:1.55] * u2
                                                                                                       + [AACoordinateTransformation degreesFromDegrees:0 minutes:0 seconds:1999.25] * u3
                                                                                                       - [AACoordinateTransformation degreesFromDegrees:0 minutes:0 seconds:51.38] * u4
                                                                                                       - [AACoordinateTransformation degreesFromDegrees:0 minutes:0 seconds:249.67] * u5
                                                                                                       - [AACoordinateTransformation degreesFromDegrees:0 minutes:0 seconds:39.05] * u6
                                                                                                       + [AACoordinateTransformation degreesFromDegrees:0 minutes:0 seconds:7.12] * u7
                                                                                                       + [AACoordinateTransformation degreesFromDegrees:0 minutes:0 seconds:27.87] * u8
                                                                                                       + [AACoordinateTransformation degreesFromDegrees:0 minutes:0 seconds:5.79] * u9
                                                                                                       + [AACoordinateTransformation degreesFromDegrees:0 minutes:0 seconds:2.45] * u10;
    
}

+(CGFloat)trueObliquityOfEcliptic:(CGFloat)julianDay{
    return [self meanObliquityOfEcliptic:julianDay] + [AACoordinateTransformation degreesFromDegrees:0 minutes:0 seconds:[self nutationInObliquity:julianDay] inPositive:YES];
}

+(CGFloat)nutationInRightAscensionByRightAscension:(CGFloat)alpha declination:(CGFloat)delta obliquity:(CGFloat)obliquity nutationInLongitude:(CGFloat)nutationInLongitude nutationInObliquity:(CGFloat)nutationInObliquity{
    alpha = [AACoordinateTransformation hoursToRadian:alpha];
    delta = [AACoordinateTransformation degreesToRadian:delta];
    obliquity = [AACoordinateTransformation degreesToRadian:obliquity];
    
    return (cos(obliquity) + sin(obliquity) * sin(alpha) * tan(delta)) * nutationInLongitude - cos(alpha) * tan(delta) * nutationInObliquity;
}

+(CGFloat)nutationInDeclinationByRightAscension:(CGFloat)alpha obliquity:(CGFloat)obliquity nutationInLongitude:(CGFloat)nutationInLongitude nutationInObliquity:(CGFloat)nutationInObliquity{
    alpha = [AACoordinateTransformation hoursToRadian:alpha];
    obliquity = [AACoordinateTransformation degreesToRadian:obliquity];
    
    return sin(obliquity) * cos(alpha) * nutationInLongitude + sin(alpha) * nutationInObliquity;
}

@end
