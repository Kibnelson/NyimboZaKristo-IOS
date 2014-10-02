//
//  NavigationViewController.h
//  NyimboZaKristo
//
//  Created by Nelson on 10/2/14.
//  Copyright (c) 2014 Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationViewController : UINavigationController


@property (nonatomic, strong) NSMutableDictionary *payloadDictionary;
@property (nonatomic, strong) NSMutableDictionary *payloadDictionaryInnerLevel;
@property (nonatomic, assign) NSString *pointOfSearch;

-(void)putPayload:(NSString*)payload key:(NSString*)key;
-(void)clearPayload;
+(void)showMessage:(NSString*)message title: (NSString*)title;
- (void)showToastMessage:(NSString*)message;
@end
