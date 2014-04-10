//
//  HYVerifyAppointmentViewController.h
//  HYHealthyYou
//
//  Created by mediit on 3/10/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYDoctorInfoViewController.h"
#import "HYBookAppointmentViewController.h"

@interface HYVerifyAppointmentViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIAlertViewDelegate>
{
    @public
    NSMutableArray *followArray;
}

@property (nonatomic, strong) IBOutlet UILabel *doctorLBL,
                                               *specialityLBL,
                                               *phoneLBL,
                                               *mobileLBL,
                                               *clinicLBL,
                                               *patientLBL,
                                               *patientMobLBL,
                                               *patientCodeLBL,
                                               *patientEmailLBL; 

@property (nonatomic, strong) IBOutlet UITextView *addressLBL,
                                                  *addressDetailLBL;

@property (nonatomic, strong) IBOutlet UITextField *reasonField,
                                                   *selectDateField,
                                                   *timeSlotField,
                                                   *hyPinField;

@property (nonatomic, strong) HYDoctorInfoViewController *bookController;
@property (nonatomic, strong) HYBookAppointmentViewController *appointmentController;
@property (nonatomic, strong) NSMutableArray *holdArray;

// Doctor's Property
@property (nonatomic, strong) NSString *doctorName;
@property (nonatomic, strong) NSString *doctorSpeciality;
@property (nonatomic, strong) NSString *doctorMobile;
@property (nonatomic, strong) NSString *doctorPhone;
@property (nonatomic, strong) NSString *doctorAddress;
@property (nonatomic, strong) NSString  *dateHoldString;
@property (nonatomic, strong) NSString *doctorID;
@property (nonatomic, strong) NSString *doctorEmail;
@property (nonatomic, strong) NSString *doctorPin;
@property (nonatomic, strong) NSString *doctorLocality;

// Patient's Property
@property (nonatomic, strong) NSString  *patient;
@property (nonatomic, strong) NSString *patientCode;
@property (nonatomic, strong) NSString *patientEmail;
@property (nonatomic, strong) NSString *patientHYPIN;
@property (nonatomic, strong) NSString  *patientID;
@property (nonatomic, strong) NSString  *patientPin;
@property (nonatomic, strong) NSString  *patientMobile;

// Appointment Schedule
@property (nonatomic, strong) NSString *scheduleIDString;
@property (nonatomic, strong) NSString *messageString;
@property (nonatomic, strong) NSString *scheduleString;
@property (nonatomic, strong) NSString *isTokenBaseString;
@property (nonatomic, strong) NSString *isOnCallString;

// Clinic's Property
@property (nonatomic,strong) NSString *clinicAddString;
@property (nonatomic,strong) NSString *hospitalIDString;
@property (nonatomic,strong) NSString *hospitalNameString;
@property (nonatomic,strong) NSString *hospitalPhoneString;
@property (nonatomic,strong) NSString *hospitalLocalityString;
@property (nonatomic,strong) NSString *hospitalPinString;
@property (nonatomic,strong) NSString *hospitalMobileString;
@property (nonatomic,strong) NSString *hospitalCityString;

// Time Slot Property
@property (nonatomic,strong) NSString *selectedBookString;

// Appointment Type Property
@property (nonatomic,strong) NSString *aptTypeString;

// Store Username and Password
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;
@property(assign) NSUserDefaults *userDefaults;


- (IBAction)cancelButton:(id)sender;
- (IBAction)finishButton:(id)sender;
- (IBAction)logOutButton:(id)sender;

@end
