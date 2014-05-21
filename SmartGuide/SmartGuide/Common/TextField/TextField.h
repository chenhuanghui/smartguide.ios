//
//  TextField.h
//  Infory
//
//  Created by XXX on 5/21/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

enum TEXTFIELD_LEFTVIEW_TYPE
{
    TEXTFIELD_LEFTVIEW_SEARCH=0,
    TEXTFIELD_LEFTVIEW_LOCATION=1,
    TEXTFIELD_LEFTVIEW_NONE=2,
};

enum TEXTFIELD_RIGHTVIEW_TYPE
{
    TEXTFIELD_RIGHTVIEW_CLEAR=0,
    TEXTFIELD_RIGHTVIEW_LOCATION=1,
    TEXTFIELD_RIGHTVIEW_NONE=2,
};

enum TEXTFIELD_DISPLAY_TYPE
{
    TEXTFIELD_DISPLAY_TYPE_SEARCH=0,
};

@interface TextField : UITextField

@property (nonatomic, assign) enum TEXTFIELD_DISPLAY_TYPE displayType;
@property (nonatomic, assign) enum TEXTFIELD_LEFTVIEW_TYPE leftViewType;
@property (nonatomic, assign) enum TEXTFIELD_RIGHTVIEW_TYPE rightViewType;

@end

@interface SearchTextField : TextField
{
    __weak UIImageView *imgvLeft;
    __weak UIImageView *imgvRight;
    __weak UIView *midView;
}

@end