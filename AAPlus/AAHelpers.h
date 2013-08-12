//
//  AAHelpers.h
//  AAPlus
//
//  Created by Logger 1 on 27.07.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

/**
 AAHelpers
 
 Class of all support funktions.
 
 */

#import <Foundation/Foundation.h>


@interface AAHelpers : NSObject

/**
 
 @return Returns an integer number less than the original (eg -214.56 > -215).
 
 @param value Original value.
 
 */
+(NSInteger)toInt:(CGFloat)value;

@end
