//
//  ShopDetailInfoImageCell.m
//  SmartGuide
//
//  Created by MacMini on 03/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoImageCell.h"

@implementation ShopDetailInfoImageCell

-(void)loadWithImage:(UIImage *)image withTitle:(NSString *)title withContent:(NSString *)content
{
    imgv.image=image;
    lblTitle.text=title;
    lblContent.text=content;
}

+(NSString *)reuseIdentifier
{
    return @"ShopDetailInfoImageCell";
}

+(float) heightWithContent:(NSString*) content
{
    return 86;
}

@end
