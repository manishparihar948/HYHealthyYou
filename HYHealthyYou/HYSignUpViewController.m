//
//  HYSignUpViewController.m
//  HYHealthyYou
//
//  Created by Manish Parihar on 06/03/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import "HYSignUpViewController.h"
#import "HYSignUpInterface.h"
#import "HYSignUpDataObject.h"

@interface HYSignUpViewController ()
{
    NSString *firstName,
             *middleName,
             *lastName,
             *email,
             *gender,
             *dob,
             *country,
             *mobileNumber;
}
@end

@implementation HYSignUpViewController

const int kCountryNamePickerTag = 3001;
const int kDobPickerTag         = 3002;

@synthesize firstnameField,
            middlenameField,
            lastnameField,
            emailField,
            genderSegment,
            mobileNoField,
            countryField,
            dobField;



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
    firstnameField.delegate  = self;
    lastnameField.delegate   = self;
    middlenameField.delegate = self;
    emailField.delegate      = self;
    mobileNoField.delegate   = self;
    
    // Assign DatePicker to TextField
    UIDatePicker *selectDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 40.0)];
    selectDatePicker.datePickerMode = UIDatePickerModeDate;
    dobField.inputView = selectDatePicker;
    [selectDatePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
  
    // Assign picker to selected text fields
    UIPickerView *countryPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    countryPicker.tag = kCountryNamePickerTag;
    countryPicker.delegate = self;
    countryPicker.dataSource = self;
    [countryPicker setShowsSelectionIndicator:YES];
    countryField.inputView = countryPicker;
    
    countryArray = [NSMutableArray arrayWithObjects:@"India",@"Mauritius",nil];
}


// Date Change for picker
- (void)dateChanged
{
    UIDatePicker *datePicker = (UIDatePicker *)dobField.inputView;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    dobField.text = [dateFormatter stringFromDate:datePicker.date];
}

//Action method executes when user touches the button
-(IBAction) segmentedControlIndexChanged{
    switch (self.genderSegment.selectedSegmentIndex) {
        case 0:
            gender = @"Male";
            NSLog(@"gender : %@",gender);
            break;
		case 1:
            gender = @"Female";
            NSLog(@"gender : %@",gender);
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self setFirstnameField:nil];
    [self setLastnameField:nil];
    [self setMiddlenameField:nil];
    [self setEmailField:nil];
    [self setMobileNoField:nil];
}

#pragma mark -
#pragma mark UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag == kCountryNamePickerTag)
    {
        return [countryArray objectAtIndex:row];
    }
    
    return @"Unknown title";
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case kCountryNamePickerTag:
        {
            countryField.text = (NSString *)[countryArray objectAtIndex:row];
            // return picker view from
            [self.countryField resignFirstResponder];
        }
            break;
        case kDobPickerTag:
        {
            // return picker view from
            [self.dobField resignFirstResponder];
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
    if (pickerView.tag == kCountryNamePickerTag)
    {
        return countryArray.count;
    }
    return 1;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ( textField.tag == kDobPickerTag )
    {
        [self.view endEditing:TRUE];
        [dobField resignFirstResponder];
        return NO;
    }
    else
    {
        return YES;
    }
}


-(IBAction)submitUserData:(id)sender
{
    if ([firstnameField.text isEqual: @""] ||[lastnameField.text isEqual:@""]  || [emailField.text isEqual:@""]      ||
         [mobileNoField.text isEqual:@""]  || [countryField.text isEqual:@""]  || [dobField.text isEqual:@""])
    {
        NSLog(@"Enter Required Fields");
        UIAlertView *emptyFieldsAlert = [[UIAlertView alloc] initWithTitle:@"Hold on!"
                                                                   message:@"TextField should not be empty."
                                                                  delegate:self
                                                         cancelButtonTitle:@"Cancel"
                                                         otherButtonTitles:nil];
        [emptyFieldsAlert show];
    }
    else
    {
        firstName = firstnameField.text;
        middleName = middlenameField.text;
        lastName = lastnameField.text;
        mobileNumber = mobileNoField.text;
        email = emailField.text;
        dob = dobField.text;
        /*
         *  value of firstname,middlename,lastname,genderselected,dobvalue,countryid,mobileno,emailid
         */
        NSMutableArray *userDetails = [[NSMutableArray alloc]init];

        
        NSDictionary *userDict = [NSDictionary dictionaryWithObjectsAndKeys:firstName,@"FirstName",
                                                                                  middleName,@"MiddleName",
                                                                                  lastName,@"LastName",
                                                                                  gender,@"Gender",
                                                                                  dob,@"DOB",
                                                                                  @"1",@"CountryID",
                                                                                  mobileNumber,@"Mobile",
                                                                                  email,@"Email",nil];
         
        NSDictionary *userData = [NSDictionary dictionaryWithObjectsAndKeys:userDict,@"Patient",nil];
       
        NSLog(@"userData: %@",userData);
       
        userDetails = [HYSignUpInterface signUpUser:userData];
        
        for (int i = 0; i < [userDetails count]; i++)
        {
            HYSignUpDataObject * nameObj = [userDetails objectAtIndex:i];
            UIAlertView *successMsg = [[UIAlertView alloc] initWithTitle:@"Message!"
                                                                 message:nameObj.saveMessage
                                                                delegate:self
                                                       cancelButtonTitle:@"Ok"
                                                       otherButtonTitles:nil];
            [successMsg show];
        }
    }
}

-(IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [firstnameField resignFirstResponder];
    [middlenameField resignFirstResponder];
    [lastnameField resignFirstResponder];
    [emailField resignFirstResponder];
    [mobileNoField resignFirstResponder];
    [countryField resignFirstResponder];
    [dobField resignFirstResponder];
    
    return YES;
}

@end
