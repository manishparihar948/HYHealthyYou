//
//  HYScheduleBookInterface.m
//  HYHealthyYou
//
//  Created by mediit on 3/10/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import "HYScheduleBookInterface.h"
#import "HYTimeSlotDataObject.h"

@implementation HYScheduleBookInterface

+ (NSMutableArray *)scheduleBook : (NSDictionary *)scheduleDict
{
    NSMutableArray *bookArray = [[NSMutableArray alloc]init];
    
    // Get the API Call From PLIST.
    NSString *urlPath = [[NSBundle mainBundle] pathForResource:@"HYHealthyYouApi" ofType:@"plist"];
    
    // Load the file content and read the data into arrays.
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:urlPath];
    NSString *docURL1 = [dict objectForKey:@"URL"];
    NSString *docURL2 = @"/DoctorService.svc/GetDoctorScheduleTimeSlot";
    NSString *combineDocUrl = [docURL1 stringByAppendingString:docURL2];
    NSLog(@"combineDocUrl : %@",combineDocUrl);
    
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
    
    NSError *error;
    
    // Convert object to data
    NSData* postData = [NSJSONSerialization dataWithJSONObject:scheduleDict options:kNilOptions error:&error];
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
        NSLog(@"JSON: %@", JSON);
        
        if ([JSON isKindOfClass:[NSDictionary class]])
        {
            // Array of Payment Details
            NSArray *responseArray = [JSON objectForKey:@"GetDoctorScheduleTimeSlotResult"];
            for (int i=0; i<[responseArray count]; i++)
            {
                id docSearchDetailObj = [responseArray objectAtIndex:i];
                
                NSLog(@"docSearchDetailObj type is %@",[[docSearchDetailObj class] description]);
                
                if ([docSearchDetailObj isKindOfClass:[NSDictionary class]])
                {
                    NSMutableDictionary *attrs = ((NSMutableDictionary*)docSearchDetailObj);
                    
                    HYTimeSlotDataObject *slotObj = [[HYTimeSlotDataObject alloc]init];
                    
                    slotObj.isOnCall = [attrs objectForKey:@"IsOnCall"];
                    slotObj.isTokenBase = [attrs objectForKey:@"IsTokenBase"];
                    slotObj.startTime = [attrs objectForKey:@"StartTime"];
                    slotObj.timeSlotDetails = [attrs objectForKey:@"TimeslotDetails"];
                    slotObj.workFromTime = [attrs objectForKey:@"WorkFromTime"];
                    slotObj.workToTime = [attrs objectForKey:@"WorkToTime"];
                    
                    NSLog(@"slotObj: %@",slotObj.startTime);
                    
                    [bookArray addObject:slotObj];
                    
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
    
    return bookArray;
}

@end
