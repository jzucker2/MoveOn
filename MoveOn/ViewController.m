//
//  ViewController.m
//  MoveOn
//
//  Created by Jordan Zucker on 11/30/12.
//  Copyright (c) 2012 Jordan Zucker. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _task = [[Task alloc] initFromPlist];
        //[_task setCountdownTime:60];
        //NSDate *date = [NSDate date];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [_startStopButton setTitle:@"Start" forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewWillAppear:) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewWillDisappear:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    
    
    //_task = [[Task alloc] initFromPlist];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"viewWillAppear");
    
    if (_task.isRunning) {
        [self startTimer:YES];
    }
    
    _timerLabel.text = [_task stringForTimeLeft];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
    
    if (_task.isRunning) {
        [self startTimer:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Methods

- (IBAction)startStopTask:(id)sender
{
    /*
    // task is stopped and there's time left, so start task
    if ((!_task.isRunning) && (_task.timeLeft > 0)) {
        [self startTimer:YES];
        [_task startTask];
    }
    // task is running and there's time left, so pause
    else if ((_task.isRunning) && (_task.timeLeft > 0))
    {
        [self startTimer:NO];
        [_task pauseTask];
    }
    // time hasn't been set
    else
    {
        UIAlertView *setTimeAlert = [[UIAlertView alloc] initWithTitle:@"Set a task time" message:@"You need to set a length of time for your task before you can start it" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [setTimeAlert show];
    }
     */
    
    BOOL taskChanged = [_task startStopTask];
    
    if (taskChanged) {
        [self startTimer:_task.isRunning];
    }
    else
    {
        UIAlertView *setTimeAlert = [[UIAlertView alloc] initWithTitle:@"Set a task time" message:@"You need to set a length of time for your task before you can start it" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [setTimeAlert show];
    }
}

- (void) lockUI:(BOOL) isLocked
{
    if (isLocked)
    {
        [_countdownPickerView setEnabled:!isLocked];
        [_startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
        [_setTimeButton setEnabled:!isLocked];
        
    }
    else
    {
        [_startStopButton setTitle:@"Start" forState:UIControlStateNormal];
        [_countdownPickerView setEnabled:!isLocked];
        [_setTimeButton setEnabled:!isLocked];
    }
}

- (IBAction)setTimeInterval:(id)sender
{
    [_task setCountdownTime:_countdownPickerView.countDownDuration];
    
    _timerLabel.text = [_task stringForTimeLeft];
}

- (void) startTimer:(BOOL) start
{
    if (start) {
        [self lockUI:YES];
        //[_task startTask];
        
        

        _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimerLabel) userInfo:nil repeats:YES];
    }
    else
    {
        [self lockUI:NO];
        //[_task pauseTask];
        [_countdownTimer invalidate];
    }
}

- (void) finishTimer
{
    [_task endTask];
}

- (void) updateTimerLabel
{
    if (_task.timeLeft > 0) {
        //[_task decrementCountdown];
        _timerLabel.text = [_task stringForTimeLeft];
    }
    else
    {
        NSLog(@"ran out of time");
    }
}

- (void) dealloc
{
    
}
@end
