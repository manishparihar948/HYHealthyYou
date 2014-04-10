//
//  HYDoctorSearchInterface.m
//  HYHealthyYou
//
//  Created by Manish Parihar on 27/02/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import "HYDoctorSearchInterface.h"
#import "HYDoctorDetailDataObject.h"

@implementation HYDoctorSearchInterface

+ (NSMutableArray*) searchDoctors:(NSString*)searchString
{
    NSMutableArray* DocSearchedArray = [[NSMutableArray alloc] init];
    
    // Get the API Call From PLIST.
    NSString *urlPath = [[NSBundle mainBundle] pathForResource:@"HYHealthyYouApi" ofType:@"plist"];
    
    // Load the file content and read the data into arrays.
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:urlPath];
    NSString *docURL1 = [dict objectForKey:@"URL"];
    NSString *docURL2 = @"/DoctorService.svc/GetDoctorsList";
    NSString *combineDocUrl = [docURL1 stringByAppendingString:docURL2];
    NSLog(@"combineDocUrl : %@",combineDocUrl);
    
    NSLog(@"searchString: %@",searchString);
    
    NSDictionary *dictOne = [NSDictionary dictionaryWithObjectsAndKeys:searchString,@"CharactersToSearch",
                             @"name",@"TypesOnSearch",
                             nil];
    //NSLog(@"dictOne : %@",dictOne);    
    
    NSDictionary *dictTwo = [NSDictionary dictionaryWithObjectsAndKeys:dictOne,@"Params", nil];
    
    //NSLog(@"dictTwo : %@",dictTwo);
    
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
    
    NSError *error;
    
    // Convert object to data
    NSData* postData = [NSJSONSerialization dataWithJSONObject:dictTwo options:kNilOptions error:&error];
    NSString *postString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"postString: %@",postString);
    
    [request setURL:[NSURL URLWithString:combineDocUrl]];
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
            NSArray *responseArray = [JSON objectForKey:@"GetDoctorsListResult"];
            for (int i=0; i<[responseArray count]; i++)
            {
                id docSearchDetailObj = [responseArray objectAtIndex:i];
                
                //NSLog(@"docSearchDetailObj type is %@",[[docSearchDetailObj class] description]);
                
                if ([docSearchDetailObj isKindOfClass:[NSDictionary class]])
                {
                    NSMutableDictionary *attrs = ((NSMutableDictionary*)docSearchDetailObj);
                    
                    HYDoctorDetailDataObject *docObj = [[HYDoctorDetailDataObject alloc]init];
                    
                    docObj.doctorName = [attrs objectForKey:@"DoctorName"];
                    docObj.doctorAddress = [attrs objectForKey:@"DoctorAddress"];
                    docObj.doctorClinics = [attrs objectForKey:@"DoctorClinics"];
                    docObj.doctorEmail = [attrs objectForKey:@"DoctorEmail"];
                    docObj.doctorID = [attrs objectForKey:@"DoctorID"];
                    docObj.doctorLocality = [attrs objectForKey:@"DoctorLocality"];
                    docObj.doctorMobile = [attrs objectForKey:@"DoctorMobile"];
                    docObj.doctorPhone = [attrs objectForKey:@"DoctorPhone"];
                    docObj.doctorPin = [attrs objectForKey:@"DoctorPin"];
                    docObj.doctorSpeciality = [attrs objectForKey:@"Doctorspeciality"];
                    
                    [DocSearchedArray addObject:docObj];
                }
            }
        }
        else if ([JSON isKindOfClass:[NSDictionary class]])
        {
            
        }
        else
        {
            
        }
    } else {
    }
    
    return DocSearchedArray;
}


@end
