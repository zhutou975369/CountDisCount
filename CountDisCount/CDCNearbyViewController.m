//
//  CDCNearbyViewController.m
//  CountDisCount
//
//  Created by Haoran Guan on 4/6/12.
//  Copyright (c) 2012 NYU. All rights reserved.
//

#import "CDCNearbyViewController.h"

@interface CDCNearbyViewController ()

@end

@implementation CDCNearbyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)testPressed:(id)sender
{
    NSLog(@"testPressed");
    NSURL *url = [NSURL URLWithString:@"http://50.18.17.238:8080/CDC/"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    NSLog(responseString);
    // Use when fetching binary data
    NSData *responseData = [request responseData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(request.responseString);
}

@end
