//
//  AACoordinateTransformation.h
//  AAPlus
//
//  Created by Logger 1 on 22.07.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

/**
 AACoordinateTransformation
 
 This class provides for the transformations of the coordinates as well as helper angle methods. This refers to Chapter 13 and parts of Chapter 1 in the book.
 */

#import <Foundation/Foundation.h>
#import "AA2DCoordinate.h"

@interface AACoordinateTransformation : NSObject

/**
 @return Returns the value in radians which was converted from degrees.
 
 @param degrees The angular value to convert measured in degrees.
 */
+(CGFloat)degreesToRadian:(CGFloat)degrees;
/**
@return Returns the value in degrees which was converted from radians.

@param radians The angular value to convert measured in radians.
*/
+(CGFloat)radianToDegrees:(CGFloat)radians;
/**
 @return Returns the value in hours which was converted from degrees.
 
 @param degrees The angular value to convert measured in degrees.
 */
+(CGFloat)degreesToHours:(CGFloat)degrees;
/**
 @return Returns the value in degrees which was converted from hours.
 
 @param hours The numeric value to convert measured in hours.
 */
+(CGFloat)hoursToDegrees:(CGFloat)hours;
/**
 @return Returns the value in hours which was converted from radians.
 
 @param radians The angular value to convert measured in radians.
 */
+(CGFloat)radianToHours:(CGFloat)radians;
/**
 @return Returns the value in radians which was converted from hours.
 
 @param hours The numeric value to convert measured in hours.
 */
+(CGFloat)hoursToRadian:(CGFloat)hours;
/**
 @return Maps an arbitrary angular value to the range 0 to 360. i.e. inputting the value -2 will return a value of 258.
 
 @param degrees The angular value.
 */
+(CGFloat)mapTo0To360Degrees:(CGFloat)degrees;
/**
 @return Maps an arbitrary value to the range 0 to 24. i.e. inputting the value -2  will return a value of 22.
 
 @param hourAngle The hour angle.
 */
+(CGFloat)mapTo0To24Range:(CGFloat)hourAngle;
/**
 @return Returns the constant value of pi i.e 3.1415926...
 */
+(CGFloat)pi;
/**
 @return Returns the value in degrees which was converted from degrees, minutes and seconds.
 
 @param degrees  The degree part of the angular value to convert.
 
 @param minutes The minute part of the angular value to convert.
 
 @param seconds The second part of the angular value to convert.
 
 @param positive true if the input value corresponds to a non-negative value with false implying the value is positive
 
 @warning To convert the angle 21° 44' 07" you would use ```degreesFromDegrees:(CGFloat)21 minutes:(CGFloat)44 seconds:(CGFloat)07 inPositive:(BOOL)YES```.
 @warning To convert the angle -12° 47' 22" you would use ```degreesFromDegrees:(CGFloat)12 minutes:(CGFloat)47 seconds:(CGFloat)22 inPositive:(BOOL)NO``` or ```degreesFromDegrees:(CGFloat)-12 minutes:(CGFloat)-47 seconds:(CGFloat)-22 inPositive:(BOOL)YES```.
 @warning To convert the angle -0° 32' 41" you must use ```degreesFromDegrees:(CGFloat)0 minutes:(CGFloat)32 seconds:(CGFloat)41 inPositive:(BOOL)NO```.
 */
+(CGFloat)degreesFromDegrees:(CGFloat)degrees minutes:(CGFloat)minutes seconds:(CGFloat)seconds inPositive:(BOOL)positive;
/**
 @return Returns the value in degrees which was converted from degrees, minutes and seconds.
 
 @param degrees  The degree part of the angular value to convert.
 
 @param minutes The minute part of the angular value to convert.
 
 @param seconds The second part of the angular value to convert.
 
 @warning To convert the angle 21° 44' 07" you would use ```degreesFromDegrees:(CGFloat)21 minutes:(CGFloat)44 seconds:(CGFloat)07```.
 @warning To convert the angle -12° 47' 22" you would use ```degreesFromDegrees:(CGFloat)-12 minutes:(CGFloat)-47 seconds:(CGFloat)-22 inPositive:(BOOL)YES```.
 @warning No convert the angle -0° 32' 41"!!! Use +(CGFloat)degreesFromDegrees:(CGFloat)degrees minutes:(CGFloat)minutes seconds:(CGFloat)seconds inPositive:(BOOL)positive;
  */
+(CGFloat)degreesFromDegrees:(CGFloat)degrees minutes:(CGFloat)minutes seconds:(CGFloat)seconds;
/**
 The transformation of coordinates from Equatorial to Ecliptic. This refers to algorithm 13.1 and 13.2 on page 93.
 
 @return Returns the converted ecliptic coordinates in a CAA2DCoordinate class. The x value in the class corresponds to the ecliptic longitude in degrees and the y value corresponds to the ecliptic latitude in degrees.
 
 @param alpha The right ascension expressed as an hour angle.
 
 @param delta The declination in degrees.
 
 @param epsilon The obliquity of the ecliptic in degrees.
 */
+(AA2DCoordinate *)equatorialToEclipticByRightAscension:(CGFloat)alpha declination:(CGFloat)delta obliquityOfTheEcliptic:(CGFloat)epsilon;
/**
 The transformation of coordinates from Ecliptic to Equatorial. This refers to algorithm 13.3 and 13.4 on page 93.
 
 @return Returns the converted equatorial coordinates in a CAA2DCoordinate class. The x value in the class corresponds to the equatorial longitude in hours and the y value corresponds to the equatorial latitude in degrees.
 
 @param lambda The ecliptic longitude in degrees.
 
 @param beta The ecliptic latitude in degrees.
 
 @param epsilon the obliquity of the ecliptic in degrees.
 */
+(AA2DCoordinate *)eclipticToEquatorialByEclipticLongitude:(CGFloat)lambda eclipticLatitude:(CGFloat)beta obliquityOfTheEcliptic:(CGFloat)epsilon;
/**
 The transformation of coordinates from Equatorial to Horizontal. This refers to algorithm 13.5 and 13.6 on page 93.
 
 @return Returns the converted horizontal coordinates in a AA2DCoordinate class. The x value in the class corresponds to the azimuth in degrees and the y value corresponds to the altitude in degrees.
 
 @param localHourAngle The local hour angle, measured westwards from the South.
 
 @param delta The declination in degrees.
 
 @param latitude The standard latitude of the position in degrees.
 */
+(AA2DCoordinate *)equatorialToHorizontalBylocalHourAngle:(CGFloat)localHourAngle declination:(CGFloat)delta standardLatitude:(CGFloat)latitude;
/**
 The transformation of coordinates from Horizontal to Equatorial. This refers to the two algorithms on the top of page 94.
 
 @return Returns the converted equatorial coordinates in a CAA2DCoordinate class. The x value in the class corresponds to the equatorial longitude in hours and the y value corresponds to the equatorial latitude in degrees.
 
 @param a The azimuth in degrees.
 
 @param h The altitude in degrees
 
 @param latitude The standard latitude of the position in degrees.
 */
+(AA2DCoordinate *)horizontalToEquatorialByAzimuth:(CGFloat)azimut altitude:(CGFloat)altitude standardLatitude:(CGFloat)latitude;
/**
 The transformation of coordinates from Equatorial to Galactic. This refers to algorithm 13.7 and 13.8 on page 94.
 
 @return Returns the converted galactic coordinates in a CAA2DCoordinate class. The x value in the class corresponds to the galactic longitude in degrees and the y value corresponds to the galactic latitude in degrees.
 
 @param alpha The right ascension expressed as an hour angle.
 
 @param delta The declination in degrees.
 */
+(AA2DCoordinate *)equatorialToGalacticByRightAscension:(CGFloat)alpha declination:(CGFloat)delta;
/**
 The transformation of coordinates from Galactic to Equatorial. This refers to the last two algorithms on page 94.
 
 @return Returns the converted equatorial coordinates in a CAA2DCoordinate class. The x value in the class corresponds to the equatorial longitude in hours and the y value corresponds to the equatorial latitude in degrees.
 
 @param l  The galactic longitude expressed in degrees.
 
 @param b The galactic latitude expressed in degrees.
 */
+(AA2DCoordinate *)galacticToEquatorialByGalacticLongitude:(CGFloat)l galacticLatitude:(CGFloat)b;

@end
