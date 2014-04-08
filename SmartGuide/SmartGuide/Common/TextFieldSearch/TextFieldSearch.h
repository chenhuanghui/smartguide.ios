//
//  TextFieldSearch.h
//  SmartGuide
//
//  Created by MacMini on 10/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TextFieldBGView;

@interface TextFieldSearch : UITextField
{
    __weak TextFieldBGView *bgView;
}

@end

@interface TextFieldBGView : UIView

@end