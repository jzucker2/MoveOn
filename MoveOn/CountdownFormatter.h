//
//  CountdownFormatter.h
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountdownFormatter : NSObject
{

}

- (NSString *) stringForCountdownInterval:(NSNumber *)timeinterval;
- (NSString *) stringForDouble:(double) timeinterval;


@end
