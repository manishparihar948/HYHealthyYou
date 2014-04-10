//
//  HYDoctorSearchTableView.m
//  HYHealthyYou
//
//  Created by Manish Parihar on 28/02/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import "HYDoctorSearchTableView.h"

@implementation HYDoctorSearchTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (id)initWithCoder:(NSCoder *)aDecoder
{
    /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Debug message"
     message:@"Healthy You Table View Initiated"
     delegate:nil
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     [alert show];
     */
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom Code Here
        //[self setBackgroundColor:[UIColor colorWithRed:(229.0f/255.0f) green:(248.0f/255.0f) blue:(235.0f/255.0f) alpha:1.0f]];
        
        [self setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        
        [self setBackgroundColor:[UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f]];
        
        //[self.layer set]
    }
    
    return self;
}


@end
