//
//  AAMoon.m
//  AAPlus
//
//  Created by Logger 1 on 10.08.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

#import "AAMoon.h"
#import "AACoordinateTransformation.h"
#import "AAEarth.h"
#import "AANutation.h"

struct moonCoefficient1
{
    NSInteger d;
    NSInteger m;
    NSInteger mDash;
    NSInteger f;
};

struct moonCoefficient2
{
    CGFloat a;
    CGFloat b;
};

const struct moonCoefficient1 moonCoefficients1[] =
{
    { 0, 0,  1,  0 },
    { 2, 0,  -1, 0 },
    { 2, 0,  0,  0 },
    { 0, 0,  2,  0 },
    { 0, 1,  0,  0 },
    { 0, 0,  0,  2 },
    { 2, 0,  -2, 0 },
    { 2, -1, -1, 0 },
    { 2, 0,  1,  0 },
    { 2, -1, 0,  0 },
    { 0, 1,  -1, 0 },
    { 1, 0,  0,  0 },
    { 0, 1,  1,  0 },
    { 2, 0,  0,  -2 },
    { 0, 0,  1,  2 },
    { 0, 0,  1,  -2 },
    { 4, 0,  -1, 0 },
    { 0, 0,  3,  0 },
    { 4, 0,  -2, 0 },
    { 2, 1,  -1, 0 },
    { 2, 1,  0,  0 },
    { 1, 0,  -1, 0 },
    { 1, 1,  0,  0 },
    { 2, -1, 1,  0 },
    { 2, 0,  2,  0 },
    { 4, 0,  0,  0 },
    { 2, 0,  -3, 0 },
    { 0, 1,  -2, 0 },
    { 2, 0,  -1, 2 },
    { 2, -1, -2, 0 },
    { 1, 0,  1,  0 },
    { 2, -2, 0,  0 },
    { 0, 1,  2,  0 },
    { 0, 2,  0,  0 },
    { 2, -2, -1, 0 },
    { 2, 0,  1,  -2 },
    { 2, 0,  0,  2 },
    { 4, -1, -1, 0 },
    { 0, 0,  2,  2 },
    { 3, 0,  -1, 0 },
    { 2, 1,  1,  0 },
    { 4, -1, -2, 0 },
    { 0, 2,  -1, 0 },
    { 2, 2,  -1, 0 },
    { 2, 1,  -2, 0 },
    { 2, -1, 0,  -2 },
    { 4, 0,  1,  0 },
    { 0, 0,  4,  0 },
    { 4, -1, 0,  0 },
    { 1, 0,  -2, 0 },
    { 2, 1,  0,  -2 },
    { 0, 0,  2,  -2 },
    { 1, 1,  1,  0 },
    { 3, 0,  -2, 0 },
    { 4, 0,  -3, 0 },
    { 2, -1, 2,  0 },
    { 0, 2,  1,  0 },
    { 1, 1,  -1, 0 },
    { 2, 0,  3,  0 },
    { 2, 0,  -1, -2 }
};

const struct moonCoefficient2 moonCoefficients2[] =
{
    { 6288774,	-20905355 },
    { 1274027,	-3699111 },
    { 658314,	  -2955968 },
    { 213618,	  -569925 },
    { -185116,	48888 },
    { -114332,	-3149 },
    { 58793,	  246158 },
    { 57066,	  -152138 },
    { 53322,	  -170733 },
    { 45758,	  -204586 },
    { -40923,	  -129620 },
    { -34720,	  108743 },
    { -30383,	  104755 },
    { 15327,	  10321 },
    { -12528,	  0 },
    { 10980,	  79661 },
    { 10675,	  -34782 },
    { 10034,	  -23210 },
    { 8548,	    -21636 },
    { -7888,	  24208 },
    { -6766,	  30824 },
    { -5163,	  -8379 },
    { 4987,	    -16675 },
    { 4036,	    -12831 },
    { 3994,	    -10445 },
    { 3861,	    -11650 },
    { 3665,	    14403 },
    { -2689,	  -7003 },
    { -2602,	  0 },
    { 2390,	    10056 },
    { -2348,	  6322 },
    { 2236,	    -9884 },
    { -2120,	  5751 },
    { -2069,	  0 },
    { 2048,	    -4950 },
    { -1773,	  4130 },
    { -1595,	  0 },
    { 1215,	    -3958 },
    { -1110,	  0 },
    { -892,	    3258 },
    { -810,	    2616 },
    { 759,	    -1897 },
    { -713,	    -2117 },
    { -700,	    2354 },
    { 691,	    0 },
    { 596,	    0 },
    { 549,	    -1423 },
    { 537,	    -1117 },
    { 520,	    -1571 },
    { -487,	    -1739 },
    { -399,	    0 },
    { -381,	    -4421 },
    { 351,	    0 },
    { -340,	    0 },
    { 330,	    0 } ,
    { 327,	    0 },
    { -323,	    1165 },
    { 299,	    0 },
    { 294,	    0 },
    { 0,	      8752 }
};

const struct moonCoefficient1 moonCoefficients3[] =
{
    { 0, 0,  0,  1  },
    { 0, 0,  1,  1  },
    { 0, 0,  1,  -1  },
    { 2, 0,  0,  -1  },
    { 2, 0,  -1, 1  },
    { 2, 0,  -1, -1 },
    { 2, 0,  0,  1  },
    { 0, 0,  2,  1 },
    { 2, 0,  1,  -1  },
    { 0, 0,  2,  -1 },
    { 2, -1, 0,  -1 },
    { 2, 0,  -2, -1 },
    { 2, 0,  1,  1 },
    { 2, 1,  0,  -1  },
    { 2, -1, -1, 1 },
    { 2, -1, 0,  1  },
    { 2, -1, -1, -1  },
    { 0, 1,  -1, -1 },
    { 4, 0,  -1, -1  } ,
    { 0, 1,  0,  1  },
    { 0, 0,  0,  3 },
    { 0, 1,  -1, 1  },
    { 1, 0,  0,  1 },
    { 0, 1,  1,  1,  },
    { 0, 1,  1,  -1  },
    { 0, 1,  0,  -1  },
    { 1, 0,  0,  -1  },
    { 0, 0,  3,  1  },
    { 4, 0,  0,  -1  },
    { 4, 0,  -1, 1, },
    { 0, 0,  1,  -3 },
    { 4, 0,  -2, 1  },
    { 2, 0,  0,  -3 },
    { 2, 0,  2,  -1 },
    { 2, -1, 1,  -1 },
    { 2, 0,  -2, 1  },
    { 0, 0,  3,  -1 },
    { 2, 0,  2,  1  },
    { 2, 0,  -3, -1 },
    { 2, 1,  -1, 1  },
    { 2, 1,  0,  1  },
    { 4, 0,  0,  1  },
    { 2, -1, 1,  1  },
    { 2, -2, 0,  -1 },
    { 0, 0,  1,  3  },
    { 2, 1,  1,  -1 },
    { 1, 1,  0,  -1 },
    { 1, 1,  0,  1  },
    { 0, 1,  -2, -1 },
    { 2, 1,  -1, -1 },
    { 1, 0,  1,  1  },
    { 2, -1, -2, -1 },
    { 0, 1,  2,  1  },
    { 4, 0,  -2, -1 },
    { 4, -1, -1, -1 },
    { 1, 0,  1,  -1 },
    { 4, 0,  1,  -1 },
    { 1, 0,  -1, -1 },
    { 4, -1, 0,  -1 },
    { 2, -2, 0,  1  },
};

const CGFloat moonCoefficients4[] =
{
    5128122,
    280602,
    277693,
    173237,
    55413,
    46271,
    32573,
    17198,
    9266,
    8822,
    8216,
    4324,
    4200,
    -3359,
    2463,
    2211,
    2065,
    -1870,
    1828,
    -1794,
    -1749,
    -1565,       
    -1491,
    -1475,       
    -1410,       
    -1344,
    -1335,       
    1107,
    1021,        
    833,         
    777,  
    671,  
    607,  
    596,  
    491,  
    -451,  
    439,  
    422,  
    421,  
    -366,  
    -351,  
    331,  
    315,  
    302,  
    -283,  
    -229,  
    223,  
    223,  
    -220,  
    -220,  
    -185,  
    181,  
    -177,  
    176,  
    166,  
    -164,  
    132,  
    -119,  
    115,  
    107,  
};

@implementation AAMoon

+(CGFloat)meanLongitude:(CGFloat)julianDay{
    CGFloat t = (julianDay - 2451545) / 36525;
    CGFloat t2 = t*t;
    CGFloat t3 = t2*t;
    CGFloat t4 = t3*t;
    return [AACoordinateTransformation mapTo0To360Degrees:218.3164477 + 481267.88123421*t - 0.0015786*t2 + t3/538841 - t4/65194000];
}

+(CGFloat)meanElongation:(CGFloat)julianDay{
    CGFloat t = (julianDay - 2451545) / 36525;
    CGFloat t2 = t*t;
    CGFloat t3 = t2*t;
    CGFloat t4 = t3*t;
    return [AACoordinateTransformation mapTo0To360Degrees:297.8501921 + 445267.1114034*t - 0.0018819*t2 + t3/545868 - t4/113065000];
}

+(CGFloat)meanAnomaly:(CGFloat)julianDay{
    CGFloat t = (julianDay - 2451545) / 36525;
    CGFloat t2 = t*t;
    CGFloat t3 = t2*t;
    CGFloat t4 = t3*t;
    return [AACoordinateTransformation mapTo0To360Degrees:134.9633964 + 477198.8675055*t + 0.0087414*t2 + t3/69699 - t4/14712000];
}

+(CGFloat)argumentOfLatitude:(CGFloat)julianDay{
    CGFloat t = (julianDay - 2451545) / 36525;
    CGFloat t2 = t*t;
    CGFloat t3 = t2*t;
    CGFloat t4 = t3*t;
    return [AACoordinateTransformation mapTo0To360Degrees:93.2720950 + 483202.0175233*t - 0.0036539*t2 - t3/3526000 + t4/863310000];
}

+(CGFloat)meanLongitudeAscendingNode:(CGFloat)julianDay{
    CGFloat t = (julianDay - 2451545) / 36525;
    CGFloat t2 = t*t;
    CGFloat t3 = t2*t;
    CGFloat t4 = t3*t;
    return [AACoordinateTransformation mapTo0To360Degrees:125.0445479 - 1934.1362891*t + 0.0020754*t2 + t3/467441 - t4/60616000];
}

+(CGFloat)meanLongitudePerigee:(CGFloat)julianDay{
    CGFloat t = (julianDay - 2451545) / 36525;
    CGFloat t2 = t*t;
    CGFloat t3 = t2*t;
    CGFloat t4 = t3*t;
    return [AACoordinateTransformation mapTo0To360Degrees:83.3532465 + 4069.0137287*t - 0.0103200*t2 - t3/80053 + t4/18999000];
}

+(CGFloat)trueLongitudeAscendingNode:(CGFloat)julianDay{
    CGFloat trueAscendingNode = [self meanLongitudeAscendingNode:julianDay];
    
    CGFloat d = [AACoordinateTransformation degreesToRadian:[self meanElongation:julianDay]];
    CGFloat m = [AACoordinateTransformation degreesToRadian:[AAEarth sunMeanAnomaly:julianDay]];
    CGFloat mDash = [AACoordinateTransformation degreesToRadian:[self meanAnomaly:julianDay]];
    CGFloat f = [AACoordinateTransformation degreesToRadian:[self argumentOfLatitude:julianDay]];
    
    //Add the principal additive terms
    trueAscendingNode -= 1.4979*sin(2*(d - f));
    trueAscendingNode -= 0.1500*sin(m);
    trueAscendingNode -= 0.1226*sin(2*d);
    trueAscendingNode += 0.1176*sin(2*f);
    trueAscendingNode -= 0.0801*sin(2*(mDash-f));
    
    return [AACoordinateTransformation mapTo0To360Degrees:trueAscendingNode];
}

+(CGFloat)eclipticLongitude:(CGFloat)julianDay{
    CGFloat lDashDegrees = [self meanElongation:julianDay];
    CGFloat lDash = [AACoordinateTransformation degreesToRadian:lDashDegrees];
    CGFloat d = [AACoordinateTransformation degreesToRadian:[self meanElongation:julianDay]];
    CGFloat m = [AACoordinateTransformation degreesToRadian:[AAEarth sunMeanAnomaly:julianDay]];
    CGFloat mDash = [AACoordinateTransformation degreesToRadian:[self meanAnomaly:julianDay]];
    CGFloat f = [AACoordinateTransformation degreesToRadian:[self argumentOfLatitude:julianDay]];
    
    CGFloat e = [AAEarth eccentricity:julianDay];
    CGFloat e2 = e*e;
    CGFloat t = (julianDay - 2451545) / 36525;
    
    CGFloat a1 = [AACoordinateTransformation degreesToRadian:[AACoordinateTransformation mapTo0To360Degrees:119.75 + 131.849*t]];
    CGFloat a2 = [AACoordinateTransformation degreesToRadian:[AACoordinateTransformation mapTo0To360Degrees:53.09 + 479264.290*t]];
    
    size_t lCoefficients = sizeof(moonCoefficients1) / sizeof(struct moonCoefficient1);
    assert(lCoefficients == sizeof(moonCoefficients2) / sizeof(struct moonCoefficient2));
    CGFloat sigmaL = 0;
    for (size_t i=0; i<lCoefficients; i++){
        CGFloat thisSigma = moonCoefficients2[i].a * sin(moonCoefficients1[i].d*d + moonCoefficients1[i].m*m + moonCoefficients1[i].mDash*mDash + moonCoefficients1[i].f*f);
        
        if ((moonCoefficients1[i].m == 1) || (moonCoefficients1[i].m == -1)){
            thisSigma *= e;
        } else if ((moonCoefficients1[i].m == 2) || (moonCoefficients1[i].m == -2)){
            thisSigma *= e2;
        }
        
        sigmaL += thisSigma;
    }
    
    //Finally the additive terms
    sigmaL += 3958*sin(a1);
    sigmaL += 1962*sin(lDash - f);
    sigmaL += 318*sin(a2);
    
    //And finally apply the nutation in longitude
    CGFloat nutationInLong = [AANutation nutationInLongitude:julianDay];
    
    return [AACoordinateTransformation mapTo0To360Degrees:lDashDegrees + sigmaL/1000000 + nutationInLong/3600];
}

+(CGFloat)eclipticLatitude:(CGFloat)julianDay{
    CGFloat lDash = [AACoordinateTransformation degreesToRadian:[self meanElongation:julianDay]];
    CGFloat d = [AACoordinateTransformation degreesToRadian:[self meanElongation:julianDay]];
    CGFloat m = [AACoordinateTransformation degreesToRadian:[AAEarth sunMeanAnomaly:julianDay]];
    CGFloat mDash = [AACoordinateTransformation degreesToRadian:[self meanAnomaly:julianDay]];
    CGFloat f = [AACoordinateTransformation degreesToRadian:[self argumentOfLatitude:julianDay]];
    
    
    CGFloat e = [AAEarth eccentricity:julianDay];
    CGFloat t = (julianDay - 2451545) / 36525;
    
    CGFloat a1 = [AACoordinateTransformation degreesToRadian:[AACoordinateTransformation mapTo0To360Degrees:119.75 + 131.849*t]];
    CGFloat a3 = [AACoordinateTransformation degreesToRadian:[AACoordinateTransformation mapTo0To360Degrees:313.45 + 481266.484*t]];

    size_t bCoefficients = sizeof(moonCoefficients3) / sizeof(struct moonCoefficient1);
    assert(bCoefficients == sizeof(moonCoefficients4) / sizeof(CGFloat));
    CGFloat sigmaB = 0;
    for (size_t i=0; i<bCoefficients; i++){
        CGFloat thisSigma = moonCoefficients4[i] * sin(moonCoefficients3[i].d*d + moonCoefficients3[i].m*m + moonCoefficients3[i].mDash*mDash + moonCoefficients3[i].f*f);
        
        if (moonCoefficients3[i].m){
            thisSigma *= e;
        }
        
        sigmaB += thisSigma;
    }

    sigmaB -= 2235*sin(lDash);
    sigmaB += 382*sin(a3);
    sigmaB += 175*sin(a1 - f);
    sigmaB += 175*sin(a1 + f);
    sigmaB += 127*sin(lDash - mDash);
    sigmaB -= 115*sin(lDash + mDash);
    
    return sigmaB/1000000;
    
}

+(CGFloat)radiusVector:(CGFloat)julianDay{
    CGFloat d = [AACoordinateTransformation degreesToRadian:[self meanElongation:julianDay]];
    CGFloat m = [AACoordinateTransformation degreesToRadian:[AAEarth sunMeanAnomaly:julianDay]];
    CGFloat mDash = [AACoordinateTransformation degreesToRadian:[self meanAnomaly:julianDay]];
    CGFloat f = [AACoordinateTransformation degreesToRadian:[self argumentOfLatitude:julianDay]];
    CGFloat e = [AAEarth eccentricity:julianDay];
    
    size_t rCoefficients = sizeof(moonCoefficients1) / sizeof(struct moonCoefficient1);
    assert(rCoefficients == sizeof(moonCoefficients2) / sizeof(struct moonCoefficient2));
    double sigmaR = 0;
    for (size_t i=0; i<rCoefficients; i++){
        double thisSigma = moonCoefficients2[i].b * cos(moonCoefficients1[i].d*d + moonCoefficients1[i].m*m + moonCoefficients1[i].mDash*mDash + moonCoefficients1[i].f*f);
        if (moonCoefficients1[i].m)
            thisSigma *= e;
        
        sigmaR += thisSigma;
    }
    
    return 385000.56 + sigmaR/1000;
}

+(CGFloat)radiusVectorFromHorizontalParallax:(CGFloat)parallax{
    return 6378.14 / sin([AACoordinateTransformation degreesToRadian:parallax]);
}

+(CGFloat)horizontalParallaxFromRadiusVector:(CGFloat)radiusVector{
    return [AACoordinateTransformation radianToDegrees:asin(6378.14 / radiusVector)];
}

@end
