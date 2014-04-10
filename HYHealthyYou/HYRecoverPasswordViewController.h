//
//  HYRecoverPasswordViewController.h
//  HYHealthyYou
//
//  Created by mediit on 3/11/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYRecoverPasswordViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *recoveryField;

- (IBAction)recoverPassword:(id)sender;

- (IBAction)cancel:(id)sender;

@end
