//
//  ShopUser404ControllerCell.m
//  Infory
//
//  Created by XXX on 8/8/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopUser404ControllerCell.h"

@implementation ShopUser404ControllerView

- (instancetype)init
{
    self = [[NSBundle mainBundle] loadNibNamed:@"ShopUser404ControllerCell" owner:nil options:nil][0];
    if (self) {
        
    }
    return self;
}

+(float)minHeight
{
    return 120;
}

@end