//
//  TextView.h
//  SmartGuide
//
//  Created by MacMini on 14/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextView : UITextView
{
    __weak UILabel *lblPlaceHolder;
}

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, assign) CGPoint placeholderXY;

@end
