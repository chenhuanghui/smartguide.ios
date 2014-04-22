//
//  TextFieldSearch.h
//  SmartGuide
//
//  Created by MacMini on 10/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

enum TEXT_FIELD_SEARCH_REFRESH_STATE
{
    TEXT_FIELD_SEARCH_REFRESH_STATE_SEARCH = 0, // icon search
    TEXT_FIELD_SEARCH_REFRESH_STATE_REFRESHING = 1, // icon refresh rotate animation
    TEXT_FIELD_SEARCH_REFRESH_STATE_DONE = 2, // icon refresh done overlap
    TEXT_FIELD_SEARCH_REFRESH_STATE_ROTATE = 3,
};

#define TEXT_FIELD_SEARCH_DEFAULT_WIDTH 232.f
#define TEXT_FIELD_SEARCH_MIN_WIDTH 38.f //icon_refresh.png width * 2

@class TextFieldBGView;

@interface TextFieldSearch : UITextField
{
    __weak TextFieldBGView *bgView;
    __weak UIImageView *imgvDone;
    enum TEXT_FIELD_SEARCH_REFRESH_STATE _refreshState;
}

-(void) setAngle:(float) angle;

-(void) setRefreshState:(enum TEXT_FIELD_SEARCH_REFRESH_STATE) state animated:(bool) isAnimate completed:(void(^)(enum TEXT_FIELD_SEARCH_REFRESH_STATE state)) completed;
-(enum TEXT_FIELD_SEARCH_REFRESH_STATE) refreshState;

@property (nonatomic, assign) bool hiddenClearButton;

@end

@interface TextFieldBGView : UIView

@end