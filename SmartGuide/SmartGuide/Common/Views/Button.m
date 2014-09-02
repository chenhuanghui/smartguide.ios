//
//  Button.m
//  Infory
//
//  Created by XXX on 9/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "Button.h"

@implementation Button

-(void)setLayoutType:(enum BUTTON_LAYOUT_TYPE)layoutType
{
    _layoutType=layoutType;
    
    switch (_layoutType) {
        case BUTTON_LAYOUT_TYPE_CUSTOM:
            break;
            
        case BUTTON_LAYOUT_TYPE_RED_BORDER:
            self.layer.cornerRadius=4;
            self.layer.masksToBounds=true;
            self.layer.borderColor=[self titleColorForState:UIControlStateNormal].CGColor;
            self.layer.borderWidth=2;
            break;
    }
}

@end
