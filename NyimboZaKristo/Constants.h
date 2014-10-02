//
//  Constants.h
//  NyimboZaKristo
//
//  Created by Nelson on 10/1/14.
//  Copyright (c) 2014 Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>

//Layout Constants
#define LAYOUT_STANDARD_VIEW_MARGIN_IPHONE 5.0f
#define LAYOUT_LEFT_OUTER_X_POS 5.0f
#define LAYOUT_Y_POSITION_AFTER_TITLE 32.0f
#define LAYOUT_TOP_MARGIN 3.0f
#define LAYOUT_BACKGROUND_MARGIN_IPHONE 1.0f
#define LAYOUT_BOTTOM_MARGIN 27.0f
#define LAYOUT_LEFT_INNER_X_POS 0.0f
#define LAYOUT_LEVEL_2_VIEW_START_Y_POS 0.0f
#define LAYOUT_VIEW_WIDTH 152.0f
#define LAYOUT_VIEW_HEIGHT 30.0f
#define LAYOUT_VERTICAL_SPACING 6.0f
#define LAYOUT_BUTTON_WIDTH 150.0f
#define LAYOUT_RIGHT_INNER_X_POS 150.0f
#define LAYOUT_SERVICE_BUTTON_WIDTH 242.0f
#define LAYOUT_SERVICE_BUTTON_HEIGHT 50.0f
#define LAYOUT_LEFT_OUTER_X_POS 5.0f
#define LAYOUT_Y_POSITION_AFTER_TITLE 32.0f
#define LAYOUT_STANDARD_VIEW_MARGIN_IPHONE 5.0f
#define LAYOUT_BACKGROUND_MARGIN_IPHONE 1.0f
#define LAYOUT_INNER_INNER_CONTAINER_VIEW_MARGIN_IPHONE 5.0f
#define LAYOUT_BACKGROUND_MARGIN_IPHONE 1.0f
#define LAYOUT_TOP_MARGIN 3.0f
#define LAYOUT_BOTTOM_MARGIN 27.0f
#define LAYOUT_RIGHT_INNER_X_POS 150.0f
#define LAYOUT_LEVEL_2_VIEW_START_Y_POS 0.0f
#define LAYOUT_VIEW_WIDTH 152.0f
#define LAYOUT_VIEW_HEIGHT 30.0f
#define LAYOUT_LEFT_INNER_X_POS 0.0f
#define LAYOUT_LEFT_INNER_X_POS_LANDSCAPE 80.0f
#define LAYOUT_LEVEL_2_VIEW_START_Y_POS 0.0f
#define LAYOUT_BUTTON_X_POS 83.0f
#define LAYOUT_BUTTON_WIDTH 150.0f
#define LAYOUT_VERTICAL_SPACING 6.0f
#define LAYOUT_VIEW_WIDTH_LANDSCAPE 229.0f
#define LAYOUT_RIGHT_OUTER_X_POS_LANDSCAPE 232.0f
#define LAYOUT_RIGHT_INNER_X_POS_LANDSCAPE 229.0f
#define LAYOUT_BUTTON_X_POS_LANDSCAPE 259.0f


// UIView TAGs Constants
#define TAG_SCROLL_VIEW 1
#define TAG_SWITCH_FIELD 2
#define TAG_SEARCH_FIELD 3
#define TAG_SEARCH_BUTTON_FIELD 4
#define TAG_SEARCH_BUTTON 5
#define TAG_SEARCH_BUTTON_ALL 6
#define TAG_TITLE_LABEL 7
#define TAG_NO_LABEL 8
#define TAG_VIDEO_BUTTON 9
#define TAG_AUDIO_BUTTON 10
#define TAG_STOP_PLAYER 12
#define TAG_PAUSE_PLAYER 13



#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


@protocol Constants <NSObject>

@end
