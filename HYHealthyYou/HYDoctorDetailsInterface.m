//
//  HYDoctorDetailsInterface.m
//  HYHealthyYou
//
//  Created by Manish Parihar on 28/02/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import "HYDoctorDetailsInterface.h"
#import "HYDoctorDetailDataObject.h"
#import "HYHospitalDataObject.h"

@implementation HYDoctorDetailsInterface

+ (NSMutableArray*) getDoctorsDetails: (NSDictionary*)docIDDict
{
    NSMutableArray* docDetailsArray = [[NSMutableArray alloc] init];
    
    // Get the API Call From PLIST.
    NSString *urlPath = [[NSBundle mainBundle] pathForResource:@"HYHealthyYouApi" ofType:@"plist"];
    
    // Load the file content and read the data into arrays.
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:urlPath];
    
    NSString *docURL1 = [dict objectForKey:@"URL"];
    
    NSString *docURL2 = @"/DoctorService.svc/GetDoctorByID";
    
    NSString *combineDocUrl = [docURL1 stringByAppendingString:docURL2];
    
    NSLog(@"combineDocUrl : %@",combineDocUrl);
    
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
    
    NSError *error;
    
    // NSLog(@"docIDDict : %@",docIDDict);
    
    // Convert object to data
    NSData* postData = [NSJSONSerialization dataWithJSONObject:docIDDict options:kNilOptions error:&error];
    
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
            
            NSMutableArray *items = [JSON valueForKey:@"GetDoctorByIDResult"];
            for (int i =0; i<[items count]; i++) {
                
                id docSearchDetailObj = [items objectAtIndex:i];
                
                if ([docSearchDetailObj isKindOfClass:[NSDictionary class]])
                {
                    NSMutableDictionary *attrs = ((NSMutableDictionary*)docSearchDetailObj);
                    
                    HYDoctorDetailDataObject *docObj = [[HYDoctorDetailDataObject alloc]init];
                    
                    docObj.doctorName = [attrs objectForKey:@"DoctorName"];
                    
                    docObj.doctorAddress = [attrs objectForKey:@"DoctorAddress"];
                    
                    docObj.doctorEmail = [attrs objectForKey:@"DoctorEmail"];
                    
                    docObj.doctorID = [attrs objectForKey:@"DoctorID"];
                    
                    docObj.doctorLocality = [attrs objectForKey:@"DoctorLocality"];
                    
                    docObj.doctorMobile = [attrs objectForKey:@"DoctorMobile"];
                    
                    docObj.doctorPhone = [attrs objectForKey:@"DoctorPhone"];
                    
                    docObj.doctorPin = [attrs objectForKey:@"DoctorPin"];
                    
                    docObj.doctorSpeciality = [attrs objectForKey:@"Doctorspeciality"];
                    
                    docObj.doctorClinics = [attrs objectForKey:@"DoctorClinics"];
                    
                    NSData *data = [docObj.doctorClinics dataUsingEncoding:NSUTF8StringEncoding];
                    
                    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    
                    HYHospitalDataObject *hospData = [[HYHospitalDataObject alloc]init];
                    
                    for(NSDictionary *dictn in json)
                    {
                        hospData.hospitalName =[dictn valueForKey:@"HospitalName"];
                        
                        hospData.hospitalID =[dictn valueForKey:@"HospitalID"];
                        
                        NSLog(@"HospitalName: %@",hospData.hospitalName);
                        
                        [docDetailsArray addObject:hospData];
                    }
                    [docDetailsArray addObject:docObj];
                }
            }
        }
        else if ([JSON isKindOfClass:[NSArray class]])
        {
        }
        else
        {
        }
    }
    else
    {
    }
    return docDetailsArray;
}

@end
