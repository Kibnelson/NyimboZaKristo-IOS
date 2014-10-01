//
//  AppDelegate.h
//  NyimboZaKristo
//
//  Created by Nelson on 9/30/14.
//  Copyright (c) 2014 Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NavigationViewController *navigationController;
- (void)setNavigationBarBg;
@end
