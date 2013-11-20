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
    imgv.image=[UIImage imageNamed:@"cover.jpg"];
}

-(void)setLbl:(NSString *)text
{
    imgv.image=[UIImage imageNamed:@"cover.jpg"];
    llbbll.text=@"";
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    CGRect rect=self.frame;
    self.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*2);
    self.frame=rect;
}

@end
