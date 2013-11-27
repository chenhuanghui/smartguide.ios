//
//  ShopListScrollerView.m
//  SmartGuide
//
//  Created by MacMini on 26/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopListScrollerView.h"

@implementation ShopListScrollerView

- (id)init
{
    self = [[NSBundle mainBundle] loadNibNamed:@"ShopListScrollerView" owner:nil options:nil][0];
    if (self) {
        
    }
    return self;
}

-(void)setText:(NSString *)text
{
    lbl.text=text;
    
    CGRect rect=self.frame;
    rect.size=[text sizeWithFont:lbl.font];
    rect.size.width+=lbl.frame.origin.x;
    
    rect.origin.x=320-rect.size.width;
    self.frame=rect;
}

@end
