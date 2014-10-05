//
//  MainViewController.h
//  NyimboZaKristo
//
//  Created by Nelson on 10/2/14.
//  Copyright (c) 2014 Nelson. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "CustomKeyboard.h"
#import "NavigationViewController.h"

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UITextFieldDelegate,CustomKeyboardDelegate>


@property   (nonatomic, strong)  UITableView *tableView;
@property   (nonatomic, strong)  NavigationViewController *navigationController;
- (void)showServerData:(NSArray*)data;
@end
