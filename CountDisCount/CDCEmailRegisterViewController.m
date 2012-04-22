//
//  CDCEmailRegisterViewController.m
//  CountDisCount
//
//  Created by Haoran Guan on 4/22/12.
//  Copyright (c) 2012 NYU. All rights reserved.
//

#import "CDCEmailRegisterViewController.h"
#import "CDCUtilities.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "constants.h"

@interface CDCEmailRegisterViewController ()

@end

@implementation CDCEmailRegisterViewController

@synthesize usernameField, emailField, passwordField, confirmField;

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

#pragma mark view actions
- (IBAction)backButtonPressed:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)doneButtonPressed:(id)sender
{
    NSString *username = [[self usernameField] text];
    NSString *email = [[self emailField] text];
    NSString *password = [[self passwordField] text];
    NSString *confirm = [[self confirmField] text];
    
    username = [username stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    email = [email stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    password = [password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    confirm = [confirm stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // check input errors
    if ([username isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"输入错误" 
                                                            message:[NSString stringWithFormat:@"您的用户名不能为空，请重新输入"]
                                                           delegate:nil 
                                                  cancelButtonTitle:@"好的" 
                                                  otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    if ([email isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"输入错误" 
                                                            message:[NSString stringWithFormat:@"您的邮箱不能为空，请重新输入"]
                                                           delegate:nil 
                                                  cancelButtonTitle:@"好的" 
                                                  otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    if (![CDCUtilities NSStringIsValidEmail:email]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"输入错误" 
                                                            message:[NSString stringWithFormat:@"您输入的邮箱不是合法的邮箱地址，请重新输入"]
                                                           delegate:nil 
                                                  cancelButtonTitle:@"好的" 
                                                  otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    if ([password isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"输入错误" 
                                                            message:[NSString stringWithFormat:@"您的密码不能为空，请重新输入"]
                                                           delegate:nil 
                                                  cancelButtonTitle:@"好的" 
                                                  otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    if ([confirm isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"输入错误" 
                                                            message:[NSString stringWithFormat:@"您的密码确认不能为空，请重新输入"]
                                                           delegate:nil 
                                                  cancelButtonTitle:@"好的" 
                                                  otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    if (![password isEqualToString:confirm]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"输入错误" 
                                                            message:[NSString stringWithFormat:@"您输入的密码不匹配，请重新输入"]
                                                           delegate:nil 
                                                  cancelButtonTitle:@"好的" 
                                                  otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/Register",serverAddress]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:username forKey:@"username"];
    [request setPostValue:email forKey:@"email"];
    [request setPostValue:password forKey:@"password"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(registerSuccess:)];
    [request setDidFailSelector:@selector(registerFail:)];
    [request startAsynchronous];
}

- (void)registerSuccess:(ASIHTTPRequest *)request
{
    // read json
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[request responseData] options:kNilOptions error:&error];
    // put something into standardUserDefaults
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    ///////////////////////////////////////
    
    [self performSegueWithIdentifier:@"emailRegisterSuccess" sender:self];
}

- (void)registerFail:(ASIHTTPRequest *)request
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
