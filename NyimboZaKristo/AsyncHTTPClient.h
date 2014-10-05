//
//  AsyncHTTPClient.h
//  NyimboZaKristo
//
//  Created by Nelson on 10/4/14.
//  Copyright (c) 2014 Nelson. All rights reserved.
//
#import "HTTPFetcher.h"
#import "JSONKit.h"
#import "NavigationViewController.h"

@interface AsyncHTTPClient : HTTPFetcher

@property (nonatomic,strong) NavigationViewController *navigationController;

- (void)initWithPayload:(NSDictionary*)payload navigationController:(NavigationViewController*)navigationController;

@end
