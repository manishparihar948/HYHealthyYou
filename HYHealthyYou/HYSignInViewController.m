//
//  HYSignInViewController.m
//  HYHealthyYou
//
//  Created by Manish Parihar on 01/03/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import "HYSignInViewController.h"
#import "HYSignInInterface.h"
#import "HYPatientDataObject.h"
#import "HYOnlineDPCDInterface.h"
#import "HYOnlineStatusDataObject.h"
#import "HYVerifyAppointmentViewController.h"
#import "HYTimeSlotDataObject.h"

@interface HYSignInViewController ()

@property (nonatomic, strong) NSMutableArray *holdCredentialArray;
@property (nonatomic,strong) NSMutableArray *holdDocDetailsArray;

@end

@implementation HYSignInViewController
{
    NSString *userid;
    NSString *password;
}

@synthesize userField;
@synthesize pwdField;
@synthesize holdCredentialArray;

@synthesize doctorLBL,
            patientLBL,
            diagnosticLBL,
            chemistLBL;

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

@synthesize statChangeArray;
@synthesize scheduleIDString,
            scheduleString,
            messageString,
            isOnCallString,
            isTokenBaseString;

@synthesize clinicAddString;
@synthesize hospitalIDString,
            hospitalCityString,
            hospitalLocalityString,
            hospitalMobileString,
            hospitalNameString,
            hospitalPhoneString,
            hospitalPinString;

@synthesize selectedBookString;

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
    
    /*
     *   To display online Doctors, Patient, Chemist and Diagnostic Center Status.
     *   Make an API call here
     */
    NSMutableArray *newArray = [[NSMutableArray alloc]init];
   
    for (int i=0; i< [statChangeArray count]; i++) {
        isTokenBaseString = ((HYTimeSlotDataObject *)[statChangeArray objectAtIndex:i]).isTokenBase;
        isOnCallString = ((HYTimeSlotDataObject *)[statChangeArray objectAtIndex:i]).isOnCall;
    }
    NSDictionary *statusDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"0",@"Count", nil];
    
    NSDictionary *finalDictionary = [NSDictionary dictionaryWithObjectsAndKeys:statusDictionary,@"checkcount", nil];
    
    NSLog(@"finalDictionary :%@",finalDictionary);
    
    // Make API call for online status
    newArray = [HYOnlineDPCDInterface onlineCount: finalDictionary];
    
    HYOnlineStatusDataObject * nameObj = [newArray objectAtIndex:0];
    
    doctorLBL.text     = nameObj.doctorsStirng.stringValue;
    patientLBL.text    = nameObj.patientsString.stringValue;
    diagnosticLBL.text = nameObj.diagnosticsString.stringValue;
    chemistLBL.text    = nameObj.chemistsString.stringValue;
    
    // Hold doctor information in signin page.
}

-(IBAction)login:(id)sender
{
    userid = userField.text;
    password = pwdField.text;
    
    holdCredentialArray = [[NSMutableArray alloc]init];
    
    if (([userField.text isEqual: @""] || [pwdField.text isEqual:@""])) {
        NSLog(@"Enter Username and Password");
        UIAlertView *emptyFieldsAlert = [[UIAlertView alloc] initWithTitle:@"Hold on!"
                                                                   message:@"Email and password can't be empty."
                                                                  delegate:self
                                                         cancelButtonTitle:@"Cancel"
                                                         otherButtonTitles:nil];
        [emptyFieldsAlert show];
    } else
    {
        // Post and Get Response Method Call
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:userid,@"UserID",
                              password,@"Password",
                              nil];
        
        NSDictionary *credit = [NSDictionary dictionaryWithObjectsAndKeys:dict,@"Credential", nil];
        
        NSLog(@"credit : %@",credit);
        
        //holdCredentialArray = [HYSignInInterface getOnlineDisplayData:credit];
        
        
        HYPatientDataObject *patObj = [[HYPatientDataObject alloc]init];
        
        // Remove comments later.
        
        NSString *docURL1 = [NSString stringWithFormat:@"http://192.168.2.4/HYEHR_WCFService/Authenticate.svc/CheckPtAuthentication"];
        
        NSLog(@"docURL1 : %@",docURL1);
        
        NSError *error;
        
        // Convert object to data
        NSData* postData = [NSJSONSerialization dataWithJSONObject:credit options:kNilOptions error:&error];
        NSString *postString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        NSLog(@"postString: %@",postString);
        NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
        
        [request setURL:[NSURL URLWithString:docURL1]];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setHTTPBody:postData];
        
        // Perform request and get JSON as a NSData object
        NSData *jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        if (jsonData) {
            
            NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"str: %@", str);
            // Parse the retrieved JSON to an NSArray
            NSError* e;
            
            NSDictionary* JSON =
            [NSJSONSerialization JSONObjectWithData: jsonData
                                            options: NSJSONReadingMutableContainers error: &e];
            
            if ([JSON isKindOfClass:[NSDictionary class]])
            {
                // Array of Payment Details
                NSArray *responseArray = [JSON objectForKey:@"CheckPtAuthenticationResult"];
                for (int i=0; i<[responseArray count]; i++)
                {
                    id docSearchDetailObj = [responseArray objectAtIndex:i];
                    
                    //NSLog(@"docSearchDetailObj type is %@",[[docSearchDetailObj class] description]);
                    
                    if ([docSearchDetailObj isKindOfClass:[NSDictionary class]])
                    {
                        NSMutableDictionary *attrs = ((NSMutableDictionary*)docSearchDetailObj);
                        
                        patObj.patient = [attrs objectForKey:@"PatientFullname"];
                        patObj.patientCode = [attrs objectForKey:@"PatientCode"];
                        patObj.patientEmail = [attrs objectForKey:@"PatientEmail"];
                        patObj.patientHYPIN = [attrs objectForKey:@"PatientHYPIN"];
                        patObj.patientID = [attrs objectForKey:@"PatientID"];
                        patObj.patientMobile = [attrs objectForKey:@"PatientMobile"];
                        patObj.patientPin = [attrs objectForKey:@"PatientPin"];
                        patObj.patientUID = [attrs objectForKey:@"PatientU_ID"];
                        patObj.patientPassword = [attrs objectForKey:@"Patientpassword"];
                    }
                }
                [holdCredentialArray addObject:patObj];
            }
            else if ([JSON isKindOfClass:[NSDictionary class]])
            {
            }
            else
            {
            }
        } else {
        }
        
        NSLog(@"Login Successful");
        
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
        
        controller.patient = patObj.patient;
        controller.patientCode = patObj.patientCode ;
        controller.patientEmail = patObj.patientEmail;
        controller.patientHYPIN = patObj.patientHYPIN;
        controller.patientID = patObj.patientID;
        controller.patientMobile = patObj.patientMobile;
        controller.patientPin = patObj.patientPin;
        controller.userName = patObj.patientPassword;
        controller.password = patObj.patientUID;
        
        controller.scheduleString = scheduleString;
        controller.scheduleIDString = scheduleIDString;
        controller.messageString = messageString;
        controller.isOnCallString = isOnCallString;
        controller.isTokenBaseString = isTokenBaseString;

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.userField = nil;
    self.pwdField  = nil;
}
@end
