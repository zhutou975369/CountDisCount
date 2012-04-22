//
//  CDCLoginViewController.m
//  CountDisCount
//
//  Created by Haoran Guan on 4/22/12.
//  Copyright (c) 2012 NYU. All rights reserved.
//

#import "CDCLoginViewController.h"
#import "AppDelegate.h"
#import "constants.h"
#import "ASIFormDataRequest.h"

@interface CDCLoginViewController ()

@end

@implementation CDCLoginViewController

@synthesize usernameField;
@synthesize passwordField;

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // check if userinfo is in userdefault. if so, jump to main page
}

#pragma mark view actions
- (IBAction)skipButtonPressed:(id)sender
{
    [self performSegueWithIdentifier:@"loginDone" sender:self];
}

- (IBAction)doneButtonPressed:(id)sender
{
    NSString *username = [[self usernameField] text];
    NSString *password = [[self passwordField] text];
    
    username = [username stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    password = [password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (username == NULL || password == NULL || [username isEqualToString:@""] || [password isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"输入错误" 
                                                            message:[NSString stringWithFormat:@"您的用户名和密码不能为空，请重新输入"]
                                                           delegate:nil 
                                                  cancelButtonTitle:@"好的" 
                                                  otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/Login",serverAddress]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:username forKey:@"username"];
    [request setPostValue:password forKey:@"password"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(loginSuccess:)];
    [request setDidFailSelector:@selector(loginFail:)];
    [request startAsynchronous];
}

- (void)loginSuccess:(ASIHTTPRequest *)request
{
    // read json
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[request responseData] options:kNilOptions error:&error];
    // put something into standardUserDefaults
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    ///////////////////////////////////////
    
    [self performSegueWithIdentifier:@"loginDone" sender:self];
}

- (void)loginFail:(ASIHTTPRequest *)request
{
    NSLog(@"Request Error: %@", request.error);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"连接错误" 
                                                        message:[NSString stringWithFormat:@"您的网络连接不给力啊，请稍后再试"]
                                                       delegate:nil 
                                              cancelButtonTitle:@"好的" 
                                              otherButtonTitles:nil];
    [alertView show];
}

@end
