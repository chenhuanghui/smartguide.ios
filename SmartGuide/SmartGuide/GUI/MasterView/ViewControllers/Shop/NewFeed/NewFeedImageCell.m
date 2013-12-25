//
//  NewFeedImageCell.m
//  SmartGuide
//
//  Created by MacMini on 25/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "NewFeedImageCell.h"
#import "Utility.h"
#import "ImageManager.h"

@implementation NewFeedImageCell

-(void)loadImage:(NSString *)url
{
    [imgv loadImageHomeWithURL:url];
}

+(NSString *)reuseIdentifier
{
    return @"NewFeedImageCell";
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    CGRect rect=self.frame;
    self.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*2);
    self.frame=rect;
}

@end
