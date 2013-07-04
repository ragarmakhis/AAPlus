//
//  AAData.m
//  AAPlus
//
//  Created by Logger 1 on 03.07.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

#import "AAData.h"

@implementation AAData

-(id)init {
    self = [super init];
    if (self) {
        [self setGregorianCalendar:NO];
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

-(void)setDataByJulianDay:(CGFloat)julianDay inGregorianCalendar:(BOOL)gregorianCalendar{
    [self setJulianDay:julianDay];
    [self setInGregorianCalendar:gregorianCalendar];
}

-(void)setDataByYear:(NSInteger)year month:(NSInteger)month day:(CGFloat)day hour:(CGFloat)hour minute:(CGFloat)minute second:(CGFloat)second inGregorianCalendar:(BOOL)gregorianCalendar{
    CGFloat dayWithDecimal = day + (hour/24) + (minute/1440) + (second/86400);
    [self setDataByJulianDay:[self dateToJulanDayByYear:year month:month day:dayWithDecimal inGregorianCalendar:gregorianCalendar] inGregorianCalendar:gregorianCalendar];
}

-(CGFloat)dateToJulanDayByYear:(NSInteger)year month:(NSInteger)month day:(CGFloat)day inGregorianCalendar:(BOOL)gregorianCalendar{
    NSInteger y = year;
    NSInteger m = month;
    if (m < 3) {
        y -= 1;
        m += 12;
    }
    NSInteger b = 0;
    if (gregorianCalendar) {
        NSInteger a = [self toInt:y/100.0];
        b = 2 - a + [self toInt:a / 4.0];
    }
    
    return [self toInt:365.25 * (y + 4716)]+[self toInt:30.6001 * (m + 1)] + day + b - 1524.5;
}



-(NSInteger)toInt:(CGFloat)value{
    NSNumber *v = [NSNumber numberWithDouble:value];
    if (value >= 0) {
        return [v integerValue];
    } else {
        return [v integerValue] - 1;
    }
}

-(void)setInGregorianCalendar:(BOOL)gregorianCalendar{
    BOOL afterPapaReform = (_julianDay >= 2299160.5);
    
//    if (gregorianCalendar) {
//        NSAssert(afterPapaReform);
//    }
    
    [self setGregorianCalendar:gregorianCalendar && afterPapaReform];
}


@end
