//
//  HYDoctorDetailDataObject.h
//  HYHealthyYou
//
//  Created by Manish Parihar on 27/02/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYDoctorDetailDataObject : NSObject

@property(nonatomic,retain) NSString *doctorName;
@property(nonatomic,retain) NSString *doctorPhone;
@property(nonatomic,retain) NSString *doctorMobile;
@property(nonatomic,retain) NSString *doctorImageURL;
@property(nonatomic,retain) NSString *doctorAddress;
@property(nonatomic,retain) NSString  *doctorClinics;
@property(nonatomic,retain) NSString *doctorEmail;
@property(nonatomic,retain) NSString *doctorID;
@property(nonatomic,retain) NSString *doctorLocality;
@property(nonatomic,retain) NSString *doctorPin;
@property(nonatomic,retain) NSString *doctorSpeciality;
@property(nonatomic,strong) NSString  *doctorHospitalId;
@property(nonatomic,strong) NSString  *doctorHospitalName;


@end
