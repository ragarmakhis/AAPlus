//
//  AADate.h
//  AAPlus
//
//  Created by Logger 1 on 03.07.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

/**
 AADate
 
 This class provides algorithms which obtain the dates for the phases of the Moon. This refers to Chapter 49 in the book.
 
 */

#import <Foundation/Foundation.h>



struct DateComponent {
    NSInteger year;
    NSInteger month;
    NSInteger day;
    NSInteger hour;
    NSInteger minute;
    CGFloat second;
};

typedef struct DateComponent DateComponent;

@interface AADate : NSObject

/**
 The date into the corresponding Julian Day number. 
 */
@property CGFloat julianDay;
/**
 Used to the Gregorian calendar.
 */
@property BOOL gregorianCalendar;

/**
 
 @return A new date object
 */
+(id)date;
/**
 
 @param julianDay julianDay
 
 @param gregorianCalendar gregorianCalendar
 
 @return A new date object set to Julian Day.
 */
+(id)dateWithJulianDay:(CGFloat)julianDay inGregorianCalendar:(BOOL)gregorianCalendar;
/**
 
 @param year year
 
 @param month month
 
 @param day day
 
 @param hour hour
 
 @param minute minute
 
 @param second second
 
 @param gregorianCalendar gregorianCalendar
 
 @return A new date object
 */
+(id)dateWithYear:(NSInteger)year month:(NSInteger)month day:(CGFloat)day hour:(CGFloat)hour minute:(CGFloat)minute second:(CGFloat)second inGregorianCalendar:(BOOL)gregorianCalendar;
/**
 
 @param year year
 
 @param month month
 
 @param day day
 
 @param gregorianCalendar gregorianCalendar
 
 @return A new date object
 */
+(id)dateWithYear:(NSInteger)year month:(NSInteger)month day:(CGFloat)day inGregorianCalendar:(BOOL)gregorianCalendar;


/**
 @param julianDay julianDay
 
 @param gregorianCalendar gregorianCalendar
 
 @return An AADate object initialized.
 */
-(id)initWithJulianDay:(CGFloat)julianDay inGregorianCalendar:(BOOL)gregorianCalendar;
/**
 @param year year
 
 @param month month
 
 @param day day
 
 @param hour hour
 
 @param minute minute
 
 @param second second
 
 @param gregorianCalendar gregorianCalendar
 
 @return An AADate object initialized.
 */
-(id)initWithYear:(NSInteger)year month:(NSInteger)month day:(CGFloat)day hour:(CGFloat)hour minute:(CGFloat)minute second:(CGFloat)second inGregorianCalendar:(BOOL)gregorianCalendar;
/**
 @param year year
 
 @param month month
 
 @param day day
 
 @param gregorianCalendar gregorianCalendar
 
 @return An AADate object initialized.
 */
-(id)initWithYear:(NSInteger)year month:(NSInteger)month day:(CGFloat)day inGregorianCalendar:(BOOL)gregorianCalendar;

/**
 @param year year
 
 @param month month
 
 @param day day
 
 @param gregorianCalendar gregorianCalendar
 */
-(CGFloat)dateToJulanDayByYear:(NSInteger)year month:(NSInteger)month day:(CGFloat)day inGregorianCalendar:(BOOL)gregorianCalendar;
/**
 @param year year
 
 @param gregorianCalendar gregorianCalendar
 */
-(BOOL)isLeapYear:(NSInteger)year inGregorianCalendar:(BOOL)gregorianCalendar;
//-(void)dayOfYear:(NSInteger)dayOfYear inLeap:(BOOL)leap toDay:(NSInteger)day AndMonth:(NSInteger)month;
//g& DayOfMonth, long& Month);
//static NSCalendarDate *JulianToGregorian(long Year, long Month, long Day);
//
/**
 @param year year
 
 @param month month
 
 @param day day
 */
+(BOOL)afterPapalReformByYear:(NSInteger)year month:(NSInteger)month day:(CGFloat)day;
/**
 @param julianDay julianDay
 */
+(BOOL)afterPapalReformByJulianDay:(CGFloat)julianDay;

/**
 @param julianDay julianDay
 
 @param gregorianCalendar gregorianCalendar
 */
-(void)setDataByJulianDay:(CGFloat)julianDay inGregorianCalendar:(BOOL)gregorianCalendar;
/**
 @param year year
 
 @param month month
 
 @param day day
 
 @param hour hour
 
 @param minute minute
 
 @param second second
 
 @param gregorianCalendar gregorianCalendar
 */
-(void)setDataByYear:(NSInteger)year month:(NSInteger)month day:(CGFloat)day hour:(CGFloat)hour minute:(CGFloat)minute second:(CGFloat)second inGregorianCalendar:(BOOL)gregorianCalendar;
/**
 */
-(DateComponent)getDateComponent;
/**
 */
-(NSInteger)year;
/**
 */
-(NSInteger)month;
/**
 */
-(NSInteger)day;
/**
 */
-(NSInteger)hour;
/**
 */
-(NSInteger)minute;
/**
 */
-(CGFloat)second;


/**
 */
-(CGFloat)fractionalYear;

/**
 @param gregorianCalendar gregorianCalendar
 */
-(void)setInGregorianCalendar:(BOOL)gregorianCalendar;
@end
