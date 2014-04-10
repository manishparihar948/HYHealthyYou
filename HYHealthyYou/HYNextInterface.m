//
//  HYNextInterface.m
//  HYHealthyYou
//
//  Created by Manish Parihar on 06/03/14.
//  Copyright (c) 2014 MediIT. All rights reserved.
//

#import "HYNextInterface.h"
#import "HYScheduleDataObject.h"

@implementation HYNextInterface

+ (NSMutableArray *)sendRequiredDetails:(NSDictionary *)requireDict
{
    NSMutableArray *sendArray = [[NSMutableArray alloc]init];
    
    // Get the API Call From PLIST.
    NSString *urlPath = [[NSBundle mainBundle] pathForResource:@"HYHealthyYouApi" ofType:@"plist"];
    
    // Load the file content and read the data into arrays.
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:urlPath];
    NSString *docURL1 = [dict objectForKey:@"URL"];
    NSString *docURL2 = @"/DoctorService.svc/GetDoctorSchedule";
    NSString *combineDocUrl = [docURL1 stringByAppendingString:docURL2];
    NSLog(@"combineDocUrl : %@",combineDocUrl);
    
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
    
    NSError *error;
    
    NSDictionary *dictTemp = [NSDictionary dictionaryWithObjectsAndKeys:requireDict,@"catchschedule", nil];
    NSLog(@"dictTemp : %@",dictTemp);

    // Convert object to data
    NSData* postData = [NSJSONSerialization dataWithJSONObject:dictTemp options:kNilOptions error:&error];
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
            NSArray *responseArray = [JSON objectForKey:@"GetDoctorScheduleResult"];
            for (int i=0; i<[responseArray count]; i++)
            {
                id docSearchDetailObj = [responseArray objectAtIndex:i];
                
                NSLog(@"docSearchDetailObj type is %@",[[docSearchDetailObj class] description]);
                
                if ([docSearchDetailObj isKindOfClass:[NSDictionary class]])
                {
                    NSMutableDictionary *attrs = ((NSMutableDictionary*)docSearchDetailObj);
                    
                    HYScheduleDataObject *scheduleObj = [[HYScheduleDataObject alloc]init];
                    
                    scheduleObj.scheduleIDString = [attrs objectForKey:@"ScheduleID"];
                    scheduleObj.messageString = [attrs objectForKey:@"Message"];
                    scheduleObj.scheduleString = [attrs objectForKey:@"Schedule"];
                    scheduleObj.isOnCallString = [attrs objectForKey:@"IsOnCall"];
                    scheduleObj.isTokenBaseString = [attrs objectForKey:@"IsTokenBase"];
                    
                    NSLog(@"scheduleIDString: %@",scheduleObj.scheduleIDString);
                    
                    [sendArray addObject:scheduleObj];
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
    
    return sendArray;
}

@end
