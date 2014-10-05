//
//  SongsRequestHandler.h
//  NyimboZaKristo
//
//  Created by Nelson on 10/4/14.
//  Copyright (c) 2014 Nelson. All rights reserved.
//

#import "AsyncHTTPClient.h"
#import "MainViewController.h"

@interface SongsRequestHandler : AsyncHTTPClient

- (void)initWithPayload:(NSDictionary*)payload navigationController:(NavigationViewController*)navigationController viewController:(MainViewController*) mainViewController;

@end
