//
//  CDCPersonalCenterViewController.m
//  CountDisCount
//
//  Created by Haoran Guan on 4/7/12.
//  Copyright (c) 2012 NYU. All rights reserved.
//

#import "CDCPersonalCenterViewController.h"

@interface CDCPersonalCenterViewController ()

@end

@implementation CDCPersonalCenterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
