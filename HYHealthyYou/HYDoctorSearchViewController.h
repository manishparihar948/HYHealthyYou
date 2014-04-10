//
//  HYDoctorSearchViewController.h
//  HYHealthyYou
//
//  Created by Manish Parihar on 27/02/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYDoctorSearchViewController : UIViewController <UISearchBarDelegate, UISearchDisplayDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *searchTable;
    
    BOOL isSearching;
    NSMutableArray *filteredSearchList;
    
    UIButton *nameButton;
    UIButton *locationButton;
    UIButton *specialityButton;
}

@property (nonatomic, strong) IBOutlet UITableView *searchTable;
@property (nonatomic, strong) NSMutableArray *filteredSearchList;
@property (nonatomic, strong) IBOutlet UISearchBar *searchDoctors;
@property (nonatomic, strong) UIButton *nameButton;
@property (nonatomic, strong) UIButton *locationButton;
@property (nonatomic, strong) UIButton *specialityButton;

- (IBAction)nameButton:(id)sender;
- (IBAction)locationButton:(id)sender;
- (IBAction)specialityButton:(id)sender;

@end
