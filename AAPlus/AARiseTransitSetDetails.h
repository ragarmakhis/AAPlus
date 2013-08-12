//
//  AARiseTransitSetDetails.h
//  AAPlus
//
//  Created by Logger 1 on 27.07.13.
//  Copyright (c) 2013 ragarmakhis. All rights reserved.
//

/**
 AARiseTransitSetDetails
 */

#import <Foundation/Foundation.h>

@interface AARiseTransitSetDetails : NSObject
/**
 riseValid true if the object actually rises for the specified date.
 */
@property BOOL riseValid;
/**
 The time in decimal hours when the object rises
 */
@property CGFloat rise;
/**
 transitAboveHorizon true if the object transits above the horizon, false indicates it transits below the horizon.
 */
@property BOOL transitAboveHorizon;
/**
 The time in hours when the object transits
 */
@property CGFloat transit;
/**
 setValid true if the object actually sets for the specified date.
 */
@property BOOL setValid;
/**
 The time in hours when the object sets
 */
@property CGFloat set;

/**
 Create AARiseTransitSetDetails object
 */
+(id)riseTransitSetDetails;

@end
