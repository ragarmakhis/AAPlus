//
//  AACoordinateTransformation.m
//  AAPlus
//
//  Created by Logger 1 on 22.07.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

#import "AACoordinateTransformation.h"

@implementation AACoordinateTransformation

+(CGFloat)degreesToRadian:(CGFloat)degrees{
    return degrees * 0.017453292519943295769236907684886;
}

+(CGFloat)radianToDegrees:(CGFloat)radians{
    return radians * 57.295779513082320876798154814105;
}

+(CGFloat)degreesToHours:(CGFloat)degrees{
    return degrees / 15;
}

+(CGFloat)hoursToDegrees:(CGFloat)hours{
    return hours * 15;
}

+(CGFloat)radianToHours:(CGFloat)radians{
    return radians * 3.8197186342054880584532103209403;
}

+(CGFloat)hoursToRadian:(CGFloat)hours{
    return hours * 0.26179938779914943653855361527329;
}

+(CGFloat)mapTo0To360Degrees:(CGFloat)degrees{
    CGFloat value = degrees;
    
    while (value < 0) {
        value += 360;
    }
    while (value > 360) {
        value -= 360;
    }
        
    return value;
}

+(CGFloat)mapTo0To24Range:(CGFloat)hourAngle{
    CGFloat value = hourAngle;
    
    while (value < 0) {
        value += 24;
    }
    while (value > 24) {
        value -= 24;
    }
    
    return value;
}

+(CGFloat)pi{
    return 3.1415926535897932384626433832795;
}

+(CGFloat)degreesFromDegrees:(CGFloat)degrees minutes:(CGFloat)minutes seconds:(CGFloat)seconds inPositive:(BOOL)positive{
    if (!positive) {
        NSAssert(degrees>=0, @"degrees not positive!");
        NSAssert(minutes>=0, @"minutes not positive!");
        NSAssert(seconds>=0, @"seconds not positive!");
    }
    
    if (positive) {
        return degrees + minutes/60 + seconds/3600;
    } else {
        return -degrees - minutes/60 - seconds/3600;
    }
}

+(CGFloat)degreesFromDegrees:(CGFloat)degrees minutes:(CGFloat)minutes seconds:(CGFloat)seconds{
    return [self degreesFromDegrees:degrees minutes:minutes seconds:seconds inPositive:YES];
}

+(AA2DCoordinate *)equatorialToEclipticByRightAscension:(CGFloat)alpha declination:(CGFloat)delta obliquityOfTheEcliptic:(CGFloat)epsilon{
    alpha = [self hoursToRadian:alpha];
    delta = [self degreesToRadian:delta];
    epsilon = [self degreesToRadian:epsilon];
    
    AA2DCoordinate *ecliptic = [AA2DCoordinate coordinate];    
    ecliptic.x = [self radianToDegrees:atan2(sin(alpha)*cos(epsilon) + tan(delta)*sin(epsilon), cos(alpha))];
    if (ecliptic.x < 0)
        ecliptic.x += 360;
    ecliptic.y = [self radianToDegrees:asin(sin(delta)*cos(epsilon) - cos(delta)*sin(epsilon)*sin(alpha))];
    
    return ecliptic;
}

+(AA2DCoordinate *)eclipticToEquatorialByEclipticLongitude:(CGFloat)lambda eclipticLatitude:(CGFloat)beta obliquityOfTheEcliptic:(CGFloat)epsilon{
    lambda = [self degreesToRadian:lambda];
    beta = [self degreesToRadian:beta];
    epsilon = [self degreesToRadian:epsilon];
    
    AA2DCoordinate *equatorial = [AA2DCoordinate coordinate];    
    equatorial.x = [self radianToHours:atan2(sin(lambda)*cos(epsilon) - tan(beta)*sin(epsilon), cos(lambda))];
    if (equatorial.x < 0)
        equatorial.x += 24;
    equatorial.y = [self radianToDegrees:asin(sin(beta)*cos(epsilon) + cos(beta)*sin(epsilon)*sin(lambda))];
    
    return equatorial;
}

+(AA2DCoordinate *)equatorialToHorizontalBylocalHourAngle:(CGFloat)localHourAngle declination:(CGFloat)delta standardLatitude:(CGFloat)latitude{
    localHourAngle = [self hoursToRadian:localHourAngle];
    delta = [self degreesToRadian:delta];
    latitude = [self degreesToRadian:latitude];
    
    AA2DCoordinate *horizontal = [AA2DCoordinate coordinate];
    [horizontal setX:[self radianToDegrees:atan2(sin(localHourAngle), cos(localHourAngle)*sin(latitude) - tan(delta)*cos(latitude))]];
    if (horizontal.x < 0) {
        horizontal.x += 360;
    }
    [horizontal setY:[self radianToDegrees:asin(sin(latitude)*sin(delta) + cos(latitude)*cos(delta)*cos(localHourAngle))]];
    
    return horizontal;
}

+(AA2DCoordinate *)horizontalToEquatorialByAzimuth:(CGFloat)azimut altitude:(CGFloat)altitude standardLatitude:(CGFloat)latitude{
    azimut = [self degreesToRadian:azimut];
    altitude = [self degreesToRadian:altitude];
    latitude = [self degreesToRadian:latitude];
    
    AA2DCoordinate *equatorial = [AA2DCoordinate coordinate];
    equatorial.x = [self radianToHours:atan2(sin(azimut), cos(azimut)*sin(latitude) + tan(altitude)*cos(latitude))];
    if (equatorial.x < 0)
        equatorial.x += 24;
    equatorial.y = [self radianToDegrees:asin(sin(latitude)*sin(altitude) - sin(latitude)*cos(altitude)*cos(azimut))];
    
    return equatorial;
}

+(AA2DCoordinate *)equatorialToGalacticByRightAscension:(CGFloat)alpha declination:(CGFloat)delta{
    alpha = [self degreesToRadian:192.25 - [self hoursToDegrees:alpha]];
    delta = [self degreesToRadian:delta];
    
    AA2DCoordinate *galactic = [AA2DCoordinate coordinate];
    galactic.x = [self radianToDegrees:atan2(sin(alpha), cos(alpha)*sin([self degreesToRadian:27.4]) - tan(delta)*cos([self degreesToRadian:27.4]))];
    galactic.x = 303 - galactic.x;
    if (galactic.x >= 360) {
        galactic.x -= 360;
    }
    galactic.y = [self radianToDegrees:asin(sin(delta)*sin([self degreesToRadian:27.4]) + cos(delta)*cos([self degreesToRadian:27.4])*cos(alpha))];
    
    return galactic;
}

+(AA2DCoordinate *)galacticToEquatorialByGalacticLongitude:(CGFloat)l galacticLatitude:(CGFloat)b{
    l = [self degreesToRadian:l - 123];
    b = [self degreesToRadian:b];
    
    AA2DCoordinate *equatorial = [AA2DCoordinate coordinate];
    equatorial.x = [self radianToDegrees:atan2(sin(l), cos(l)*sin([self degreesToRadian:27.4]) - tan(b)*cos([self degreesToRadian:27.4]))];
    equatorial.x += 12.25;
    if (equatorial.x < 0) {
        equatorial.x += 360;
    }
    equatorial.x = [self degreesToHours:equatorial.x];
    equatorial.y = [self radianToDegrees:asin(sin(b)*sin([self degreesToRadian:27.4]) + cos(b)*cos([self degreesToRadian:27.4])*cos(l))];
    
    return equatorial;
}

@end
