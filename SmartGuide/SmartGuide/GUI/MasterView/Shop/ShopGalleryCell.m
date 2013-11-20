//
//  ShopGalleryCell.m
//  SmartGuide
//
//  Created by MacMini on 20/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopGalleryCell.h"
#import "Constant.h"
#import "Utility.h"

@implementation ShopGalleryCell

+(NSString *)reuseIdentifier
{
    return @"ShopGalleryCell";
}

-(void)loadImage:(NSString *)url
{
    
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    CGRect rect=self.frame;
    rect.size=CGSizeMake(rect.size.height, rect.size.width);
    self.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45));
    self.frame=rect;
}

@end
