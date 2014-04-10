//
//  HYDoctorDetailsInterface.h
//  HYHealthyYou
//
//  Created by Manish Parihar on 28/02/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYDoctorDetailsInterface : NSObject

+ (NSMutableArray*) getDoctorsDetails: (NSDictionary*)docIDDict;

@end
