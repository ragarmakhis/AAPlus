//
//  main.m
//  AAPlus
//
//  Created by Logger 1 on 02.07.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AADate.h"
#import "AAMoonPhases.h"
#import "AAHelpers.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
//        NSDate *myDate = [NSDate date];
        NSDate *myDate = [NSDate dateWithString:@"1977-02-14 00:00:00 +0000"];
        NSDateFormatter *dateFormate = [[NSDateFormatter alloc] init];
        
        [dateFormate setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        [dateFormate setDateFormat:@"yyyy"];
        NSInteger year = [[dateFormate stringFromDate:myDate] integerValue];
        [dateFormate setDateFormat:@"MM"];
        NSInteger month = [[dateFormate stringFromDate:myDate] integerValue];
        [dateFormate setDateFormat:@"dd"];
        NSInteger day = [[dateFormate stringFromDate:myDate] integerValue];
        [dateFormate setDateFormat:@"HH"];
        NSInteger hour = [[dateFormate stringFromDate:myDate] integerValue];
        [dateFormate setDateFormat:@"mm"];
        NSInteger minute = [[dateFormate stringFromDate:myDate] integerValue];
        [dateFormate setDateFormat:@"ss"];
        CGFloat second = [[dateFormate stringFromDate:myDate] doubleValue];
        
        
        AADate *mainDate = [AADate dateWithYear:year month:month day:day hour:hour minute:minute second:second inGregorianCalendar:YES];
        
        NSLog(@"%@", myDate);
        NSLog(@"%@", [dateFormate timeZone]);
        NSLog(@"%f", mainDate.julianDay);
        NSLog(@"date: %ld-%ld-%ld %ld:%ld:%ld", (long)[mainDate year], [mainDate month], [mainDate day], [mainDate hour], [mainDate minute], (long)[mainDate second]);
        CGFloat k = [AAMoonPhases calculateKFromDecimalYear:[mainDate fractionalYear]];
        CGFloat kNewMoon = [AAHelpers toInt:k];

        AADate *newMoon = [[AADate alloc] initWithJulianDay:[AAMoonPhases truePhaseFromK:kNewMoon] inGregorianCalendar:YES];

        
//        NSString *currentStrDate = [NSString stringWithFormat:@"%ld/%ld/%ld %ld-%ld-%f", [newMoon year], [newMoon month], [newMoon day], [newMoon hour], [newMoon minute], [newMoon second]];
//        [dateFormate setDateFormat:@"yyyy/MM/dd HH-mm-ss"];
//        NSDate *dateNewMoon = [dateFormate dateFromString:currentStrDate];
//        
//
//        NSLog(@"%@", dateNewMoon);
        NSLog(@"date: %ld-%ld-%ld %ld:%ld:%f", [newMoon year], [newMoon month], [newMoon day], [newMoon hour], [newMoon minute], [newMoon second]);
        
    }
    return 0;
}

