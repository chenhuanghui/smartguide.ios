//
//  ShopDetailPin.m
//  SmartGuide
//
//  Created by XXX on 8/3/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailPin.h"

@implementation ShopDetailPin

-(ShopDetailPin *)initWithName:(NSString *)name
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"ShopDetailPin" owner:nil options:nil] objectAtIndex:0];
    
    [self setName:name];
    
    return self;
}

-(void)setName:(NSString *)name
{
    if(name.length==0)
        return;
    
//    name=[NSString stringWithFormat:@"%@%@%@%@%@",name,name,name,name,name];
    [lblShopName setTextAlignment:NSTextAlignmentCenter];
    [lblShopName setText:name];
    [lblShopName setTextColor:[UIColor whiteColor]];
    [lblShopName setFont:[UIFont boldSystemFontOfSize:10]];
    lblShopName.scrollDirection=CBAutoScrollDirectionLeft;
    [lblShopName scrollLabelIfNeeded];
//    [lblShopName setShadowOffset:CGSizeMake(0, 1)];
//    [lblShopName setShadowColor:[UIColor whiteColor]];
}

@end
