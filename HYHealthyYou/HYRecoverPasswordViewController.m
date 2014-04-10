//
//  HYRecoverPasswordViewController.m
//  HYHealthyYou
//
//  Created by mediit on 3/11/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import "HYRecoverPasswordViewController.h"
#import "HYRecoverPwdInterface.h"
#import "HYRecoverDataObject.h"

@interface HYRecoverPasswordViewController ()

@end

@implementation HYRecoverPasswordViewController

@synthesize recoveryField;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)recoverPassword:(id)sender
{
    
    NSString *pwdString = recoveryField.text;
    
    if ([recoveryField.text isEqual:@""])
    {
        NSLog(@" Email-Id");
        
        UIAlertView *emptyFieldsAlert = [[UIAlertView alloc] initWithTitle:@"Warning!"
                                                               message:@"Email should not be empty."
                                                              delegate:self
                                                     cancelButtonTitle:@"Cancel"
                                                     otherButtonTitles:nil];
        [emptyFieldsAlert show];
        
    }
    else{
    
        NSDictionary *pwdDictionary = [NSDictionary dictionaryWithObjectsAndKeys:pwdString,@"UserID",nil];
        
        NSMutableArray *emailSend = [[NSMutableArray alloc]init];
        
        NSDictionary *dictNew = [NSDictionary dictionaryWithObjectsAndKeys:pwdDictionary,@"catchforgotpwd", nil];
        
        NSLog(@"dictNew: %@",dictNew);
        
        emailSend = [HYRecoverPwdInterface recoverPassword:dictNew];
       
        for (int i = 0; i < [emailSend count]; i++)
        {
            HYRecoverDataObject * nameObj = [emailSend objectAtIndex:i];
            UIAlertView *successMsg = [[UIAlertView alloc] initWithTitle:@"Message!"
                                                                   message:nameObj.returnMsg
                                                                  delegate:self
                                                         cancelButtonTitle:@"Ok"
                                                         otherButtonTitles:nil];
        [successMsg show];
        }
    }
}

- (IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [recoveryField resignFirstResponder];
    return YES;
}

@end
