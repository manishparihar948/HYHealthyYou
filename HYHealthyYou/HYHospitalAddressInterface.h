//
//  HYHospitalAddressInterface.h
//  HYHealthyYou
//
//  Created by mediit on 3/19/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYHospitalAddressInterface : NSObject

+ (NSMutableArray*) getHospitalDetails: (NSDictionary*)hospitalIDDict;

@end
