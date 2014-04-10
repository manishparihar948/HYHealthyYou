//
//  HYSignInViewController.h
//  HYHealthyYou
//
//  Created by Manish Parihar on 01/03/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYVerifyAppointmentViewController.h"

@interface HYSignInViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *userField;
@property (nonatomic, weak) IBOutlet UITextField *pwdField;

@property (nonatomic, weak) IBOutlet UILabel *doctorLBL;
@property (nonatomic, weak) IBOutlet UILabel *patientLBL;
@property (nonatomic, weak) IBOutlet UILabel *diagnosticLBL;
@property (nonatomic, weak) IBOutlet UILabel *chemistLBL;

@property (nonatomic, strong) NSMutableArray *statChangeArray;
@property (nonatomic, strong) NSString *doctorName;
@property (nonatomic, strong) NSString *doctorSpeciality;
@property (nonatomic, strong) NSString *doctorPhone;
@property (nonatomic, strong) NSString *doctorMobile;
@property (nonatomic, strong) NSString *doctorAddress;
@property (nonatomic, strong) NSString *dateHoldString;
@property (nonatomic, strong) NSString *doctorID;
@property (nonatomic, strong) NSString *doctorEmail;
@property (nonatomic, strong) NSString *doctorPin;
@property (nonatomic, strong) NSString *doctorLocality;

@property (nonatomic,strong) NSString *clinicAddString;
@property (nonatomic,strong) NSString *hospitalIDString;
@property (nonatomic,strong) NSString *hospitalNameString;
@property (nonatomic,strong) NSString *hospitalPhoneString;
@property (nonatomic,strong) NSString *hospitalLocalityString;
@property (nonatomic,strong) NSString *hospitalPinString;
@property (nonatomic,strong) NSString *hospitalMobileString;
@property (nonatomic,strong) NSString *hospitalCityString;
@property (nonatomic,strong) NSString *selectedBookString;

@property (nonatomic,strong) NSString *scheduleIDString;
@property (nonatomic,strong) NSString *scheduleString;
@property (nonatomic,strong) NSString *messageString;
@property (nonatomic,strong) NSString *isOnCallString;
@property (nonatomic,strong) NSString *isTokenBaseString;

-(IBAction)login:(id)sender;

@end
