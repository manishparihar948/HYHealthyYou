//
//  HYDoctorInfoViewController.h
//  HYHealthyYou
//
//  Created by Manish Parihar on 27/02/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYDoctorInfoViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
    @public
    NSMutableArray *names;
}
@property (nonatomic,strong) NSString *doctorName;
@property (nonatomic,strong) NSString *doctorPhone;
@property (nonatomic,strong) NSString *doctorMobile;
@property (nonatomic,strong) NSString *doctorImageURL;
@property (nonatomic,strong) NSString *doctorAddress;
@property (nonatomic,strong) NSArray  *doctorClinics;
@property (nonatomic,strong) NSString *doctorEmail;
@property (nonatomic,strong) NSString *doctorID;
@property (nonatomic,strong) NSString *doctorLocality;
@property (nonatomic,strong) NSString *doctorPin;
@property (nonatomic,strong) NSString *doctorSpeciality;
@property (nonatomic,strong) NSString *hospitalName;
@property (nonatomic,strong) NSString *hospitalId;
@property (nonatomic,strong) IBOutlet UILabel *doctornameLBL;
@property (nonatomic,strong) IBOutlet UILabel *doctorspecialityLBL;
@property (nonatomic,strong) IBOutlet UILabel *doctorphoneLBL;
@property (nonatomic,strong) IBOutlet UILabel *doctormobileLBL;
@property (nonatomic,strong) IBOutlet UITextView  *doctoraddrsTV;
@property (nonatomic,retain) IBOutlet UITextField *dateField;
@property (nonatomic,strong) IBOutlet UITextField *selectClinicField;
@property (nonatomic,strong) NSString *tempHospitalStr;
@property (nonatomic,strong) NSMutableArray *holdTempArray;
@property (nonatomic,strong) IBOutlet UITextView  *clinicAddrsTV;
@property (nonatomic,strong) NSMutableArray *clinicArray;

@property (nonatomic,strong) NSString *clinicAddString;
@property (nonatomic,strong) NSString *hospitalIDString;
@property (nonatomic,strong) NSString *hospitalNameString;
@property (nonatomic,strong) NSString *hospitalPhoneString;
@property (nonatomic,strong) NSString *hospitalLocalityString;
@property (nonatomic,strong) NSString *hospitalPinString;
@property (nonatomic,strong) NSString *hospitalMobileString;
@property (nonatomic,strong) NSString *hospitalCityString;

@property (nonatomic,strong) NSString *scheduleIDString;
@property (nonatomic,strong) NSString *scheduleString;
@property (nonatomic,strong) NSString *messageString;
@property (nonatomic,strong) NSString *isOnCallString;
@property (nonatomic,strong) NSString *isTokenBaseString;

- (IBAction)backButton:(id)sender;

- (IBAction)NextViewButton:(id)sender;


@end
