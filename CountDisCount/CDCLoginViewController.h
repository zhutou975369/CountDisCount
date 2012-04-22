//
//  CDCLoginViewController.h
//  CountDisCount
//
//  Created by Haoran Guan on 4/22/12.
//  Copyright (c) 2012 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDCLoginViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField *usernameField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;

- (IBAction)skipButtonPressed:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;

@end
