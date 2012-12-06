//
//  Task.m
//  MoveOn
//
//  Created by Jordan Zucker on 11/30/12.
//  Copyright (c) 2012 Jordan Zucker. All rights reserved.
//

#import "Task.h"

@implementation Task

- (id) initWithCountdownInterval:(NSTimeInterval) countdownInterval
{
    self = [super init];
    if (self) {
        _timeInterval = countdownInterval;
        _isRunning = NO;
    }
    return self;
}

- (id) initFromPlist
{
    self = [super init];
    if (self) {
        // blah
        [self fetchPlistPath];
        [self fetchPlistData];
        
    }
    //NSLog(@"self is %@", [self description]);
    return self;
}

- (NSString *) fetchPlistPath
{
    _plistPath = [[NSBundle mainBundle] pathForResource:@"TaskData" ofType:@"plist"];
    return _plistPath;
}

- (void) fetchPlistData
{
    _plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:_plistPath];
    _startDate = [_plistDict objectForKey:@"startDate"];
    _pauseDate = [_plistDict objectForKey:@"pauseDate"];
    _projectedEndDate = [_plistDict objectForKey:@"projectedEndDate"];
    
    _timeInterval = [[_plistDict objectForKey:@"timeInterval"] doubleValue];
    
    _isRunning = [[_plistDict objectForKey:@"isRunning"] boolValue];
    
    _isStarted = [[_plistDict objectForKey:@"isStarted"] boolValue];
    
    _hasSetTime = [[_plistDict objectForKey:@"hasSetTime"] boolValue];
    
    //NSLog(@"_plistDict is %@", _plistDict);
    
}

- (void) saveToPlist
{
    [_plistDict setValue:_startDate forKey:@"startDate"];
    [_plistDict setValue:_projectedEndDate forKey:@"projectedEndDate"];
    [_plistDict setValue:_pauseDate forKey:@"pauseDate"];
    [_plistDict setValue:[NSNumber numberWithBool:_isRunning] forKey:@"isRunning"];
    [_plistDict setValue:[NSNumber numberWithDouble:_timeInterval] forKey:@"timeInterval"];
    [_plistDict setValue:[NSNumber numberWithBool:_isStarted] forKey:@"isStarted"];
    [_plistDict setValue:[NSNumber numberWithBool:_hasSetTime] forKey:@"hasSetTime"];
    
    NSLog(@"saveToPlist");
    NSLog(@"_plistDict is %@", _plistDict);
    
    [_plistDict writeToFile:_plistPath atomically:YES];
}

- (void) setCountdownTime:(NSTimeInterval) time
{
    _hasSetTime = YES;
    _timeInterval = time;
    
    [self saveToPlist];
}

- (void) decrementCountdown
{
    /*
    if (self.timeLeft > 0) {
        ;
    }
    else
    {
        NSLog(@"countdown is too low!");
    }
     */
}

- (NSString *) stringForTimeLeft
{
    return [NSString stringWithFormat:@"%f", self.timeLeft];
}

- (BOOL) startTask
{
    if ((_isRunning) || (!_hasSetTime) || (self.timeLeft <= 0)) {
        return NO;
    }
    
    /*
    if (!_isStarted) {
        _isStarted = YES;
    }
    
    _isRunning = YES;
     */
    _startDate = [NSDate date];
    _projectedEndDate = [_startDate dateByAddingTimeInterval:self.timeLeft];
    
    if (!_isStarted) {
        _isStarted = YES;
    }
    
    _isRunning = YES;
    
    [self saveToPlist];
    
    [self scheduleNotification];
    return YES;
}

- (BOOL) pauseTask
{
    if ((!_isRunning) || (self.timeLeft <= 0))
    {
        return NO;
    }
    _isRunning = NO;
    
    _pauseDate = [NSDate date];
    
    [self saveToPlist];

    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    return YES;
}

- (BOOL) startStopTask
{
    BOOL taskChanged;
    if (!_isRunning) {
        taskChanged = [self startTask];
    }
    else
    {
        taskChanged = [self pauseTask];
    }
    
    return taskChanged;
}

- (BOOL) endTask
{
    _isStarted = NO;
    _hasSetTime = NO;
    _isRunning = NO;
    _timeInterval = 60;
    [self saveToPlist];
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    [self showAlertToEndTask];
    
    return YES;
}

- (void) showAlertToEndTask
{
    UIAlertView *endTaskAlert = [[UIAlertView alloc] initWithTitle:@"Task is over" message:@"You just finished your task, acknowledge it bitch" delegate:nil cancelButtonTitle:@"Move On" otherButtonTitles:nil];
    [endTaskAlert show];
}

- (void) scheduleNotification
{
    UILocalNotification *taskNotification = [[UILocalNotification alloc] init];
    taskNotification.alertBody = @"Your task is finished";
    taskNotification.alertAction = @"Finish task";
    
    taskNotification.fireDate = _projectedEndDate;
    taskNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    [[UIApplication sharedApplication] scheduleLocalNotification:taskNotification];
    
    //NSDictionary *infoDict = [[NSDictionary alloc] initWithObjectsAndKeys:self, @"task", nil];
    
    //taskNotification.userInfo = infoDict;
    
    UILocalNotification *reminderNotification = [[UILocalNotification alloc] init];
    reminderNotification.alertBody = @"Your task already finished";
    reminderNotification.alertAction = @"Finish task";
    reminderNotification.timeZone = [NSTimeZone defaultTimeZone];
    // schedule reminder notifications
    for (NSInteger i = 1; i <=3; i++)
    {
        NSTimeInterval paddedTime = 120 * i;
        reminderNotification.fireDate = [_projectedEndDate dateByAddingTimeInterval:paddedTime];
        [[UIApplication sharedApplication] scheduleLocalNotification:reminderNotification];
    }
    
    /*
    for (UILocalNotification *notification in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        NSLog(@"notification is %@", notification);
    }
     */
}


- (NSTimeInterval) timeLeft
{
    if (!_isStarted) {
        return _timeInterval;
    }
    NSTimeInterval timeLeft;
    if (_isRunning) {
        timeLeft = [_projectedEndDate timeIntervalSinceNow];
    }
    else
    {
        timeLeft = [_projectedEndDate timeIntervalSinceDate:_pauseDate];
    }
    //NSTimeInterval timeLeft = [_projectedEndDate timeIntervalSinceDate:_startDate];
    NSLog(@"timeLeft is %f", timeLeft); 
    return timeLeft;
}

@end
