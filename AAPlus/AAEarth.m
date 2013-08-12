//
//  AAEarth.m
//  AAPlus
//
//  Created by Logger 1 on 10.08.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

#import "AAEarth.h"
#import "AACoordinateTransformation.h"

struct VSOP87Coefficient
{
    CGFloat a;
    CGFloat b;
    CGFloat c;
};

const struct VSOP87Coefficient l0EarthCoefficients[] =
{
    { 175347046, 0,         0 },
    { 3341656,   4.6692568, 6283.0758500 },
    { 34894,     4.62610,   12566.15170 },
    { 3497,      2.7441,    5753.3849 },
    { 3418,      2.8289,    3.5231 },
    { 3136,      3.6277,    77713.7715 },
    { 2676,      4.4181,    7860.4194 },
    { 2343,      6.1352,    3930.2097 },
    { 1324,      0.7425,    11506.7698 },
    { 1273,      2.0371,    529.6910 },
    { 1199,      1.1096,    1577.3435 },
    { 990,       5.233,     5884.927 },
    { 902,       2.045,     26.298 },
    { 857,       3.508,     398.149 },
    { 780,       1.179,     5223.694 },
    { 753,       2.533,     5507.553 },
    { 505,       4.583,     18849.228 },
    { 492,       4.205,     775.523 },
    { 357,       2.920,     0.067 },
    { 317,       5.849,     11790.629 },
    { 284,       1.899,     796.288 },
    { 271,       0.315,     10977.079 },
    { 243,       0.345,     5486.778 },
    { 206,       4.806,     2544.314 },
    { 205,       1.869,     5573.143 },
    { 202,       2.458,     6069.777 },
    { 156,       0.833,     213.299 },
    { 132,       3.411,     2942.463 },
    { 126,       1.083,     20.775 },
    { 115,       0.645,     0.980 },
    { 103,       0.636,     4694.003 },
    { 102,       0.976,     15720.839 },
    { 102,       4.267,     7.114 },
    { 99,        6.21,      2146.17 },
    { 98,        0.68,      155.42 },
    { 86,        5.98,      161000.69 },
    { 85,        1.30,      6275.96 },
    { 85,        3.67,      71430.70 },
    { 80,        1.81,      17260.15 },
    { 79,        3.04,      12036.46 },
    { 75,        1.76,      5088.63 },
    { 74,        3.50,      3154.69 },
    { 74,        4.68,      801.82 },
    { 70,        0.83,      9437.76 },
    { 62,        3.98,      8827.39 },
    { 61,        1.82,      7084.90 },
    { 57,        2.78,      6286.60 },
    { 56,        4.39,      14143.50 },
    { 56,        3.47,      6279.55 },
    { 52,        0.19,      12139.55 },
    { 52,        1.33,      1748.02 },
    { 51,        0.28,      5856.48 },
    { 49,        0.49,      1194.45 },
    { 41,        5.37,      8429.24 },
    { 41,        2.40,      19651.05 },
    { 39,        6.17,      10447.39 },
    { 37,        6.04,      10213.29 },
    { 37,        2.57,      1059.38 },
    { 36,        1.71,      2352.87 },
    { 36,        1.78,      6812.77 },
    { 33,        0.59,      17789.85 },
    { 30,        0.44,      83996.85 },
    { 30,        2.74,      1349.87 },
    { 25,        3.16,      4690.48 }
};

const struct VSOP87Coefficient l1EarthCoefficients[] =
{
    { 628331966747.0, 0,          0 },
    { 206059,         2.678235,   6283.075850 },
    { 4303,           2.6351,     12566.1517 },
    { 425,            1.590,      3.523 },
    { 119,            5.796,      26.298 },
    { 109,            2.966,      1577.344 },
    { 93,             2.59,       18849.23 },
    { 72,             1.14,       529.69 },
    { 68,             1.87,       398.15 },
    { 67,             4.41,       5507.55 },
    { 59,             2.89,       5223.69 },
    { 56,             2.17,       155.42 },
    { 45,             0.40,       796.30 },
    { 36,             0.47,       775.52 },
    { 29,             2.65,       7.11 },
    { 21,             5.43,       0.98 },
    { 19,             1.85,       5486.78 },
    { 19,             4.97,       213.30 },
    { 17,             2.99,       6275.96 },
    { 16,             0.03,       2544.31 },
    { 16,             1.43,       2146.17 },
    { 15,             1.21,       10977.08 },
    { 12,             2.83,       1748.02 },
    { 12,             3.26,       5088.63 },
    { 12,             5.27,       1194.45 },
    { 12,             2.08,       4694.00 },
    { 11,             0.77,       553.57 },
    { 10,             1.30,       6286.60 },
    { 10,             4.24,       1349.87 },
    { 9,              2.70,       242.73 },
    { 9,              5.64,       951.72 },
    { 8,              5.30,       2352.87 },
    { 6,              2.65,       9437.76 },
    { 6,              4.67,       4690.48 }
};

const struct VSOP87Coefficient l2EarthCoefficients[] =
{
    { 52919,  0,      0 },
    { 8720,   1.0721, 6283.0758 },
    { 309,    0.867,  12566.152 },
    { 27,     0.05,   3.52 },
    { 16,     5.19,   26.30 },
    { 16,     3.68,   155.42 },
    { 10,     0.76,   18849.23 },
    { 9,      2.06,   77713.77 },
    { 7,      0.83,   775.52 },
    { 5,      4.66,   1577.34 },
    { 4,      1.03,   7.11 },
    { 4,      3.44,   5573.14 },
    { 3,      5.14,   796.30 },
    { 3,      6.05,   5507.55 },
    { 3,      1.19,   242.73 },
    { 3,      6.12,   529.69 },
    { 3,      0.31,   398.15 },
    { 3,      2.28,   553.57 },
    { 2,      4.38,   5223.69 },
    { 2,      3.75,   0.98 }
};

const struct VSOP87Coefficient l3EarthCoefficients[] =
{
    { 289, 5.844, 6283.076 },
    { 35,  0,     0 },
    { 17,  5.49,  12566.15 },
    { 3,   5.20,  155.42 },
    { 1,   4.72,  3.52 },
    { 1,   5.30,  18849.23 },
    { 1,   5.97,  242.73 }
};

const struct VSOP87Coefficient l4EarthCoefficients[] =
{
    { 114, 3.142,  0 },
    { 8,   4.13,   6283.08 },
    { 1,   3.84,   12566.15 }
};

const struct VSOP87Coefficient l5EarthCoefficients[] =
{
    { 1, 3.14, 0 },
};

const struct VSOP87Coefficient b0EarthCoefficients[] =
{
    { 280, 3.199, 84334.662 },
    { 102, 5.422, 5507.553 },
    { 80,  3.88,  5223.69},
    { 44,  3.70,  2352.87 },
    { 32,  4.00,  1577.34 }
};

const struct VSOP87Coefficient b1EarthCoefficients[] =
{
    { 9, 3.90, 5507.55 },
    { 6, 1.73, 5223.69}
};

const struct VSOP87Coefficient r0EarthCoefficients[] =
{
    { 100013989,  0,          0 },
    { 1670700,    3.0984635,  6283.0758500 },
    { 13956,      3.05525,    12566.15170 },
    { 3084,       5.1985,     77713.7715 },
    { 1628,       1.1739,     5753.3849 },
    { 1576,       2.8469,     7860.4194 },
    { 925,        5.453,      11506.770 },
    { 542,        4.564,      3930.210 },
    { 472,        3.661,      5884.927 },
    { 346,        0.964,      5507.553 },
    { 329,        5.900,      5223.694 },
    { 307,        0.299,      5573.143 },
    { 243,        4.273,      11790.629 },
    { 212,        5.847,      1577.344 },
    { 186,        5.022,      10977.079 },
    { 175,        3.012,      18849.228 },
    { 110,        5.055,      5486.778 },
    { 98,         0.89,       6069.78 },
    { 86,         5.69,       15720.84 },
    { 86,         1.27,       161000.69},
    { 65,         0.27,       17260.15 },
    { 63,         0.92,       529.69 },
    { 57,         2.01,       83996.85 },
    { 56,         5.24,       71430.70 },
    { 49,         3.25,       2544.31 },
    { 47,         2.58,       775.52 },
    { 45,         5.54,       9437.76 },
    { 43,         6.01,       6275.96 },
    { 39,         5.36,       4694.00 },
    { 38,         2.39,       8827.39 },
    { 37,         0.83,       19651.05 },
    { 37,         4.90,       12139.55 },
    { 36,         1.67,       12036.46 },
    { 35,         1.84,       2942.46 },
    { 33,         0.24,       7084.90 },
    { 32,         0.18,       5088.63 },
    { 32,         1.78,       398.15 },
    { 28,         1.21,       6286.60 },
    { 28,         1.90,       6279.55 },
    { 26,         4.59,       10447.39 }
};

const struct VSOP87Coefficient r1EarthCoefficients[] =
{
    { 103019, 1.107490, 6283.075850 },
    { 1721,   1.0644,   12566.1517 },
    { 702,    3.142,    0 },
    { 32,     1.02,     18849.23 },
    { 31,     2.84,     5507.55 },
    { 25,     1.32,     5223.69 },
    { 18,     1.42,     1577.34 },
    { 10,     5.91,     10977.08 },
    { 9,      1.42,     6275.96 },
    { 9,      0.27,     5486.78 }
};

const struct VSOP87Coefficient r2EarthCoefficients[] =
{
    { 4359, 5.7846, 6283.0758 },
    { 124,  5.579,  12566.152 },
    { 12,   3.14,   0 },
    { 9,    3.63,   77713.77 },
    { 6,    1.87,   5573.14 },
    { 3,    5.47,   18849.23 }
};

const struct VSOP87Coefficient r3EarthCoefficients[] =
{
    { 145,  4.273,  6283.076 },
    { 7,    3.92,   12566.15 }
};

const struct VSOP87Coefficient r4EarthCoefficients[] =
{
    { 4, 2.56, 6283.08 }
};

const struct VSOP87Coefficient l1EarthCoefficientsJ2000[] =
{
    { 628307584999.0, 0,          0 },
    { 206059,         2.678235,   6283.075850 },
    { 4303,           2.6351,     12566.1517 },
    { 425,            1.590,      3.523 },
    { 119,            5.796,      26.298 },
    { 109,            2.966,      1577.344 },
    { 93,             2.59,       18849.23 },
    { 72,             1.14,       529.69 },
    { 68,             1.87,       398.15 },
    { 67,             4.41,       5507.55 },
    { 59,             2.89,       5223.69 },
    { 56,             2.17,       155.42 },
    { 45,             0.40,       796.30 },
    { 36,             0.47,       775.52 },
    { 29,             2.65,       7.11 },
    { 21,             5.43,       0.98 },
    { 19,             1.85,       5486.78 },
    { 19,             4.97,       213.30 },
    { 17,             2.99,       6275.96 },
    { 16,             0.03,       2544.31 },
    { 16,             1.43,       2146.17 },
    { 15,             1.21,       10977.08 },
    { 12,             2.83,       1748.02 },
    { 12,             3.26,       5088.63 },
    { 12,             5.27,       1194.45 },
    { 12,             2.08,       4694.00 },
    { 11,             0.77,       553.57 },
    { 10,             1.30,       6286.60 },
    { 10,             4.24,       1349.87 },
    { 9,              2.70,       242.73 },
    { 9,              5.64,       951.72 },
    { 8,              5.30,       2352.87 },
    { 6,              2.65,       9437.76 },
    { 6,              4.67,       4690.48 }
};

const struct VSOP87Coefficient l2EarthCoefficientsJ2000[] =
{
    { 8722, 1.0725, 6283.0758 },
    { 991,  3.1416, 0 },
    { 295,  0.437,  12566.152 },
    { 27,   0.05,   3.52 },
    { 16,   5.19,   26.30 },
    { 16,   3.69,   155.42 },
    { 9,    0.30,   18849.23 },
    { 9,    2.06,   77713.77 },
    { 7,    0.83,   775.52 },
    { 5,    4.66,   1577.34 },
    { 4,    1.03,   7.11 },
    { 4,    3.44,   5573.14 },
    { 3,    5.14,   796.30 },
    { 3,    6.05,   5507.55 },
    { 3,    1.19,   242.73 },
    { 3,    6.12,   529.69 },
    { 3,    0.30,   398.15 },
    { 3,    2.28,   553.57 },
    { 2,    4.38,   5223.69 },
    { 2,    3.75,   0.98 }
};

const struct VSOP87Coefficient l3EarthCoefficientsJ2000[] =
{
    { 289,  5.842,  6283.076 },
    { 21,   6.05,   12566.15 },
    { 3,    5.20,   155.42 },
    { 3,    3.14,   0 },
    { 1,    4.72,   3.52 },
    { 1,    5.97,   242.73 },
    { 1,    5.54,   18849.23 }
};

const struct VSOP87Coefficient l4EarthCoefficientsJ2000[] =
{
    { 8,  4.14, 6283.08 },
    { 1,  3.28, 12566.15 }
};

const struct VSOP87Coefficient b1EarthCoefficientsJ2000[] =
{
    { 227778, 3.413766, 6283.075850 },
    { 3806,   3.3706,   12566.1517 },
    { 3620,   0,        0 },
    { 72,     3.33,     18849.23 },
    { 8,      3.89,     5507.55 },
    { 8,      1.79,     5223.69 },
    { 6,      5.20,     2352.87 }
};

const struct VSOP87Coefficient b2EarthCoefficientsJ2000[] =
{ 
    { 9721, 5.1519, 6283.07585 },
    { 233,  3.1416, 0 },
    { 134,  0.644,  12566.152 },
    { 7,    1.07,   18849.23 }
};

const struct VSOP87Coefficient b3EarthCoefficientsJ2000[] =
{ 
    { 276,  0.595,  6283.076 },
    { 17,   3.14,   0 },
    { 4,    0.12,   12566.15 }
};

const struct VSOP87Coefficient b4EarthCoefficientsJ2000[] =
{ 
    { 6,  2.27, 6283.08 },
    { 1,  0,    0 }
};

@implementation AAEarth

+(CGFloat)eclipticLongitude:(CGFloat)julianDay{
    CGFloat rho = (julianDay - 2451545) / 365250;
    CGFloat rho2 = rho*rho;
    CGFloat rho3 = rho2*rho;
    CGFloat rho4 = rho3*rho;
    CGFloat rho5 = rho4*rho;
    
    int i;
    //Calculate L0
    int l0Coefficients = sizeof(l0EarthCoefficients) / sizeof(struct VSOP87Coefficient);
    CGFloat l0 = 0;
    for (i=0; i<l0Coefficients; i++) {
        l0 += l0EarthCoefficients[i].a * cos(l0EarthCoefficients[i].b + l0EarthCoefficients[i].c*rho);
    }
    //Calculate L1
    int l1Coefficients = sizeof(l1EarthCoefficients) / sizeof(struct VSOP87Coefficient);
    CGFloat l1 = 0;
    for (i=0; i<l1Coefficients; i++) {
        l1 += l1EarthCoefficients[i].a * cos(l1EarthCoefficients[i].b + l1EarthCoefficients[i].c*rho);
    }
    //Calculate L2
    int l2Coefficients = sizeof(l2EarthCoefficients) / sizeof(struct VSOP87Coefficient);
    CGFloat l2 = 0;
    for (i=0; i<l2Coefficients; i++) {
        l2 += l2EarthCoefficients[i].a * cos(l2EarthCoefficients[i].b + l2EarthCoefficients[i].c*rho);
    }
    //Calculate L3
    int l3Coefficients = sizeof(l3EarthCoefficients) / sizeof(struct VSOP87Coefficient);
    CGFloat l3 = 0;
    for (i=0; i<l3Coefficients; i++) {
        l3 += l3EarthCoefficients[i].a * cos(l3EarthCoefficients[i].b + l3EarthCoefficients[i].c*rho);
    }
    //Calculate L4
    int l4Coefficients = sizeof(l4EarthCoefficients) / sizeof(struct VSOP87Coefficient);
    CGFloat l4 = 0;
    for (i=0; i<l4Coefficients; i++) {
        l4 += l4EarthCoefficients[i].a * cos(l4EarthCoefficients[i].b + l4EarthCoefficients[i].c*rho);
    }
    //Calculate L5
    int l5Coefficients = sizeof(l5EarthCoefficients) / sizeof(struct VSOP87Coefficient);
    CGFloat l5 = 0;
    for (i=0; i<l5Coefficients; i++) {
        l5 += l5EarthCoefficients[i].a * cos(l5EarthCoefficients[i].b + l5EarthCoefficients[i].c*rho);
    }
    
    CGFloat value = (l0 + l1*rho + l2*rho2 + l3*rho3 + l4*rho4 + l5*rho5) / 100000000;
    
    return [AACoordinateTransformation mapTo0To360Degrees:[AACoordinateTransformation radianToDegrees:value]];
}

+(CGFloat)eclipticLatitude:(CGFloat)julianDay{
    CGFloat rho = (julianDay - 2451545) / 365250;
    
    int i;
    //Calculate B0
    int b0Coefficients = sizeof(b0EarthCoefficients) / sizeof(struct VSOP87Coefficient);
    CGFloat b0 = 0;
    for (i=0; i<b0Coefficients; i++){
        b0 += b0EarthCoefficients[i].a * cos(b0EarthCoefficients[i].b + b0EarthCoefficients[i].c*rho);
    }
        //Calculate B1
    int b1Coefficients = sizeof(b1EarthCoefficients) / sizeof(struct VSOP87Coefficient);
    CGFloat b1 = 0;
    for (i=0; i<b1Coefficients; i++){
        b1 += b1EarthCoefficients[i].a * cos(b1EarthCoefficients[i].b + b1EarthCoefficients[i].c*rho);
    }
    
    //Note for Earth there are no B2, B3 or B4 coefficients to calculate
    
    CGFloat value = (b0 + b1*rho) / 100000000;
    
    return [AACoordinateTransformation radianToDegrees:value];

}

+(CGFloat)radiusVector:(CGFloat)julianDay{
    CGFloat rho = (julianDay - 2451545) / 365250;
    CGFloat rho2 = rho*rho;
    CGFloat rho3 = rho2*rho;
    CGFloat rho4 = rho3*rho;
    
    int i;
    //Calculate R0
    int r0Coefficients = sizeof(r0EarthCoefficients) / sizeof(struct VSOP87Coefficient);
    double r0 = 0;
    for (i=0; i<r0Coefficients; i++){
        r0 += r0EarthCoefficients[i].a * cos(r0EarthCoefficients[i].b + r0EarthCoefficients[i].c*rho);
    }
    //Calculate R1
    int r1Coefficients = sizeof(r1EarthCoefficients) / sizeof(struct VSOP87Coefficient);
    double r1 = 0;
    for (i=0; i<r1Coefficients; i++){
        r1 += r1EarthCoefficients[i].a * cos(r1EarthCoefficients[i].b + r1EarthCoefficients[i].c*rho);
    }
    //Calculate R2
    int r2Coefficients = sizeof(r2EarthCoefficients) / sizeof(struct VSOP87Coefficient);
    double r2 = 0;
    for (i=0; i<r2Coefficients; i++){
        r2 += r2EarthCoefficients[i].a * cos(r2EarthCoefficients[i].b + r2EarthCoefficients[i].c*rho);
    }
    //Calculate R3
    int r3Coefficients = sizeof(r3EarthCoefficients) / sizeof(struct VSOP87Coefficient);
    double r3 = 0;
    for (i=0; i<r3Coefficients; i++){
        r3 += r3EarthCoefficients[i].a * cos(r3EarthCoefficients[i].b + r3EarthCoefficients[i].c*rho);
    }
    //Calculate R4
    int r4Coefficients = sizeof(r4EarthCoefficients) / sizeof(struct VSOP87Coefficient);
    double r4 = 0;
    for (i=0; i<r4Coefficients; i++){
        r4 += r4EarthCoefficients[i].a * cos(r4EarthCoefficients[i].b + r4EarthCoefficients[i].c*rho);
    }
    
    return (r0 + r1*rho + r2*rho2 + r3*rho3 + r4*rho4) / 100000000;

}

+(CGFloat)eclipticLongitudeJ2000:(CGFloat)julianDay{
    CGFloat rho = (julianDay - 2451545) / 365250;
    CGFloat rho2 = rho*rho;
    CGFloat rho3 = rho2*rho;
    CGFloat rho4 = rho3*rho;
    
    int i;
    
    //Calculate L0
    int l0Coefficients = sizeof(l0EarthCoefficients) / sizeof(struct VSOP87Coefficient);
    double l0 = 0;
    for (i=0; i<l0Coefficients; i++){
        l0 += l0EarthCoefficients[i].a * cos(l0EarthCoefficients[i].b + l0EarthCoefficients[i].c*rho);
    }
    //Calculate L1
    int l1Coefficients = sizeof(l1EarthCoefficientsJ2000) / sizeof(struct VSOP87Coefficient);
    CGFloat l1 = 0;
    for (i=0; i<l1Coefficients; i++) {
        l1 += l1EarthCoefficientsJ2000[i].a * cos(l1EarthCoefficientsJ2000[i].b + l1EarthCoefficientsJ2000[i].c*rho);
    }
    //Calculate L2
    int l2Coefficients = sizeof(l2EarthCoefficientsJ2000) / sizeof(struct VSOP87Coefficient);
    CGFloat l2 = 0;
    for (i=0; i<l2Coefficients; i++) {
        l2 += l2EarthCoefficientsJ2000[i].a * cos(l2EarthCoefficientsJ2000[i].b + l2EarthCoefficientsJ2000[i].c*rho);
    }
    //Calculate L3
    int l3Coefficients = sizeof(l3EarthCoefficientsJ2000) / sizeof(struct VSOP87Coefficient);
    CGFloat l3 = 0;
    for (i=0; i<l3Coefficients; i++) {
        l3 += l3EarthCoefficientsJ2000[i].a * cos(l3EarthCoefficientsJ2000[i].b + l3EarthCoefficientsJ2000[i].c*rho);
    }
    //Calculate L4
    int l4Coefficients = sizeof(l4EarthCoefficientsJ2000) / sizeof(struct VSOP87Coefficient);
    CGFloat l4 = 0;
    for (i=0; i<l4Coefficients; i++) {
        l4 += l4EarthCoefficientsJ2000[i].a * cos(l4EarthCoefficientsJ2000[i].b + l4EarthCoefficientsJ2000[i].c*rho);
    }
    
    CGFloat value = (l0 + l1*rho + l2*rho2 + l3*rho3 + l4*rho4) / 100000000;
    
    return [AACoordinateTransformation mapTo0To360Degrees:[AACoordinateTransformation radianToDegrees:value]];

}

+(CGFloat)eclipticLatitudeJ2000:(CGFloat)julianDay{
    CGFloat rho = (julianDay - 2451545) / 365250;
    CGFloat rho2 = rho*rho;
    CGFloat rho3 = rho2*rho;
    CGFloat rho4 = rho3*rho;
    
    int i;
    //Calculate B0
    int b0Coefficients = sizeof(b0EarthCoefficients) / sizeof(struct VSOP87Coefficient);
    CGFloat b0 = 0;
    for (i=0; i<b0Coefficients; i++){
        b0 += b0EarthCoefficients[i].a * cos(b0EarthCoefficients[i].b + b0EarthCoefficients[i].c*rho);
    }
    //Calculate B1
    int b1Coefficients = sizeof(b1EarthCoefficientsJ2000) / sizeof(struct VSOP87Coefficient);
    CGFloat b1 = 0;
    for (i=0; i<b1Coefficients; i++){
        b1 += b1EarthCoefficientsJ2000[i].a * cos(b1EarthCoefficientsJ2000[i].b + b1EarthCoefficientsJ2000[i].c*rho);
    }
    //Calculate B2
    int b2Coefficients = sizeof(b2EarthCoefficientsJ2000) / sizeof(struct VSOP87Coefficient);
    CGFloat b2 = 0;
    for (i=0; i<b2Coefficients; i++){
        b2 += b2EarthCoefficientsJ2000[i].a * cos(b2EarthCoefficientsJ2000[i].b + b2EarthCoefficientsJ2000[i].c*rho);
    }
    //Calculate B3
    int b3Coefficients = sizeof(b3EarthCoefficientsJ2000) / sizeof(struct VSOP87Coefficient);
    CGFloat b3 = 0;
    for (i=0; i<b3Coefficients; i++){
        b3 += b3EarthCoefficientsJ2000[i].a * cos(b3EarthCoefficientsJ2000[i].b + b3EarthCoefficientsJ2000[i].c*rho);
    }
    //Calculate B4
    int b4Coefficients = sizeof(b4EarthCoefficientsJ2000) / sizeof(struct VSOP87Coefficient);
    CGFloat b4 = 0;
    for (i=0; i<b4Coefficients; i++){
        b4 += b4EarthCoefficientsJ2000[i].a * cos(b4EarthCoefficientsJ2000[i].b + b4EarthCoefficientsJ2000[i].c*rho);
    }
    
    CGFloat value = (b0 + b1*rho + b2*rho2 + b3*rho3 + b4*rho4) / 100000000;
return [AACoordinateTransformation radianToDegrees:value];

}

+(CGFloat)sunMeanAnomaly:(CGFloat)julianDay{
    CGFloat t = (julianDay - 2451545) / 36525;
    CGFloat t2 = t*t;
    CGFloat t3 = t2*t;
    return [AACoordinateTransformation mapTo0To360Degrees:357.5291092 + 35999.0502909*t - 0.0001536*t2 + t3/24490000];
}

+(CGFloat)eccentricity:(CGFloat)julianDay{
    CGFloat t = (julianDay - 2451545) / 36525;
    CGFloat t2 = t*t;
    return 1 - 0.002516*t - 0.0000074*t2;
}

@end
