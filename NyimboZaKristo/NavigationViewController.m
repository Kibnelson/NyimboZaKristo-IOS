//
//  NavigationViewController.m
//  NyimboZaKristo
//
//  Created by Nelson on 10/2/14.
//  Copyright (c) 2014 Nelson. All rights reserved.
//
//
//NavigationViewController is used to Handles the following functions in the  application, 1)navigation from one view to another. 2) invoking http connection 3) handle payload for sending to the server 4) show messages/information to the user using a toast or an alert

#import "NavigationViewController.h"
#import "MBProgressHUD.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController
@synthesize pointOfSearch;

//Function that initializes the class, creates the payload dictionary that is used to pass prameters to the server e.g. for search a song
-(id)initWithRootViewController:(UIViewController*)viewController{
     _payloadDictionaryInnerLevel = [NSMutableDictionary dictionary];
    return [super initWithRootViewController:viewController];
}

//Function that add payload parameters
-(void)putPayload:(NSString*)payload key:(NSString*)key{
    [_payloadDictionaryInnerLevel setObject:payload forKey:key];
}

//This function clears all the data in the payload for adding a new set of parameters
-(void)clearPayload{
    [_payloadDictionaryInnerLevel removeAllObjects];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // You do not need this method if you are not supporting earlier iOS Versions
    return [self.topViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}

// Function for showing messages
+(void)showMessage:(NSString*)message title: (NSString*)title{
    UIAlertView *alert =
    [[UIAlertView alloc]
     initWithTitle:NSLocalizedStringFromTable(title, @"HTTPFetcher", @"Title of the error dialog used for any kind of connection or streaming error.")
     message:message
     delegate:nil
     cancelButtonTitle:NSLocalizedStringFromTable(@"OK", @"HTTPFetcher", @"Standard dialog dismiss button.")
     otherButtonTitles:nil];
    [alert show];
}

//Function for showing toast of any activity going on in the application
- (void)showToastMessage:(NSString*)message {
    
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
	// Configure for text only and offset down
	hud.mode = MBProgressHUDModeText;
	hud.labelText = message;
	hud.margin = 10.f;
	hud.yOffset = 150.f;
	hud.removeFromSuperViewOnHide = YES;
    
	[hud hide:YES afterDelay:5];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
