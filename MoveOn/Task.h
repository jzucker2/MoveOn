//
//  Task.h
//  MoveOn
//
//  Created by Jordan Zucker on 11/30/12.
//  Copyright (c) 2012 Jordan Zucker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *pauseDate;
@property (nonatomic, strong) NSDate *projectedEndDate;

@property (nonatomic, assign) BOOL isRunning;
@property (nonatomic, assign) BOOL isStarted;
@property (nonatomic, assign) BOOL hasSetTime;
@property (nonatomic, assign) NSTimeInterval timeInterval;
//@property (nonatomic, assign) NSTimeInterval timeLeft;

@property (nonatomic, strong) NSString *plistPath;

@property (nonatomic, strong) NSMutableDictionary *plistDict;


- (id) initWithCountdownInterval:(NSTimeInterval) countdownInterval;

- (id) initFromPlist;

- (NSString *) fetchPlistPath;

- (void) saveToPlist;

- (NSTimeInterval) timeLeft;

- (BOOL) startTask;

- (BOOL) pauseTask;

- (BOOL) endTask;

- (void) scheduleNotification;

- (void) fetchPlistData;

- (void) decrementCountdown;

- (NSString *) stringForTimeLeft;

- (void) setCountdownTime:(NSTimeInterval) time;

- (BOOL) startStopTask;

@end
