//
//  HYDoctorInfoViewController.m
//  HYHealthyYou
//
//  Created by Manish Parihar on 27/02/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import "HYDoctorInfoViewController.h"
#import "HYBookAppointmentViewController.h"
#import "HYNextInterface.h"
#import "HYDoctorDetailDataObject.h"
#import "HYHospitalDataObject.h"
#import "HYHospitalAddressInterface.h"
#import "HYScheduleDataObject.h"


@interface HYDoctorInfoViewController ()

@property (nonatomic, strong) NSString *dateHoldString;
@property (nonatomic, strong) NSMutableArray *receiveScheduleArray;

@end

@implementation HYDoctorInfoViewController

const int kClinicNamePickerTag = 3001;
const int kDatePickerTag       = 3002;

@synthesize doctorName,doctorPhone,doctorMobile,doctorAddress,doctorSpeciality,doctorClinics,doctorID,doctorEmail,doctorPin,doctorLocality;
@synthesize doctornameLBL,doctorspecialityLBL,doctorphoneLBL,doctormobileLBL,doctoraddrsTV,clinicAddrsTV;
@synthesize dateField,selectClinicField;
@synthesize tempHospitalStr, dateHoldString;
@synthesize receiveScheduleArray;
@synthesize hospitalId, hospitalName;
@synthesize holdTempArray,clinicArray;
@synthesize clinicAddString;
@synthesize hospitalIDString,hospitalCityString,hospitalLocalityString,hospitalMobileString,hospitalNameString,hospitalPhoneString,hospitalPinString;
@synthesize scheduleIDString,scheduleString,messageString,isOnCallString,isTokenBaseString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)backButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Assign picker to selected text fields
    UIPickerView *clinicPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    clinicPicker.tag = kClinicNamePickerTag;
    
    clinicPicker.delegate = self;
    
    clinicPicker.dataSource = self;
    
    [clinicPicker setShowsSelectionIndicator:YES];
    
    selectClinicField.inputView = clinicPicker;
    
    // Assign DatePicker to TextField
    UIDatePicker *selectDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 40.0)];
    
    selectDatePicker.datePickerMode = UIDatePickerModeDate;
    
    dateField.inputView = selectDatePicker;
    
    [selectDatePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    
    // Display Data in UI
    doctornameLBL.text       = doctorName;
    doctorspecialityLBL.text = doctorSpeciality;
    doctormobileLBL.text     = doctorMobile;
    doctorphoneLBL.text      = doctorPhone;
    doctoraddrsTV.text       = doctorAddress;
    
    names = [[NSMutableArray alloc]init];
    /**
     *      As of now Select Clinic is hard code later it has to change.
     **/
    for (int i = 0; i < holdTempArray.count - 1; i++) {
        
        //HYDoctorDetailDataObject *holdObject = [holdTempArray objectAtIndex:i];
        /*
        hospitalId = ((HYDoctorDetailDataObject*)[holdTempArray objectAtIndex:i]).doctorHospitalId;
        
        hospitalName = ((HYDoctorDetailDataObject*)[holdTempArray objectAtIndex:i]).doctorHospitalName;
         */
        
        hospitalId = ((HYHospitalDataObject*)[holdTempArray objectAtIndex:i]).hospitalID;
        
        hospitalName = ((HYHospitalDataObject*)[holdTempArray objectAtIndex:i]).hospitalName;
        
        [names addObject:hospitalName];
    }
     NSLog(@"names:%@",names);
}

- (void)dateChanged
{
    UIDatePicker *datePicker = (UIDatePicker *)dateField.inputView;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    dateField.text = [dateFormatter stringFromDate:datePicker.date];
}

- (IBAction)NextViewButton:(id)sender
{
    // Call for sending hospital id , doctor id and clinic name
    dateHoldString = dateField.text;
    
    NSLog(@"dateHoldString : %@",dateHoldString);
    
    if ([dateHoldString isEqual:@""] || [hospitalId isEqual:@""] || [doctorID isEqual:@""]) {
        
        NSLog(@"Enter Required Fields");
        UIAlertView *emptyFieldsAlert = [[UIAlertView alloc] initWithTitle:@"Hold on!"
                                                                   message:@"TextField should not be empty."
                                                                  delegate:self
                                                         cancelButtonTitle:@"Cancel"
                                                         otherButtonTitles:nil];
        [emptyFieldsAlert show];

    }else {
    
        NSLog(@"Go to Next View ");
            
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                                 bundle: nil];
        HYBookAppointmentViewController *controller = (HYBookAppointmentViewController *)[mainStoryboard
                                                                     instantiateViewControllerWithIdentifier: @"bookAppointmentVC"];
        controller.doctorName = doctorName;
        controller.doctorSpeciality = doctorSpeciality;
        controller.doctorMobile = doctorMobile;
        controller.doctorPhone = doctorPhone;
        controller.doctorAddress = doctorAddress;
        controller.dateHoldString = dateHoldString;
        controller.doctorID = doctorID;
        controller.doctorEmail = doctorEmail;
        controller.doctorPin   = doctorPin;
        controller.doctorLocality = doctorLocality;
        
        controller.clinicAddString = clinicAddString;
        controller.hospitalIDString = hospitalIDString;
        controller.hospitalNameString = hospitalNameString;
        controller.hospitalPhoneString = hospitalPhoneString;
        controller.hospitalLocalityString = hospitalLocalityString;
        controller.hospitalPinString = hospitalPinString;
        controller.hospitalMobileString = hospitalMobileString;
        controller.hospitalCityString = hospitalCityString;
        
        controller.scheduleIDString = scheduleIDString;
        controller.availableString =  scheduleString;
        controller.slotTimingString = isTokenBaseString;
        controller.isOnCallString = isOnCallString;
        
        NSDictionary *nextDict = [NSDictionary dictionaryWithObjectsAndKeys:doctorID,@"DoctorID",
                                  hospitalId,@"HospitalID",
                                  dateHoldString,@"ApptDate",nil];
        NSLog(@"nextDict : %@",nextDict);
        
        NSMutableArray *tempArray = [[NSMutableArray alloc]init];
        tempArray = [HYNextInterface sendRequiredDetails:nextDict];

        controller.statArray = tempArray;
        // write here code for adding UIAlert message for not moving to next view without timeSlot.
        
        NSString *tempScheduleString = [[NSString alloc]init];
        
         for (int n=0; n <[tempArray count]; n++) {
         
             tempScheduleString =((HYScheduleDataObject *)[tempArray objectAtIndex:n]).scheduleString;
             scheduleIDString =((HYScheduleDataObject *)[tempArray objectAtIndex:n]).scheduleIDString;
         }
         
         if ([tempScheduleString isEqualToString:@""])
         {
             UIAlertView *emptyFieldsAlert = [[UIAlertView alloc] initWithTitle:@"Hold on!"
                                                                  message:@"Appointment Schedule Not Available."
                                                                  delegate:self
                                                                  cancelButtonTitle:@"Ok"
                                                                  otherButtonTitles:nil];
         
             [emptyFieldsAlert show];
         
         } else
         {
             [self presentViewController:controller animated:YES completion:nil];
        }
    }
}

#pragma mark -
#pragma mark UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag == kClinicNamePickerTag)
    {
        return [names objectAtIndex:row];
    }
    return @"Unknown title";
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case kClinicNamePickerTag:
        {
            selectClinicField.text = (NSString *)[names objectAtIndex:row];
         
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:hospitalId,@"HospitalID", nil];
            NSDictionary *finalDict = [NSDictionary dictionaryWithObjectsAndKeys:dict,@"HosID", nil];
            
            NSLog(@"finalDict: %@",finalDict);
            
            clinicArray = [HYHospitalAddressInterface getHospitalDetails:finalDict];
            
            for (int i=0; i<[clinicArray count]; i++) {

                 clinicAddString = ((HYHospitalDataObject *)[clinicArray objectAtIndex:i]).hospitalAddress;
                 hospitalIDString = ((HYHospitalDataObject *)[clinicArray objectAtIndex:i]).hospitalID;
                 hospitalNameString = ((HYHospitalDataObject *)[clinicArray objectAtIndex:i]).hospitalName;
                 hospitalPhoneString = ((HYHospitalDataObject *)[clinicArray objectAtIndex:i]).hospitalPhone;
                 hospitalLocalityString = ((HYHospitalDataObject *)[clinicArray objectAtIndex:i]).hospitalLocality;
                 hospitalPinString = ((HYHospitalDataObject *)[clinicArray objectAtIndex:i]).hospitalPin;
                 hospitalMobileString = ((HYHospitalDataObject *)[clinicArray objectAtIndex:i]).hospitalMobile;
                 hospitalCityString = ((HYHospitalDataObject *)[clinicArray objectAtIndex:i]).hospitalCity;

                NSLog(@"clinicAddString: %@",clinicAddString);
                clinicAddrsTV.text       = clinicAddString;
            }
            // return picker view from
            [self.selectClinicField resignFirstResponder];
        }
            break;
        case kDatePickerTag:
            // return picker view from
            [self.dateField resignFirstResponder];
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
    if (pickerView.tag == kClinicNamePickerTag)
    {
        return names.count;
    }
    
    return 1;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ( textField.tag == kDatePickerTag )
    {
        [self.view endEditing:TRUE];
        [dateField resignFirstResponder];
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
