//
//  HYTimeSlotDataObject.h
//  HYHealthyYou
//
//  Created by mediit on 3/12/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYTimeSlotDataObject : NSObject

@property (nonatomic, strong) NSString *isOnCall;
@property (nonatomic, strong) NSString *isTokenBase;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *timeSlotDetails;
@property (nonatomic, strong) NSString *workFromTime;
@property (nonatomic, strong) NSString *workToTime;

@end
