//
//  HYBookAppointmentViewController.h
//  HYHealthyYou
//
//  Created by Manish Parihar on 01/03/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYBookAppointmentViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
    
    @public
    NSMutableArray *names, *bookSlot;
}
@property (nonatomic,strong) IBOutlet UILabel *doctornameLBL;
@property (nonatomic,strong) IBOutlet UILabel *doctorspecialityLBL;
@property (nonatomic,strong) IBOutlet UILabel *doctormobileLBL;
@property (nonatomic,strong) IBOutlet UILabel *bookSlotLBL;
@property (nonatomic,strong) IBOutlet UITextView *doctorAddrsLBL;
@property (nonatomic,strong) IBOutlet UITextField *availField;
@property (nonatomic,strong) IBOutlet UITextField *bookSlotField;

@property (nonatomic,strong) NSString *doctorName;
@property (nonatomic,strong) NSString *doctorMobile;
@property (nonatomic,strong) NSString *doctorPhone;
@property (nonatomic,strong) NSString *doctorImageURL;
@property (nonatomic,strong) NSString *doctorAddress;
@property (nonatomic,strong) NSString *doctorSpeciality;
@property (nonatomic,strong) NSString *dateHoldString;
@property (nonatomic,strong) NSString *doctorID;
@property (nonatomic,strong) NSString *doctorEmail;
@property (nonatomic,strong) NSString *doctorPin;
@property (nonatomic,strong) NSString *doctorLocality;
@property (nonatomic, strong) NSMutableArray *bookSchedule;
@property (nonatomic, strong) NSString *timeHoldString;
@property (nonatomic, strong) NSString *availableString;
@property (nonatomic, strong) NSString *scheduleIDString;
@property (nonatomic, strong) NSString *isTokenString;
@property (nonatomic, strong) NSString *isOnCallString;



@property (nonatomic,strong) NSString *clinicAddString;
@property (nonatomic,strong) NSString *hospitalIDString;
@property (nonatomic,strong) NSString *hospitalNameString;
@property (nonatomic,strong) NSString *hospitalPhoneString;
@property (nonatomic,strong) NSString *hospitalLocalityString;
@property (nonatomic,strong) NSString *hospitalPinString;
@property (nonatomic,strong) NSString *hospitalMobileString;
@property (nonatomic,strong) NSString *hospitalCityString;
@property (nonatomic,strong) NSString *slotTimingString;
@property (nonatomic,strong) NSMutableArray *statArray;

@property (assign)NSUserDefaults *userDefaults;


- (IBAction)cancel:(id)sender;
- (IBAction)bookAppointmentButton:(id)sender;

@end
