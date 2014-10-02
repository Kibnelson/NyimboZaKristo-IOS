//
//  CommonViews.h
//  NyimboZaKristo
//
//  Created by Nelson on 10/1/14.
//  Copyright (c) 2014 Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CustomUITextField.h"

@interface CommonViews : NSObject

+ (UIImageView *)logo:(UIInterfaceOrientation)orientation;
+ (UIImageView *)imageView:(NSString*)imageName frame:(CGRect)frame topInset:(CGFloat)topInset leftInset:(CGFloat)leftInset bottomInset:(CGFloat)bottomInset rightInset:(CGFloat)rightInset;
+ (UILabel *)subtitleLabelView:(NSString *)title frame:(CGRect)frame;
+ (UISwitch *)switchView:(NSString *)title frame:(CGRect)frame selector:(SEL)selector target:(id)target on:(BOOL)on;
+ (UILabel *)labelView:(NSString *)title frame:(CGRect)frame;
+ (CustomUITextField *)textFieldView:(NSString *)hint frame:(CGRect)frame delegate:(id)delegate viewTag: (NSInteger) viewTag nextTag: (NSInteger) nextTag previousTag: (NSInteger) previousTag;
+ (UIButton *)buttonWithTitle:(NSString *)title
                       target:(id)target
                     selector:(SEL)selector
                        frame:(CGRect)frame
                        image:(UIImage *)image
                 imagePressed:(UIImage *)imagePressed
                darkTextColor:(BOOL)darkTextColor;
+ (UIView *)titleView:(NSString *)title;
+ (UIBarButtonItem *)layoutActionBarButtons:(id)target
                                       home:(BOOL)home
                                   signedIn:(BOOL)signedIn orientation:(UIInterfaceOrientation)orientation;
@end
