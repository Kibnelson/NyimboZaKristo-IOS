//
//  SongsRequestHandler.m
//  NyimboZaKristo
//
//  Created by Nelson on 10/4/14.
//  Copyright (c) 2014 Nelson. All rights reserved.
//

#import "SongsRequestHandler.h"
#import "Constants.h"
#import "MainViewController.h"

@interface SongsRequestHandler ()

@property (nonatomic, strong) MainViewController *mainViewController;

@end

@implementation SongsRequestHandler

- (void)initWithPayload:(NSDictionary*)payload navigationController:(NavigationViewController*)navigationController viewController:(MainViewController*) mainViewController
{
    
    [super initWithPayload:payload navigationController:navigationController];

    [self setMainViewController:mainViewController];
}

- (void)handleResponse:(NSDictionary *)response
{
    
    NSArray *statusCode = (NSArray*)[response objectForKey:@"payload"];
    if (statusCode != nil)
	{
        if(statusCode.count>0)
        [self.mainViewController showServerData:statusCode];
        else{
        
        [NavigationViewController showMessage:@"There is no song matching your search criteria, try again." title:@"Info"];
        }
    
	}else{
        NSString *statusMsg = (NSString*)[response objectForKey:@"STATUS_MESSAGE"];
        
        if (statusMsg == nil || [statusMsg class]  == [NSNull class])
        {
            statusMsg = @"Sorry, there was an error in processing your request, please try again later.";
        }
        [NavigationViewController showMessage:statusMsg title:@"Response"];
    }
}

- (void)dealloc
{
	self.mainViewController;
    
}

@end
