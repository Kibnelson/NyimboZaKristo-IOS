//
//  AsyncHTTPClient.m
//  NyimboZaKristo
//
//  Created by Nelson on 10/4/14.
//  Copyright (c) 2014 Nelson. All rights reserved.
//


#import "AsyncHTTPClient.h"
#import "MBProgressHUD.h"

@interface AsyncHTTPClient ()


- (void)handleResponse:(NSDictionary *)response;

@end

@implementation AsyncHTTPClient

- (void)initWithPayload:(NSDictionary*)payload navigationController:(NavigationViewController*)navigationController
{
    NSString *value = [payload objectForKey:@"sSearch"];
    NSString *jsonRequest = [payload JSONString];
    
    NSLog(@"jsonRequest is %@", jsonRequest);
    
    NSString *urlString =[NSString stringWithFormat:@"%@%@", @"http://107.170.159.133:8080/NyimboZaKristo/getSongs.do?sSearch=", value];
    
   
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    [self initWithURLRequest:request receiver:nil action:nil];
    [self start];
    //show loading dialog
    self.navigationController = navigationController;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"Loading...";
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection
{
	JSONDecoder *jsonDecoder = [[JSONDecoder alloc] init];
    
    NSDictionary *response = [jsonDecoder objectWithData:data];
    
    if (response == nil && showAlerts)
	{
        UIAlertView *alert =
        [[UIAlertView alloc]
         initWithTitle:NSLocalizedStringFromTable(@"Connection Error", @"JSONFetcher", @"Title for error dialog")
         message:NSLocalizedStringFromTable(@"Sorry, there was an error in processing your request.", @"JSONFetcher", @"Detail for an error dialog.")
         delegate:nil
         cancelButtonTitle:NSLocalizedStringFromTable(@"OK", @"JSONFetcher", @"Standard dialog dismiss button")
         otherButtonTitles:nil];
        [alert show];
        
	}else{
        [self handleResponse:response];
        
    }
	[self close];
}

- (void)handleResponse:(NSDictionary *)response
{
    NSLog(@"json response is %@", [response JSONString]);
}

- (void)close
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    [super close];
}


@end