//
//  AARiseTransitSet.h
//  AAPlus
//
//  Created by Logger 1 on 27.07.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

/**
 This class provides for calculation of the time of rise, transit and set of a celestial body. This refers to Chapter 15 in the book.
 */

#import <Foundation/Foundation.h>
#import "AARiseTransitSetDetails.h"

@interface AARiseTransitSet : NSObject

/**
 @param julianDay The Julian Day corresponding to that midnight Dynamical Time for the date when you want to perform the calculation.
 
 @param alpha1 The right ascension in hours of the object at time JD - 1 day
 
 @param delta1 The declination in degrees of the object at time JD - 1 day
 
 @param alpha2 The right ascension in hours of the object at time JD
 
 @param delta2 The declination in degrees of the object at time JD
 
 @param alpha3 The right ascension in hours of the object at time JD + 1 day
 
 @param delta3 The declination in degrees of the object at time JD + 1 day
 
 @param longitude The geographic longitude of the observer in degrees.
 
 @param latitude The geographic latitude of the observer in degrees.
 
 @param h0 The "standard" altitude in degrees i.e. the geometric altitude of the centre of the body at the time of the apparent rising or setting. For stars and planets, you would normally use -0.5667, for the Sun you would use -0.8333 and for the moon you would use 0.7275 * PI - 0.5666 where PI is the Moon's horizontal parallax in degrees (If no great accuracy is required, the mean value of h0 = 0.125 can be used).
 
 @return AARiseTransitSetDetails
 
 Remarks
 
 Bear in mind that the times calculated for the phenomena are for the same UTC date. This means that when you are in a non GMT timezone, the calculated local times can be for the previous or next day. Please bear this issue in mind if you are generating an ephemeris of rise, transit and set times for a celestial object for a specific range of local dates. In this case, you will need to rerun the calculation for the previous or next UTC date if the calculated local date is not the same as the required local date.
 
 Another wrinkle to how this method operates is that the same event can occur twice in the same day, even though this method does not provide a method to allow this to be easily obtained. For example, imagine you are located in the timezone PDT which is 4 hours behind GMT and you are calculating the times of sunset during the month of August, when PDT would be in effect. During this period, the length of the day is gradually reducing and the time of sunrise is getting earlier every day. Combined with the fact that calculated time of Sunset for this period is around 20:00 local time or midnight UTC, you get this interesting effect where Sunrise occurs just around midnight UTC and then again just before midnight the following day! If you use the following code:
 
 void main()
 {
 CAADate CalcDate(2009, 8, 8, true);
 double JD = CalcDate.Julian();
 JD = CalcDate.Julian() + 0.010; //to get the effect to be demonstrated
 for (int i = 0; i<5; i++)
 {
 JD += 1.000;
 CAAEllipticalPlanetaryDetails SunDetails = CAAElliptical::Calculate(JD - 1, CAAElliptical::SUN);
 double Alpha1 = SunDetails.ApparentGeocentricRA;
 double Delta1 = SunDetails.ApparentGeocentricDeclination;
 SunDetails = CAAElliptical::Calculate(JD, CAAElliptical::SUN);
 double Alpha2 = SunDetails.ApparentGeocentricRA;
 double Delta2 = SunDetails.ApparentGeocentricDeclination;
 SunDetails = CAAElliptical::Calculate(JD + 1, CAAElliptical::SUN);
 double Alpha3 = SunDetails.ApparentGeocentricRA;
 double Delta3 = SunDetails.ApparentGeocentricDeclination;
 CAARiseTransitSetDetails RiseTransitSetTime = CAARiseTransitSet::Rise(JD, Alpha1, Delta1, Alpha2, Delta2, Alpha3, Delta3, 74.73057, 39.275787, -0.8333);
 doublertsJD = (JD + (RiseTransitSetTime.Set / 24.00));
 doublelclJD = rtsJD - (4.00/24.00); //Adjust for EDT -4 Hours
 CAADate SetDate(rtsJD,true);
 long setDay;
 long setMonth;
 long setYear;
 long setHours;
 long setMinuts;
 double setSec;
 SetDate.Get(setYear,setMonth, setDay, setHours, setMinuts, setSec);
 printf("Sunset for %d/%d/%d UTC occurs at %02d:%02d:%02d\n", setYear, setMonth, setDay, setHours, setMinuts, static_cast<int>(setSec));
 CAADate SetLclDate(lclJD, true);
 long setlclDay;
 long setlclMonth;
 long setlclYear;
 long setlclHours;
 long setlclMinuts;
 double setlclSec;
 SetLclDate.Get(setlclYear,setlclMonth, setlclDay, setlclHours, setlclMinuts, setlclSec);
 printf("Sunset for %d/%d/%d PDT occurs at %02d:%02d:%02d\n\n", setlclYear, setlclMonth, setlclDay, setlclHours, setlclMinuts, static_cast<int>(setlclSec));
 }
 }
 You will observe the following output, which demonstrates this effect:
 
 Sunset for 2009/8/10 UTC occurs at 00:01:39
 Sunset for 2009/8/9 PDT occurs at 20:01:39
 
 Sunset for 2009/8/11 UTC occurs at 00:00:25
 Sunset for 2009/8/10 PDT occurs at 20:00:25
 
 Sunset for 2009/8/11 UTC occurs at 23:59:10
 Sunset for 2009/8/11 PDT occurs at 19:59:10
 
 Sunset for 2009/8/12 UTC occurs at 23:57:54
 Sunset for 2009/8/12 PDT occurs at 19:57:54
 
 Sunset for 2009/8/13 UTC occurs at 23:56:37
 Sunset for 2009/8/13 PDT occurs at 19:56:37
 Your client code which uses this method will need to handle this situation itself.
 
 Another issue with the algorithm is that under certain circumstances, the time of an event (rise, transit or set) can be returned outside of the requested UTC day. For example if you request the times of moon rise, set and transit for Cape Town, South Africa on the 31st of October 2012 UTC you will get the following:
 
 Rise (UTC): 2012-10-31 18:53:12
 Transit (UTC): 2012-11-1 00:06:27
 Set (UTC): 2012-10-31 04:35:24
 
 Note how the transit time is for the next UTC day. If you were to run for the same location but for the date of 30th October 2012 UTC you would get the following:
 
 Rise (UTC): 2012-10-30 17:59:48
 Transit (UTC): 2012-10-30 23:19:04
 Set (UTC): 2012-10-30 03:56:19
 
 Because the Moon takes roughly 45 minutes extra each day to return to the same position you see that the Moon did not actually transit on the UTC day of 31st of October 2012 from Cape Town. Client code should bear this in mind when generating an ephemeris of times for a particular object.
 
 */
+(AARiseTransitSetDetails *)calculateForJulianDay:(CGFloat)julianDay lastRightAscension:(CGFloat)alpha1 lastDeclination:(CGFloat)delta1 presentRightAscension:(CGFloat)alpha2 presentDeclination:(CGFloat)delta2 nextRightAscension:(CGFloat)alpha3 nextDeclination:(CGFloat)delta3 longitude:(CGFloat)longitude latitude:(CGFloat)latitude altitude:(CGFloat)h0;
/**
 @return Calculate m0 for transit
 
 @param alpha2 The apparent right ascension of the celestian body on day D at 0 h Dinamical Time.
 
 @param theta0 The apparent sideral time at 0 h Universal Time on day D for the meridian of Greenwich, converted into degrees.
 
 @param longtitude Geographic longitude of the observer in degrees, measured positively west from Greemwich, negatively to the east (see Chapter 13).
 */
+(CGFloat)calculateTransitByPresentRightAscension:(CGFloat)alpha2 sideralTime:(CGFloat)theta0 longtitude:(CGFloat)longtitude;
/**
 @return Calculate m1 for rise and m2 for set
 
 @param m0 m0
 @param cosH0 cosH0
 @param detailes AARiseTransitSetDetails
 @param m1 point m2
 @param m2 point m2
 */
+(void)calculateRiseSetByM0:(CGFloat)m0 cosH0:(CGFloat)cosH0 riseTransitSetDetailes:(AARiseTransitSetDetails *)detailes m1:(CGFloat *)m1 m2:(CGFloat *)m2;
/**
 @return Correct right ascension values for interpolation
 
 @param alpha1 last right ascension
 @param alpha2 present right ascension
 @param alpha3 next right ascension
 */
+(void)correctRightAscensionValuesForInterpolationByLastRightAscension:(CGFloat *)alpha1 presentRightAscension:(CGFloat *)alpha2 nextRightAscension:(CGFloat *)alpha3;
/**
 @return calculate transit helper
 
 @param theta0 apparent sideral time
 @param deltaT deltaT
 @param alpha1 last right ascension
 @param alpha2 present right ascension
 @param alpha3 next right ascension
 @param longitude longitude
 @param m0 m0
 */
+(void)calculateTransitHelperBySideralTime:(CGFloat)theta0 deltaT:(CGFloat)deltaT lastRightAscension:(CGFloat)alpha1 presentRightAscension:(CGFloat)alpha2 nextRightAscension:(CGFloat)alpha3 longitude:(CGFloat)longitude m0:(CGFloat *)m0;
/**
 @return calculate rise helper
 
 @param detailes AARiseTransitSetDetails
 @param theta0 apparent sideral time
 @param deltaT deltaT
 @param alpha1 last right ascension
 @param delta1 last declination
 @param alpha2 present right ascension
 @param delta2 present declination
 @param alpha3 next right ascension
 @param delta3 next declination
 @param longitude longitude
 @param latitude latitude
 @param latitudeInRad latitudeInRadian
 @param h0 The "standard" altitude in degrees
 @param m1 m1
 */
+(void)calculateRiseHelperByRiseTransitSetDetailes:(AARiseTransitSetDetails *)detailes sideralTime:(CGFloat)theta0 deltaT:(CGFloat)deltaT lastRightAscension:(CGFloat)alpha1 lastDeclination:(CGFloat)delta1 presentRightAscension:(CGFloat)alpha2 presentDeclination:(CGFloat)delta2 nextRightAscension:(CGFloat)alpha3 nextDeclination:(CGFloat)delta3 longitude:(CGFloat)longitude latitude:(CGFloat)latitude latitudeInRadian:(CGFloat)latitudeInRad altitude:(CGFloat)h0 m1:(CGFloat *)m1;
/**
 @return calculate set helper
 
 @param detailes AARiseTransitSetDetails
 @param theta0 apparent sideral time
 @param deltaT deltaT
 @param alpha1 last right ascension
 @param delta1 last declination
 @param alpha2 present right ascension
 @param delta2 present declination
 @param alpha3 next right ascension
 @param delta3 next declination
 @param longitude longitude
 @param latitude latitude
 @param latitudeInRad latitudeInRadian
 @param h0 The "standard" altitude in degrees
 @param m2 m2
 */
+(void)calculateSetHelperByRiseTransitSetDetailes:(AARiseTransitSetDetails *)detailes sideralTime:(CGFloat)theta0 deltaT:(CGFloat)deltaT lastRightAscension:(CGFloat)alpha1 lastDeclination:(CGFloat)delta1 presentRightAscension:(CGFloat)alpha2 presentDeclination:(CGFloat)delta2 nextRightAscension:(CGFloat)alpha3 nextDeclination:(CGFloat)delta3 longitude:(CGFloat)longitude latitude:(CGFloat)latitude latitudeInRadian:(CGFloat)latitudeInRad altitude:(CGFloat)h0 m2:(CGFloat *)m2;
/**
 @return Correct m value (0 ... 1)
 
 @param m m
 */
+(CGFloat)constraintM:(CGFloat)m;

@end
