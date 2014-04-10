//
//  HYSignInInterface.m
//  HYHealthyYou
//
//  Created by mediit on 3/7/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import "HYSignInInterface.h"
#import "HYPatientDataObject.h"

@implementation HYSignInInterface


+ (NSMutableArray *)getOnlineDisplayData : (NSDictionary *)displayDict {
    
    NSMutableArray* signedArray = [[NSMutableArray alloc] init];
    
    HYPatientDataObject *patObj = [[HYPatientDataObject alloc]init];

    // Get the API Call From PLIST.
    NSString *urlPath = [[NSBundle mainBundle] pathForResource:@"HYHealthyYouApi" ofType:@"plist"];
    
    // Load the file content and read the data into arrays.
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:urlPath];
    NSString *docURL1 = [dict objectForKey:@"URL"];
    NSString *docURL2 = @"/Authenticate.svc/CheckPtAuthentication";
    NSString *combineDocUrl = [docURL1 stringByAppendingString:docURL2];
    NSLog(@"combineDocUrl : %@",combineDocUrl);
    
    NSError *error;
    
    // Convert object to data
    NSData* postData = [NSJSONSerialization dataWithJSONObject:displayDict options:kNilOptions error:&error];
    NSString *postString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"postString: %@",postString);
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:docURL1]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:postData];
    
    // Perform request and get JSON as a NSData object
    NSData *jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if (jsonData)
    {
        NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"str: %@", str);
        // Parse the retrieved JSON to an NSArray
        NSError* e;
        
        NSDictionary* JSON = [NSJSONSerialization JSONObjectWithData:jsonData
                                                             options: NSJSONReadingMutableContainers error: &e];
        NSLog(@"JSON: %@", JSON);
        if ([JSON isKindOfClass:[NSDictionary class]])
        {
            // Array of Payment Details
            NSArray *responseArray = [JSON objectForKey:@"CheckPtAuthenticationResult"];
            for (int i=0; i<[responseArray count]; i++)
            {
                id docSearchDetailObj = [responseArray objectAtIndex:i];
                
                //NSLog(@"docSearchDetailObj type is %@",[[docSearchDetailObj class] description]);
                
                if ([docSearchDetailObj isKindOfClass:[NSDictionary class]])
                {
                    NSMutableDictionary *attrs = ((NSMutableDictionary*)docSearchDetailObj);
                    
                    patObj.patient = [attrs objectForKey:@"PatientFullname"];
                    patObj.patientCode = [attrs objectForKey:@"PatientCode"];
                    patObj.patientEmail = [attrs objectForKey:@"PatientEmail"];
                    patObj.patientHYPIN = [attrs objectForKey:@"PatientHYPIN"];
                    patObj.patientID = [attrs objectForKey:@"PatientID"];
                    patObj.patientMobile = [attrs objectForKey:@"PatientMobile"];
                    patObj.patientPin = [attrs objectForKey:@"PatientPin"];
                    patObj.patientUID = [attrs objectForKey:@"PatientU_ID"];
                    patObj.patientPassword = [attrs objectForKey:@"Patientpassword"];
                }
            }
            [signedArray addObject:patObj];
        }
        else if ([JSON isKindOfClass:[NSDictionary class]])
        {
        }
        else
        {
        }
    } else
    {
    }
    return signedArray;
}


@end
