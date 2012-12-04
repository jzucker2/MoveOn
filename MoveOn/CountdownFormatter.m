//
//  CountdownFormatter.m
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "CountdownFormatter.h"

@implementation CountdownFormatter

- (id) init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSString *) stringForDouble:(double)timeinterval
{
    // try 2
    NSString *formattedString;
    
    NSInteger seconds = timeinterval;
    if (seconds == 0) 
    {
        return @"00:00";
    }
    //NSLog(@"total seconds is originally %d", seconds);
    
    //NSLog(@"seconds is %d", seconds);
    
    
    
    if (seconds < (60*60*65)) 
    {
        NSInteger hours = seconds / (60*60);
        //NSLog(@"hours is %d", hours);
        seconds -= hours * (60*60);
        
        NSInteger minutes = seconds / 60;
        //NSLog(@"minutes is %d", minutes);
        seconds -= minutes *60;
        
        //NSLog(@"seconds is %d", seconds);
        
        formattedString = [NSString stringWithFormat:@"%02dh:%02dm:%02ds", hours, minutes, seconds];
    }
    else
    {
        NSInteger days = seconds / (60*60*24);
        //NSLog(@"days is %d", days);
        seconds -= days * (60*60*24);
        
        NSInteger hours = seconds / (60*60);
        //NSLog(@"hours is %d", hours);
        seconds -= hours * (60*60);
        
        NSInteger minutes = seconds / 60;
        //NSLog(@"minutes is %d", minutes);
        seconds -= minutes *60;
        
        //NSLog(@"seconds is %d", seconds);
        formattedString = [NSString stringWithFormat:@"%dd:%02dh:%02dm:%02ds", days, hours, minutes, seconds];
    }
    
    
    
    return formattedString;
    //NSLog(@"++++++++++++++++");
}

- (NSString *) stringForCountdownInterval:(NSNumber *)timeinterval
{
    //NSLog(@"++++++++++++++++");
    
    /* try 1
    NSString *formattedString;
    
    NSInteger seconds = [timeinterval integerValue];
    //NSLog(@"total seconds is originally %d", seconds);
    
    NSInteger days = seconds / (60*60*24);
    //NSLog(@"days is %d", days);
    seconds -= days * (60*60*24);
    
    NSInteger hours = seconds / (60*60);
    //NSLog(@"hours is %d", hours);
    seconds -= hours * (60*60);
    
    NSInteger minutes = seconds / 60;
    //NSLog(@"minutes is %d", minutes);
    seconds -= minutes *60;
    
    //NSLog(@"seconds is %d", seconds);
    
    
    if (days < 1) {
        formattedString = [NSString stringWithFormat:@"%02dh:%02dm:%02ds", hours, minutes, seconds];
    }
    else
    {
        formattedString = [NSString stringWithFormat:@"%dd:%02dh:%02dm:%02ds", days, hours, minutes, seconds];
    }
    
    // for testing
    //formattedString = @"200";
     */
    
    
    
    // try 2
    NSString *formattedString;
    
    NSInteger seconds = [timeinterval integerValue];
    //NSLog(@"total seconds is originally %d", seconds);
    
    //NSLog(@"seconds is %d", seconds);
    
    
    if (seconds < 3600) 
    {
        NSInteger minutes = seconds / 60;
        seconds -= minutes*60;
        
        formattedString = [NSString stringWithFormat:@"%02dm:%02ds", minutes, seconds];
    }
    else if (seconds < (60*60*65)) 
    {
        NSInteger hours = seconds / (60*60);
        //NSLog(@"hours is %d", hours);
        seconds -= hours * (60*60);
        
        NSInteger minutes = seconds / 60;
        //NSLog(@"minutes is %d", minutes);
        seconds -= minutes *60;
        
        //NSLog(@"seconds is %d", seconds);
        
        formattedString = [NSString stringWithFormat:@"%02dh:%02dm:%02ds", hours, minutes, seconds];
    }
    else
    {
        NSInteger days = seconds / (60*60*24);
        //NSLog(@"days is %d", days);
        seconds -= days * (60*60*24);
        
        NSInteger hours = seconds / (60*60);
        //NSLog(@"hours is %d", hours);
        seconds -= hours * (60*60);
        
        NSInteger minutes = seconds / 60;
        //NSLog(@"minutes is %d", minutes);
        seconds -= minutes *60;
        
        //NSLog(@"seconds is %d", seconds);
        formattedString = [NSString stringWithFormat:@"%dd:%02dh:%02dm:%02ds", days, hours, minutes, seconds];
    }

    
    
    return formattedString;
    //NSLog(@"++++++++++++++++");
}

@end
