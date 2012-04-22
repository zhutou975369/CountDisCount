//
//  CDCNearbyViewController.h
//  CountDisCount
//
//  Created by Haoran Guan on 4/6/12.
//  Copyright (c) 2012 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface CDCNearbyViewController : UIViewController <ASIHTTPRequestDelegate>

- (IBAction)testPressed:(id)sender;

- (IBAction)postPressed:(id)sender;

@end
