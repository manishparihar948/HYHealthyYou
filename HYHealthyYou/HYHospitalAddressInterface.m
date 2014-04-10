//
//  HYHospitalAddressInterface.m
//  HYHealthyYou
//
//  Created by mediit on 3/19/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import "HYHospitalAddressInterface.h"
#import "HYHospitalDataObject.h"

@implementation HYHospitalAddressInterface

+ (NSMutableArray*) getHospitalDetails: (NSDictionary*)hospitalIDDict
{
    NSMutableArray *hospArray = [[NSMutableArray alloc]init];
    
    // Get the API Call From PLIST.
    NSString *urlPath = [[NSBundle mainBundle] pathForResource:@"HYHealthyYouApi" ofType:@"plist"];
    
    // Load the file content and read the data into arrays.
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:urlPath];
    
    NSString *docURL1 = [dict objectForKey:@"URL"];
    
    NSString *docURL2 = @"/DoctorService.svc/GetHospitalByID";
    
    NSString *combineDocUrl = [docURL1 stringByAppendingString:docURL2];
    
    NSLog(@"combineDocUrl : %@",combineDocUrl);
    
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
    
    NSError *error;
    
    // Convert object to data
    NSData* postData = [NSJSONSerialization dataWithJSONObject:hospitalIDDict options:kNilOptions error:&error];
    
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
            
            NSMutableArray *items = [JSON valueForKey:@"GetHospitalByIDResult"];
            for (int i =0; i<[items count]; i++) {
                
                id docSearchDetailObj = [items objectAtIndex:i];
                
                if ([docSearchDetailObj isKindOfClass:[NSDictionary class]])
                {
                    NSMutableDictionary *attrs = ((NSMutableDictionary*)docSearchDetailObj);
                    
                    HYHospitalDataObject *hosObj = [[HYHospitalDataObject alloc]init];
                    hosObj.hospitalName     = [attrs objectForKey:@"HospitalName"];
                    hosObj.hospitalID       = [attrs objectForKey:@"HospitalID"];
                    hosObj.hospitalAddress  = [attrs objectForKey:@"HospitalAddress"];
                    hosObj.hospitalCity     = [attrs objectForKey:@"HospitalCity"];
                    hosObj.hospitalLocality = [attrs objectForKey:@"HospitalLocality"];
                    hosObj.hospitalMobile   = [attrs objectForKey:@"HospitalMobile"];
                    hosObj.hospitalPhone    = [attrs objectForKey:@"HospitalPhone"];
                    hosObj.hospitalPin      = [attrs objectForKey:@"HospitalPin"];
                    
                    [hospArray addObject:hosObj];
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
    return hospArray;
}

@end
