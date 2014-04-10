//
//  HYVerifyAppointmentViewController.m
//  HYHealthyYou
//
//  Created by mediit on 3/10/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import "HYVerifyAppointmentViewController.h"
#import "HYVerificationInterface.h"
#import "HYVerifyDataObject.h"
#import "HYDoctorSearchViewController.h"


@interface HYVerifyAppointmentViewController ()

@property (nonatomic, strong) NSMutableArray *storeArray;

@end

@implementation HYVerifyAppointmentViewController

const int kFollowUpPickerTag = 4001;

@synthesize doctorLBL,
            specialityLBL,
            phoneLBL,
            mobileLBL,
            clinicLBL,
            patientLBL,
            patientMobLBL,
            patientCodeLBL,
            patientEmailLBL;

@synthesize addressDetailLBL,
            addressLBL;

@synthesize reasonField,
            selectDateField,
            timeSlotField,
            hyPinField;

@synthesize patient,
            patientCode,
            patientEmail,
            patientHYPIN,
            patientID,
            patientMobile,
            patientPin;

@synthesize bookController,
            appointmentController;

@synthesize holdArray;

@synthesize doctorName,
            doctorSpeciality,
            doctorAddress,
            doctorMobile,
            dateHoldString,
            doctorPhone,
            doctorID,
            doctorPin,
            doctorEmail,
            doctorLocality;

@synthesize scheduleIDString,
            scheduleString,
            messageString,
            isOnCallString,
            isTokenBaseString;

@synthesize clinicAddString;

@synthesize selectedBookString,
            aptTypeString;

@synthesize hospitalIDString,
            hospitalCityString,
            hospitalLocalityString,
            hospitalMobileString,
            hospitalNameString,
            hospitalPhoneString,
            hospitalPinString;

@synthesize userName,
            password,
            userDefaults;
@synthesize storeArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Assign picker to selected text fields
    UIPickerView *followUpPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    followUpPicker.tag = kFollowUpPickerTag;
    followUpPicker.delegate = self;
    followUpPicker.dataSource = self;
    [followUpPicker setShowsSelectionIndicator:YES];
    reasonField.inputView = followUpPicker;
    
    followArray = [NSMutableArray arrayWithObjects:@"Follow up",@"Consulting", nil];
    
    doctorLBL.text  = doctorName;
    specialityLBL.text = doctorSpeciality;
    phoneLBL.text   = doctorPhone;
    mobileLBL.text  = doctorMobile;
    addressDetailLBL.text = doctorAddress;
    addressLBL.text = doctorAddress;
    selectDateField.text = dateHoldString;
    patientLBL.text = patient;
    patientCodeLBL.text = patientCode;
    patientMobLBL.text = patientMobile;
    patientEmailLBL.text = patientEmail;
    hyPinField.text = patientHYPIN;
    timeSlotField.text = selectedBookString;
    
    storeArray = [[NSMutableArray alloc]init];
    [storeArray addObject:userName];
    [storeArray addObject:password];
    [storeArray addObject:patient];
    [storeArray addObject:patientCode];
    [storeArray addObject:patientMobile];
    [storeArray addObject:patientEmail];
    [storeArray addObject:patientHYPIN];
    [storeArray addObject:patientID];
    [storeArray addObject:patientPin];


  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)finishButton:(id)sender
{
  NSDictionary *finishDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    patientID,@"PatientID",
                                      patient,@"PatientName",
                                        patientCode,@"PatientCode",
                                            patientMobile,@"PatientMobile",
                                                patientEmail,@"PatientEmail",
                                                    patientHYPIN,@"PatientHYPIN",
                                                        isTokenBaseString,@"IsTokenBase",
                                                            isOnCallString,@"IsOnCall",
                                                                doctorID,@"DoctorID",
                                                                    doctorName,@"DoctorName",
                                                                        doctorLocality,@"DoctorLocality",
                                                                            doctorSpeciality,@"Doctorspeciality",
                                                                                doctorAddress,@"DoctorAddress",
                                                                                doctorMobile,@"DoctorMobile",
                                                                            doctorEmail,@"DoctorEmail",
                                                                        hospitalIDString,@"ClinicID",
                                                                    hospitalNameString,@"HospitalName",
                                                                clinicAddString,@"HospitalAddress",
                                                            hospitalLocalityString,@"HospitalLocality",
                                                        hospitalCityString,@"HospitalCity",
                                                    hospitalMobileString,@"HospitalMobile",
                                                aptTypeString,@"AppointmentType",
                                            dateHoldString,@"ApptDate",
                                        selectedBookString,@"TimeslotDetails",
                                      nil];
    
    //NSLog(@"finishDictionary: %@",finishDictionary);
    
    NSDictionary *dictionaryTwo = [NSDictionary dictionaryWithObjectsAndKeys:finishDictionary,@"appointmentinfo", nil];
    
    NSLog(@"dictionaryTwo: %@",dictionaryTwo);
    
    NSMutableArray *apptArray = [HYVerificationInterface sendVerificationData:dictionaryTwo];
    
    NSString *msgString = [[NSString alloc]init];
    
    for (int i = 0; i < [apptArray count]; i++) {
        
        //HYVerifyDataObject *verifyObject = [apptArray objectAtIndex:i];
        
        msgString = ((HYVerifyDataObject *)[apptArray objectAtIndex:i]).message;
       
        NSLog(@"msgString : %@",msgString);
        
        if ([msgString isEqualToString:@"nil"]) {
            
            UIAlertView *successMsg = [[UIAlertView alloc] initWithTitle:@"Message!"
                                                                 message:@"Something went wierd Try Again!"
                                                                delegate:self
                                                       cancelButtonTitle:@"Ok"
                                                       otherButtonTitles:nil];
            [successMsg show];
        }else {
            
            UIAlertView *successMsg = [[UIAlertView alloc] initWithTitle:@"Message!"
                                                                 message:msgString
                                                                delegate:self
                                                       cancelButtonTitle:@"Ok"
                                                       otherButtonTitles:nil];
            [successMsg show];
        }
    }
}

#pragma mark -
#pragma mark UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag == kFollowUpPickerTag)
    {
        return [followArray objectAtIndex:row];
    }
    return @"Unknown title";
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case kFollowUpPickerTag:
        {
            reasonField.text = (NSString *)[followArray objectAtIndex:row];
            aptTypeString = reasonField.text;
            NSLog(@"aptTypeString: %@",aptTypeString);
            // return picker view from
            [self.reasonField resignFirstResponder];
        }
            break;
        default:
            break;
    }
}

#pragma mark -

#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag == kFollowUpPickerTag)
    {
        return followArray.count;
    }
    return 1;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
   
    [reasonField resignFirstResponder];
    [selectDateField resignFirstResponder];
    [timeSlotField resignFirstResponder];
    [hyPinField resignFirstResponder];
    
    return YES;
}

- (IBAction)logOutButton:(id)sender
{
    UIAlertView *alertMsg = [[UIAlertView alloc] initWithTitle: @"Logout!"
                                                       message: @"Do you want to book another appointment!"
                                                      delegate:self
                                             cancelButtonTitle:@"Yes"
                                             otherButtonTitles:@"No", nil];
    [alertMsg show];
}

// UIAlertView Message for the Logout button option
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *alertselection = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([alertselection isEqualToString:@"Yes"]) {
        NSLog(@"Save patient username and password");
        
        userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:storeArray forKey:@"loginCodeKey"];
        [userDefaults synchronize];
        
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                                 bundle: nil];
        HYDoctorSearchViewController *controller = (HYDoctorSearchViewController *)[mainStoryboard
                                                                                    instantiateViewControllerWithIdentifier: @"doctorSearchVC"];
        
        [self presentViewController:controller animated:YES completion:nil];
    }
    else if([alertselection isEqualToString:@"No"]) {
        NSLog(@"Search Doctor View for Saved patient/Registered user");
       
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                                 bundle: nil];
        HYDoctorSearchViewController *controller = (HYDoctorSearchViewController *)[mainStoryboard
                                                                                          instantiateViewControllerWithIdentifier: @"doctorSearchVC"];

        [self presentViewController:controller animated:YES completion:nil];
    }
}


@end
