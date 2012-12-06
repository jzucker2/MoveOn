//
//  ViewController.h
//  MoveOn
//
//  Created by Jordan Zucker on 11/30/12.
//  Copyright (c) 2012 Jordan Zucker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "CountdownFormatter.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *startStopButton;
@property (nonatomic, strong) IBOutlet UIButton *setTimeButton;
@property (nonatomic, strong) IBOutlet UILabel *timerLabel;

@property (nonatomic, strong) IBOutlet UIDatePicker *countdownPickerView;

@property (nonatomic, strong) CountdownFormatter *countdownFormatter;

@property (nonatomic, strong) NSTimer *countdownTimer;

@property (nonatomic, strong) Task *task;

@property (nonatomic, assign) NSTimeInterval timeLeft;

@property (nonatomic, assign) BOOL isEndingTask;

- (IBAction)startStopTask:(id)sender;

- (void) endTask;

- (void) startTimer:(BOOL) start;

- (void) updateTimerLabel;

- (void) lockUI:(BOOL) isLocked;

- (IBAction)setTimeInterval:(id)sender;

- (void) setUp;

- (IBAction)showAboutView:(id)sender;

@end
