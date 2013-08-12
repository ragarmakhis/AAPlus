//
//  AAData.m
//  AAPlus
//
//  Created by Logger 1 on 03.07.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

#import "AADate.h"
#import "AAHelpers.h"

@implementation AADate

+(id)date{
    return [[self alloc] init];
}

+(id)dateWithJulianDay:(CGFloat)julianDay inGregorianCalendar:(BOOL)gregorianCalendar{
    return [[self alloc] initWithJulianDay:julianDay inGregorianCalendar:gregorianCalendar];
}

+(id)dateWithYear:(NSInteger)year month:(NSInteger)month day:(CGFloat)day inGregorianCalendar:(BOOL)gregorianCalendar{
    return [[self alloc] initWithYear:year month:month day:day inGregorianCalendar:gregorianCalendar];
}

+(id)dateWithYear:(NSInteger)year month:(NSInteger)month day:(CGFloat)day hour:(CGFloat)hour minute:(CGFloat)minute second:(CGFloat)second inGregorianCalendar:(BOOL)gregorianCalendar{
    return [[self alloc] initWithYear:year month:month day:day hour:hour minute:minute second:second inGregorianCalendar:gregorianCalendar];
}

-(id)init {
    self = [super init];
    if (self) {
        [self setGregorianCalendar:YES];
        [self setJulianDay:0.0];
    }
    return self;
}


-(id)initWithJulianDay:(CGFloat)julianDay inGregorianCalendar:(BOOL)gregorianCalendar {
    if (self = [super init]) {
        [self setDataByJulianDay:julianDay inGregorianCalendar:gregorianCalendar];
    }
    return self;
}

-(id)initWithYear:(NSInteger)year month:(NSInteger)month day:(CGFloat)day inGregorianCalendar:(BOOL)gregorianCalendar {
    if (self = [super init]) {
        [self setDataByYear:year month:month day:day hour:0.0 minute:0.0 second:0.0 inGregorianCalendar:gregorianCalendar];
    }
    return self;
}

-(id)initWithYear:(NSInteger)year month:(NSInteger)month day:(CGFloat)day hour:(CGFloat)hour minute:(CGFloat)minute second:(CGFloat)second inGregorianCalendar:(BOOL)gregorianCalendar {
    if (self = [super init]) {
        [self setDataByYear:year month:month day:day hour:hour minute:minute second:second inGregorianCalendar:gregorianCalendar];
    }
    return self;
}

/////////////////////////////////////

-(CGFloat)dateToJulanDayByYear:(NSInteger)year month:(NSInteger)month day:(CGFloat)day inGregorianCalendar:(BOOL)gregorianCalendar{
    NSInteger y = year;
    NSInteger m = month;
    if (m < 3) {
        y -= 1;
        m += 12;
    }
    NSInteger b = 0;
    if (gregorianCalendar) {
        NSInteger a = [AAHelpers toInt:y/100.0];
        b = 2 - a + [AAHelpers toInt:a / 4.0];
    }
    
    return [AAHelpers toInt:365.25 * (y + 4716)]+[AAHelpers toInt:30.6001 * (m + 1)] + day + b - 1524.5;
}

-(BOOL)isLeapYear:(NSInteger)year inGregorianCalendar:(BOOL)gregorianCalendar{
    if (gregorianCalendar) {
        if ((year % 100) == 0) {
            return ((year % 400) == 0) ? YES : NO;
        } else {
            return ((year % 4) == 0) ? YES : NO;
        }
    } else {
        return ((year % 4) == 0) ? YES : NO;
    }
}

+(BOOL)afterPapalReformByYear:(NSInteger)year month:(NSInteger)month day:(CGFloat)day{
    return ((year > 1582) || ((year == 1582) && (month > 10)) || ((year == 1582) && (month == 10) && (day >= 15)));
}

+(BOOL)afterPapalReformByJulianDay:(CGFloat)julianDay{
    return (julianDay >= 2299160.5);
}

/////////////////////////////////////

-(void)setDataByJulianDay:(CGFloat)julianDay inGregorianCalendar:(BOOL)gregorianCalendar{
    [self setJulianDay:julianDay];
    [self setInGregorianCalendar:gregorianCalendar];
}

-(void)setDataByYear:(NSInteger)year month:(NSInteger)month day:(CGFloat)day hour:(CGFloat)hour minute:(CGFloat)minute second:(CGFloat)second inGregorianCalendar:(BOOL)gregorianCalendar{
    CGFloat dayWithDecimal = day + (hour/24) + (minute/1440) + (second/86400);
    [self setDataByJulianDay:[self dateToJulanDayByYear:year month:month day:dayWithDecimal inGregorianCalendar:gregorianCalendar] inGregorianCalendar:gregorianCalendar];
}

-(DateComponent)getDateComponent{
    DateComponent dateComponent;
    CGFloat JD = self.julianDay + 0.5;
    CGFloat tempZ;
    CGFloat f = modf(JD, &tempZ);
    NSInteger z = [[NSNumber numberWithDouble:tempZ] longValue];
    NSInteger a;
    
    if (self.gregorianCalendar) {
        NSInteger alpha = [AAHelpers toInt:(z - 1867216.25) / 36524.25];
        a  = z + 1 + alpha - [AAHelpers toInt:alpha / 4.0];
    } else {
        a = z;
    }
    
    NSInteger b = a + 1524;
    NSInteger c = [AAHelpers toInt:(b - 122.1) / 365.25];
    NSInteger d = [AAHelpers toInt:365.25 * c];
    NSInteger e = [AAHelpers toInt:(b - d) / 30.6001];
    
    CGFloat day = b - d - [AAHelpers toInt:30.6001 * e] + f;
    dateComponent.day = [[NSNumber numberWithDouble:day] longValue];
    
    if (e < 14) {
        dateComponent.month = e - 1;
    } else {
        dateComponent.month = e - 13;
    }
    
    if (dateComponent.month > 2) {
        dateComponent.year = c - 4716;
    } else {
        dateComponent.year = c - 4715;
    }
    
    f = modf(day, &tempZ);
    dateComponent.hour = [AAHelpers toInt:f * 24];
    dateComponent.minute = [AAHelpers toInt:(f - dateComponent.hour / 24.0) * 1440.0];
    dateComponent.second = (f - dateComponent.hour / 24.0 - dateComponent.minute / 1440.0) * 86400.0;
    
    return dateComponent;
}

-(NSInteger)year{
    DateComponent dateComponent;
    dateComponent = [self getDateComponent];
    return dateComponent.year;
}

-(NSInteger)month{
    DateComponent dateComponent;
    dateComponent = [self getDateComponent];
    return dateComponent.month;
}

-(NSInteger)day{
    DateComponent dateComponent;
    dateComponent = [self getDateComponent];
    return dateComponent.day;
}

-(NSInteger)hour{
    DateComponent dateComponent;
    dateComponent = [self getDateComponent];
    return dateComponent.hour;
}

-(NSInteger)minute{
    DateComponent dateComponent;
    dateComponent = [self getDateComponent];
    return dateComponent.minute;
}

-(CGFloat)second{
    DateComponent dateComponent;
    dateComponent = [self getDateComponent];
    return dateComponent.second;
}

-(CGFloat)fractionalYear{
    DateComponent date = [self getDateComponent];
    
    NSInteger daysInYear;
    if ([self isLeapYear:date.year inGregorianCalendar:self.gregorianCalendar]) {
        daysInYear = 366;
    } else {
        daysInYear = 365;
    }
    
    return date.year + ((self.julianDay - [self dateToJulanDayByYear:date.year month:1 day:1 inGregorianCalendar:[AADate afterPapalReformByYear:date.year month:1 day:1]]) / daysInYear);
}

/////////////////////////////////////


-(void)setInGregorianCalendar:(BOOL)gregorianCalendar{
    BOOL afterPapaReform = (_julianDay >= 2299160.5);
    
//    if (gregorianCalendar) {
//        NSAssert(afterPapaReform);
//    }
    
    [self setGregorianCalendar:gregorianCalendar && afterPapaReform];
}


@end
