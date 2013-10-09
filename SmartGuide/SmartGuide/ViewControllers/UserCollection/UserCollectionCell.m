//
//  UserCollectionCell.m
//  SmartGuide
//
//  Created by XXX on 8/7/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "UserCollectionCell.h"
#import "UIImageView+AFNetworking.h"
#import "Constant.h"

@implementation UserCollectionCell

-(void)loadData:(Shop *)collection
{
    logo.image=nil;
    [logo setSmartGuideImageWithURL:[NSURL URLWithString:collection.logo] placeHolderImage:UIIMAGE_LOADING_SHOP_LOGO success:nil failure:nil];
    lblSGP.text=[NSString stringWithFormat:@"%0.0f",collection.SGP];
    lblSP.text=[NSString stringWithFormat:@"%0.0f",collection.SP];
    lblTime.text=collection.time;
    lblDay.text=collection.day;
    lblName.text=[collection.name uppercaseString];
    [lblName scrollLabelIfNeeded];
}

+(NSString *)reuseIdentifier
{
    return @"UserCollectionCell";
}

+(CGSize)size
{
    return CGSizeMake(206, 46);
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    lblName.textColor=[UIColor whiteColor];
    lblName.backgroundColor=[UIColor clearColor];
    lblName.font=[UIFont boldSystemFontOfSize:10];
    
    [super willMoveToSuperview:newSuperview];
}

@end
