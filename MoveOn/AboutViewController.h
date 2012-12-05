//
//  AboutViewController.h
//  MoveOn
//
//  Created by Jordan Zucker on 12/5/12.
//  Copyright (c) 2012 Jordan Zucker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *versionLabel;
@property (nonatomic, strong) IBOutlet UILabel *buildLabel;

@property (nonatomic, strong) IBOutlet UIButton *emailButton;

- (IBAction)emailAction:(id)sender;

@end
