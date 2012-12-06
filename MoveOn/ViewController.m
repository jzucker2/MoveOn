//
//  ViewController.m
//  MoveOn
//
//  Created by Jordan Zucker on 11/30/12.
//  Copyright (c) 2012 Jordan Zucker. All rights reserved.
//

#import "ViewController.h"
#import "AboutViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _task = [[Task alloc] initFromPlist];
        _countdownFormatter = [[CountdownFormatter alloc] init];
        _isEndingTask = NO;
        self.title = @"MoveOn";
        //[_task setCountdownTime:60];
        //NSDate *date = [NSDate date];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setUp];
    //[_startStopButton setTitle:@"Start" forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewWillAppear:) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewWillDisappear:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    
    
    //_task = [[Task alloc] initFromPlist];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"viewWillAppear");
    
    //self.navigationController.navigationBar.topItem.title = @"MoveOn";
    
    if (_task.isRunning && (_task.timeLeft > 0))
    {
        NSLog(@"task is running, start timer");
        [self startTimer:YES];
    }
    else if (_task.isRunning && (_task.timeLeft < 0))
    {
        NSLog(@"task already finished, but no notification was fired");
        [self endTask];
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

- (void) setUp
{
    [_startStopButton setTitle:@"Start" forState:UIControlStateNormal];
    
    self.navigationController.navigationBar.topItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"About" style:UIBarButtonItemStyleBordered target:self action:@selector(showAboutView:)];
    
    //self.navigationController.navigationBar.topItem.title = @"MoveOn";
    
    //[_startStopButton setTintColor:[UIColor redColor]];
    //[_startStopButton setBackgroundColor:[UIColor redColor]];
    //[_setTimeButton setTintColor:[UIColor redColor]];
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

- (IBAction)showAboutView:(id)sender
{
    AboutViewController *aboutView = [[AboutViewController alloc] initWithNibName:@"AboutView" bundle:nil];
    [self.navigationController pushViewController:aboutView animated:YES];
}

- (void) lockUI:(BOOL) isLocked
{
    if (isLocked)
    {
        [_countdownPickerView setEnabled:!isLocked];
        [_startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
        [_setTimeButton setEnabled:!isLocked];
        //[_startStopButton setTintColor:[UIColor greenColor]];
        
    }
    else
    {
        [_startStopButton setTitle:@"Start" forState:UIControlStateNormal];
        [_countdownPickerView setEnabled:!isLocked];
        [_setTimeButton setEnabled:!isLocked];
        //[_startStopButton setTintColor:[UIColor redColor]];
    }
}

- (IBAction)setTimeInterval:(id)sender
{
    [_task setCountdownTime:_countdownPickerView.countDownDuration];
    
    //_timerLabel.text = [_task stringForTimeLeft];
    _timerLabel.text = [_countdownFormatter stringForDouble:_task.timeLeft];
    
    //[_setTimeButton setTintColor:[UIColor greenColor]];
}

- (void) startTimer:(BOOL) start
{
    _timeLeft = _task.timeLeft;
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

- (void) endTask
{
    NSLog(@"endTask in view controller called");
    /*
    if (!_task.isFinished) {
        NSLog(@"task isn't finished, must end it");
        [_task endTask];
        [self startTimer:NO];
    }
    else
    {
        NSLog(@"task already finished");
    }
     */
    [_task endTask];
    [self startTimer:NO];
    //[_task endTask];
    //[self startTimer:NO];
    //[self lockUI:NO];
}

- (void) updateTimerLabel
{
    /*
    if (_task.timeLeft > 0) {
        //[_task decrementCountdown];
        _timerLabel.text = [_task stringForTimeLeft];
    }
    else
    {
        NSLog(@"ran out of time");
    }
     */
    if (_timeLeft > 0) {
        _timeLeft--;
        _timerLabel.text = [_countdownFormatter stringForDouble:_timeLeft];
    }
    else
    {
        NSLog(@"ran out of time");
        //[self endTask];
    }
}

- (void) dealloc
{
    
}
@end
