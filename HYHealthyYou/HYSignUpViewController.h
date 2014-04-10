//
//  HYSignUpViewController.h
//  HYHealthyYou
//
//  Created by Manish Parihar on 06/03/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYSignUpViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
{
    @public
    NSMutableArray *countryArray;
}
@property (weak, nonatomic) IBOutlet UITextField *firstnameField;
@property (weak, nonatomic) IBOutlet UITextField *lastnameField;
@property (weak, nonatomic) IBOutlet UITextField *middlenameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *mobileNoField;
@property (weak, nonatomic) IBOutlet UITextField *countryField;
@property (weak, nonatomic) IBOutlet UITextField *dobField;


@property (strong, nonatomic) IBOutlet UISegmentedControl *genderSegment;

@property (strong, nonatomic) IBOutlet UIButton    *submitButton;
@property (strong, nonatomic) IBOutlet UIButton    *cancelButton;

-(IBAction)submitUserData:(id)sender;
-(IBAction)cancel:(id)sender;
-(IBAction) segmentedControlIndexChanged;
@end
