//
//  Button.h
//  Infory
//
//  Created by XXX on 9/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

enum BUTTON_LAYOUT_TYPE
{
    BUTTON_LAYOUT_TYPE_CUSTOM=0,
    BUTTON_LAYOUT_TYPE_RED_BORDER=1,
    BUTTON_LAYOUT_TYPE_BACK=2,
};

@interface Button : UIButton

@property (nonatomic, assign) enum BUTTON_LAYOUT_TYPE layoutType;

@end