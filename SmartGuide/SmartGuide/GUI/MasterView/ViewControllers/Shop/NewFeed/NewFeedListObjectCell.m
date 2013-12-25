//
//  NewFeedListObjectCell.m
//  SmartGuide
//
//  Created by MacMini on 25/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "NewFeedListObjectCell.h"
#import "Utility.h"
#import "ImageManager.h"

@implementation NewFeedListObjectCell

-(void)setImage:(NSString *)url title:(NSString *)title numOfShop:(NSString *)numOfShop content:(NSString *)content
{
    [imgv loadImageHomeWithURL:url];
    lblTitle.text=title;
    lblContent.text=content;
    lblNumOfShop.text=numOfShop;
}

+(NSString *)reuseIdentifier
{
    return @"NewFeedListObjectCell";
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    CGRect rect=self.frame;
    self.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*2);
    self.frame=rect;
}

@end
