//
//  AAData.h
//  AAPlus
//
//  Created by Logger 1 on 03.07.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AAData : NSObject

@property BOOL gregorianCalendar;
@property CGFloat julianDay;

-(id)initWithJulianDay:(CGFloat)julianDay inGregorianCalendar:(BOOL)gregorianCalendar;
-(id)initWithYear:(NSInteger)year month:(NSInteger)month day:(CGFloat)day hour:(CGFloat)hour minute:(CGFloat)minute second:(CGFloat)second inGregorianCalendar:(BOOL)gregorianCalendar;
-(id)initWithYear:(NSInteger)year month:(NSInteger)month day:(CGFloat)day inGregorianCalendar:(BOOL)gregorianCalendar;

-(CGFloat)dateToJulanDayByYear:(NSInteger)year month:(NSInteger)month day:(CGFloat)day inGregorianCalendar:(BOOL)gregorianCalendar;
//-(BOOL)isLeapYear:(NSInteger)year inGregorianCalendar:(BOOL)gregorianCalendar;
//-(void)dayOfYear:(NSInteger)dayOfYear inLeap:(BOOL)leap toDay:(NSInteger)day AndMonth:(NSInteger)month;
//g& DayOfMonth, long& Month);
static NSCalendarDate *JulianToGregorian(long Year, long Month, long Day);
//
-(BOOL)afterPapalReformByYear:(NSInteger)year month:(NSInteger)month day:(CGFloat)day;
-(BOOL)afterPapalReformByJulianDay:(CGFloat)julianDay;

-(void)setDataByJulianDay:(CGFloat)julianDay inGregorianCalendar:(BOOL)gregorianCalendar;
-(void)setDataByYear:(NSInteger)year month:(NSInteger)month day:(CGFloat)day hour:(CGFloat)hour minute:(CGFloat)minute second:(CGFloat)second inGregorianCalendar:(BOOL)gregorianCalendar;

-(NSInteger)toInt:(CGFloat)value;
-(void)setInGregorianCalendar:(BOOL)gregorianCalendar;
@end
