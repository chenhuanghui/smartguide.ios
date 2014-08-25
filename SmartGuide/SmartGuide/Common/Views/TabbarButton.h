//
//  TabbarButton.h
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

enum TABBAR_BUTTON_TYPE
{
    TABBAR_BUTTON_TYPE_NONE=0,
    TABBAR_BUTTON_TYPE_HOME=1,
    TABBAR_BUTTON_TYPE_SEARCH=2,
    TABBAR_BUTTON_TYPE_SCAN=3,
    TABBAR_BUTTON_TYPE_INBOX=4,
    TABBAR_BUTTON_TYPE_USER=5,
};

@interface TabbarButton : UIButton

@property (nonatomic, assign) enum TABBAR_BUTTON_TYPE tabbarButtonType;
@property (nonatomic, weak, readonly) UILabel *lblText;
@property (nonatomic, weak, readonly) UIView *bgView;

@end
