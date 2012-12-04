//
//  ViewController.h
//  MoveOn
//
//  Created by Jordan Zucker on 11/30/12.
//  Copyright (c) 2012 Jordan Zucker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *startStopButton;
@property (nonatomic, strong) IBOutlet UIButton *setTimeButton;
@property (nonatomic, strong) IBOutlet UILabel *timerLabel;

@property (nonatomic, strong) IBOutlet UIDatePicker *countdownPickerView;

@property (nonatomic, strong) NSTimer *countdownTimer;

@property (nonatomic, strong) Task *task;

- (IBAction)startStopTask:(id)sender;

- (void) startTimer:(BOOL) start;

- (void) updateTimerLabel;

- (void) finishTimer;

- (void) lockUI:(BOOL) isLocked;

- (IBAction)setTimeInterval:(id)sender;

@end
