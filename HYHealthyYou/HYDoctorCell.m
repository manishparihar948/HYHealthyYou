//
//  HYDoctorCell.m
//  HYHealthyYou
//
//  Created by Manish Parihar on 28/02/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import "HYDoctorCell.h"

@implementation HYDoctorCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom Code Here
        UIColor *theFontColor = [UIColor colorWithRed:255.0f/255.0f green:100.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        self.textLabel.textColor = theFontColor;
        self.textLabel.font = [UIFont systemFontOfSize:12.0];
        }
    
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
