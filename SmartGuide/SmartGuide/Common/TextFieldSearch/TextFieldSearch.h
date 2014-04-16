//
//  TextFieldSearch.h
//  SmartGuide
//
//  Created by MacMini on 10/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TEXT_FIELD_SEARCH_DEFAULT_WIDTH 232.f
#define TEXT_FIELD_SEARCH_MIN_WIDTH 38.f //icon_refresh.png width * 2


@class TextFieldBGView;

@interface TextFieldSearch : UITextField
{
    __weak TextFieldBGView *bgView;
    bool _isRefresh;
}

-(void) setAngle:(float) angle;
-(void) startRefresh;
-(void) stopRefresh:(void(^)()) onCompleted;

@end

@interface TextFieldBGView : UIView

@end