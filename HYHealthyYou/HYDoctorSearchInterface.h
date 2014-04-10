//
//  HYDoctorSearchInterface.h
//  HYHealthyYou
//
//  Created by Manish Parihar on 27/02/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYDoctorSearchInterface : NSObject

+ (NSMutableArray*)searchDoctors:(NSString*)searchString;

@end
