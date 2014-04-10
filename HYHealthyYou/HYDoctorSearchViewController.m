//
//  HYDoctorSearchViewController.m
//  HYHealthyYou
//
//  Created by Manish Parihar on 27/02/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import "HYDoctorSearchViewController.h"
#import "HYDoctorSearchInterface.h"
#import "HYDoctorDetailDataObject.h"
#import "HYDoctorInfoViewController.h"
#import "HYDoctorCell.h"
#import "HYDoctorDetailsInterface.h"
#import "HYHospitalDataObject.h"
#import "HYHealtyYouAppDelegate.h"

@interface HYDoctorSearchViewController ()
@property (nonatomic, strong)  NSString *nameString;
@property (nonatomic, strong)  NSString *locationString;
@property (nonatomic, strong)  NSString *specialityString;
@property (nonatomic, strong)  NSDictionary *searchDict;
@property (nonatomic, strong)  NSMutableArray *detailArray;
@property (nonatomic, strong)  NSString *searchStringCopy;

@end

@implementation HYDoctorSearchViewController

@synthesize searchTable;
@synthesize filteredSearchList;
@synthesize nameButton;
@synthesize locationButton;
@synthesize specialityButton;
@synthesize nameString;
@synthesize locationString;
@synthesize specialityString;
@synthesize searchDict;
@synthesize detailArray;
@synthesize searchStringCopy;

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
    [self.searchTable setHidden:YES];
    
    // set boolean variable to NO, and allocate and initialize filteredSearchList.
    isSearching = NO;
    filteredSearchList = [[NSMutableArray alloc]init];
    [self.searchDoctors becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nameButton:(id)sender {
    nameString = @"name";
    searchDict = [NSDictionary dictionaryWithObjectsAndKeys:nameString,@"TypesOnSearch",
                  _searchDoctors.text,@"CharactersToSearch",
                  nil];
    NSLog(@"searchDict : %@ ",searchDict);
}

- (IBAction)locationButton:(id)sender {
    locationString = @"location";
    searchDict = [NSDictionary dictionaryWithObjectsAndKeys:locationString,@"TypesOnSearch",
                  _searchDoctors.text,@"CharactersToSearch",
                  nil];
}

- (IBAction)specialityButton:(id)sender {
    specialityString = @"speciality";
    searchDict = [NSDictionary dictionaryWithObjectsAndKeys:specialityString,@"TypesOnSearch",
                  _searchDoctors.text,@"CharactersToSearch",
                  nil];
}

#pragma mark - UISearchBar Delegate

-(void)viewDidAppear:(BOOL)animated{
    [self searchDoctors].delegate = self;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self searchDoctors].text=@"";
    [searchTable reloadData];
    [searchTable resignFirstResponder];
    [self.view endEditing:YES];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self searchDatabase:_searchDoctors.text];
    [self searchDoctors].text=@"";
    [searchTable reloadData];
    [searchTable resignFirstResponder];
}

- (void)searchDatabase:(NSString*)searchTerm{
    searchStringCopy = searchTerm;
    NSLog(@"searchStringCopy : %@",searchStringCopy);
    self.filteredSearchList = [HYDoctorSearchInterface searchDoctors:searchTerm];
    [self.searchTable setHidden:NO];
    [self.searchTable reloadData];
    
    return;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [filteredSearchList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"doctorDetailCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if ( cell == nil ) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] accessibilityElementAtIndex:1];
    }
    // Configure the cell...
    HYDoctorDetailDataObject *nameObj = [filteredSearchList objectAtIndex:indexPath.row];
   
    NSString *prefixString = [[NSString alloc]init];
    
    prefixString = @"Dr. ";
    
    prefixString = [prefixString stringByAppendingString:nameObj.doctorName];
    
    cell.textLabel.text = prefixString;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    [self performSegueWithIdentifier:@"doctorDetailCell" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id) sender {
    
    if ([segue.identifier isEqualToString:@"doctorDetailCell"]) {
        
        UITableViewCell *cell = (UITableViewCell *)sender;
        NSIndexPath *indexPath = [self.searchTable indexPathForCell:cell];
        
       // NSLog(@"Index Path Row : %ld", (long)indexPath.row);
        
        HYDoctorDetailDataObject * nameObj = [self.filteredSearchList objectAtIndex:indexPath.row];
        
        HYDoctorInfoViewController *destViewController = segue.destinationViewController;
        
        destViewController.doctorID = nameObj.doctorID;
       
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:destViewController.doctorID,@"DoctorID", nil];

        NSDictionary *dictTemp = [NSDictionary dictionaryWithObjectsAndKeys:dict,@"DrID", nil];
        
        NSLog(@"dictTemp: %@",dictTemp);
        
        // Make an API call
        detailArray = [HYDoctorDetailsInterface getDoctorsDetails:dictTemp];
        
        @try {
            
            destViewController.doctorName = nameObj.doctorName;
            destViewController.doctorAddress = nameObj.doctorAddress;
            destViewController.doctorEmail = nameObj.doctorEmail;
            destViewController.doctorID = nameObj.doctorID;
            destViewController.doctorLocality = nameObj.doctorLocality;
            destViewController.doctorMobile = nameObj.doctorMobile;
            destViewController.doctorPhone = nameObj.doctorPhone;
            destViewController.doctorPin = nameObj.doctorPin;
            destViewController.doctorSpeciality = nameObj.doctorSpeciality;
            
            destViewController.holdTempArray = detailArray;
        }
        @catch (NSException *exception) {
            
            //This finds out which kind of exception it is.
            NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"We're sorry"
                                                                message:@"An error occured on the server"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Close"
                                                      otherButtonTitles:nil];
            [alertView show];
            
        }
        @finally
        {
        }

    }
}


@end
