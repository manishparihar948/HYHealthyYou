//
//  HYBookAppointmentViewController.m
//  HYHealthyYou
//
//  Created by Manish Parihar on 01/03/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import "HYBookAppointmentViewController.h"
#import "HYScheduleBookInterface.h"
#import "HYSignInViewController.h"
#import "HYScheduleDataObject.h"
#import "HYTimeSlotDataObject.h"
#import "HYVerifyAppointmentViewController.h"

@interface HYBookAppointmentViewController ()

@property (nonatomic, strong) NSMutableArray  *bookSlot;
@property (nonatomic, strong) NSString *selectedBookString;
@property (nonatomic, strong) NSMutableArray *userDefArray;

@end


@implementation HYBookAppointmentViewController

@synthesize doctornameLBL,
            doctormobileLBL,
            doctorspecialityLBL,
            doctorAddrsLBL,
            availField,
            bookSlotField,
            bookSlotLBL;

@synthesize doctorName,
            doctorAddress,
            doctorMobile,
            doctorSpeciality,
            doctorPhone,
            doctorID,
            doctorPin,
            doctorEmail,
            doctorLocality;
@synthesize bookSchedule;

@synthesize timeHoldString;

@synthesize availableString;

@synthesize statArray;

@synthesize dateHoldString;

@synthesize scheduleIDString;

@synthesize isTokenString;

@synthesize clinicAddString;

@synthesize hospitalIDString,
            hospitalCityString,
            hospitalLocalityString,
            hospitalMobileString,
            hospitalNameString,
            hospitalPhoneString,
            hospitalPinString;

@synthesize slotTimingString,isOnCallString;

@synthesize bookSlot;

@synthesize selectedBookString;
@synthesize userDefaults;
@synthesize userDefArray;

const int kAvailabilityPickerTag = 2001;
const int kBookSlotPickerTag     = 2002;

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
    
    bookSlotField.hidden = YES;
    bookSlotLBL.hidden = YES;
    
    doctornameLBL.text       = doctorName;
    doctorspecialityLBL.text = doctorSpeciality;
    doctormobileLBL.text     = doctorMobile;
    doctorAddrsLBL.text      = doctorAddress;
    
    // Assign picker to selected text fields
    UIPickerView *availablePicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    availablePicker.tag = kAvailabilityPickerTag;
    availablePicker.delegate = self;
    availablePicker.dataSource = self;
    [availablePicker setShowsSelectionIndicator:YES];
    availField.inputView = availablePicker;
    
    
    // Assign picker to selected text fields
    UIPickerView *bookSlotPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    bookSlotPicker.tag = kBookSlotPickerTag;
    bookSlotPicker.delegate = self;
    bookSlotPicker.dataSource = self;
    [bookSlotPicker setShowsSelectionIndicator:YES];
    bookSlotField.inputView = bookSlotPicker;
   
    /*
     *   filter clinic name from array
     */
    for (int i = 0; i < [statArray count]; i++) {
        
        //HYScheduleDataObject *scheduleObject = [statArray objectAtIndex:i];
         availableString = ((HYScheduleDataObject *)[statArray objectAtIndex:i]).scheduleString;
        scheduleIDString = ((HYScheduleDataObject *)[statArray objectAtIndex:i]).scheduleIDString;
        
        NSLog(@"availableString : %@",availableString);
        names = [NSMutableArray arrayWithObjects:availableString, nil];
        }
}

#pragma mark -
#pragma mark UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch(pickerView.tag){
        
        case kAvailabilityPickerTag:
            
            return [names objectAtIndex:row];
            
            break;
        case kBookSlotPickerTag:
            
            return [bookSlot objectAtIndex:row];
            
            break;
        default:
            return @"Unknown Title";
            break;
    }
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case kAvailabilityPickerTag:
        {
            // If available string so hide bookslot textfield and proceed.
            // Else if isTimeSlot avail
            
            if ([availableString isEqual:@""])
            {
                NSLog(@"Enter Required Fields");
                UIAlertView *emptyFieldsAlert = [[UIAlertView alloc] initWithTitle:@"Hold on!"
                                                                           message:@"TextField should not be empty."
                                                                          delegate:self
                                                                 cancelButtonTitle:@"Cancel"
                                                                 otherButtonTitles:nil];
                [emptyFieldsAlert show];
                
            }else
            {
                if ([isTokenString isEqualToString:@"Y"])
                {
                    bookSlotField.hidden = YES;
                    bookSlotLBL.hidden = YES;
                }
                else if ([isTokenString isEqualToString:@"N"])
                {
                    bookSlotLBL.hidden = NO;
                    bookSlotField.hidden = NO;
                   
                }
                else{}
                // ApptType is NULL here
                NSDictionary *appointDict = [NSDictionary dictionaryWithObjectsAndKeys:dateHoldString,@"ApptDate",
                                             scheduleIDString,@"ScheduleID",
                                             @"",@"ApptType",
                                             @"N",@"IsScheduleForOnline",
                                             nil];
                
                NSDictionary *bookapptDict = [NSDictionary dictionaryWithObjectsAndKeys:appointDict,@"paramsfortimeslot", nil];
                NSLog(@"bookapptDict : %@",bookapptDict);
                
                // Make an API Call for sending Appointment Date, ScheduleID, Appointment Type, IsScheduleForOnline
                bookSchedule = [HYScheduleBookInterface scheduleBook:bookapptDict];
                
                bookSlot = [[NSMutableArray alloc]init];
                
                for (int j=0; j< [bookSchedule count]; j++) {
                    slotTimingString = ((HYTimeSlotDataObject *)[bookSchedule objectAtIndex:j]).startTime;
                    [bookSlot addObject:slotTimingString];
                }
            }
            
            availField.text = (NSString *)[names objectAtIndex:row];
            bookSlotField.hidden = NO;
            bookSlotLBL.hidden = NO;

            // return picker view from
            [self.availField resignFirstResponder];
        }
            break;
        case kBookSlotPickerTag:
        {
            NSLog(@"bookSlot: %@",bookSlot);
            bookSlotField.text = (NSString *)[bookSlot objectAtIndex:row];
            selectedBookString = bookSlotField.text;
             NSLog(@"selectedBookString: %@",selectedBookString);
            
            // return picker view from
            [self.bookSlotField resignFirstResponder];
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
    if (pickerView.tag == kAvailabilityPickerTag)
    {
        return names.count;
    }
    
    else if (pickerView.tag == kBookSlotPickerTag)
    {
        return bookSlot.count;
    }
    else
    return 0;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ( textField.tag == kBookSlotPickerTag )
    {
        [self.view endEditing:TRUE];
        [bookSlotField resignFirstResponder];
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

- (IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)bookAppointmentButton:(id)sender
{
    // Get Data from NSUserDefaults.
    userDefaults = [NSUserDefaults standardUserDefaults];
    userDefArray = [[NSMutableArray alloc]init];
    userDefArray = [userDefaults  objectForKey:@"loginCodeKey"];
   
    if (userDefArray == NULL) {
        
        NSLog(@"Show SignIn View.");
        
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                                 bundle: nil];
        HYSignInViewController *signController = (HYSignInViewController *)[mainStoryboard
                                                            instantiateViewControllerWithIdentifier: @"signInVC"];
        
        signController.doctorName = doctorName;
        signController.doctorEmail = doctorEmail;
        signController.doctorSpeciality = doctorSpeciality;
        signController.doctorMobile = doctorMobile;
        signController.doctorAddress = doctorAddress;
        signController.doctorPhone = doctorPhone;
        signController.doctorID = doctorID;
        signController.doctorPin = doctorPin;
        signController.doctorLocality = doctorLocality;
        signController.dateHoldString = dateHoldString;
        signController.selectedBookString = selectedBookString;
        
        signController.clinicAddString = clinicAddString;
        signController.hospitalIDString = hospitalIDString;
        signController.hospitalNameString = hospitalNameString;
        signController.hospitalPhoneString = hospitalPhoneString;
        signController.hospitalLocalityString = hospitalLocalityString;
        signController.hospitalPinString = hospitalPinString;
        signController.hospitalMobileString = hospitalMobileString;
        signController.hospitalCityString = hospitalCityString;
        
        signController.statChangeArray = bookSchedule;
        
        [self presentViewController:signController animated:YES completion:nil];
    }
    else {
        
        NSLog(@"Show Verification Appointment View.");
        
        // Navigation logic may go here. Create and push another view controller.
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                                 bundle: nil];
        HYVerifyAppointmentViewController *controller = (HYVerifyAppointmentViewController *)[mainStoryboard
                                                                                              instantiateViewControllerWithIdentifier: @"verifyAppointmentVC"];
        controller.doctorName = doctorName;
        controller.doctorEmail = doctorEmail;
        controller.doctorSpeciality = doctorSpeciality;
        controller.doctorMobile = doctorMobile;
        controller.doctorAddress = doctorAddress;
        controller.dateHoldString = dateHoldString;
        controller.doctorID = doctorID;
        controller.doctorLocality = doctorLocality;
        controller.doctorPin = doctorPin;
        
        controller.password =[userDefArray objectAtIndex:0];
        NSLog(@"password : %@",controller.password);
        controller.userName = [userDefArray objectAtIndex:1];
        controller.patient = [userDefArray objectAtIndex:2];
        controller.patientCode = [userDefArray objectAtIndex:3];
        controller.patientMobile = [userDefArray objectAtIndex:4];
        controller.patientEmail = [userDefArray objectAtIndex:5];
        controller.patientHYPIN = [userDefArray objectAtIndex:6];
        controller.patientID = [userDefArray objectAtIndex:7];
        controller.patientPin = [userDefArray objectAtIndex:8];
        

        controller.scheduleString = availableString;
        controller.scheduleIDString = scheduleIDString;
        //controller.messageString = messageString;
        controller.isOnCallString = isOnCallString;
        controller.isTokenBaseString = isTokenString;
        
        controller.selectedBookString = selectedBookString;
        controller.clinicAddString = clinicAddString;
        controller.hospitalIDString = hospitalIDString;
        controller.hospitalNameString = hospitalNameString;
        controller.hospitalPhoneString = hospitalPhoneString;
        controller.hospitalLocalityString = hospitalLocalityString;
        controller.hospitalPinString = hospitalPinString;
        controller.hospitalMobileString = hospitalMobileString;
        controller.hospitalCityString = hospitalCityString;

        [self presentViewController:controller animated:YES completion:nil];
     }
   }

@end
