//
//  NewFeedListImageCell.m
//  SmartGuide
//
//  Created by MacMini on 27/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "NewFeedListImageCell.h"
#import "ImageManager.h"
#import "Utility.h"

@implementation NewFeedListImageCell

-(void)loadImageWithURL:(NSString *)url
{
    [imgv loadImageHomeListWithURL:url];
}

+(NSString *)reuseIdentifier
{
    return @"NewFeedListImageCell";
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    CGRect rect=self.frame;
    self.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*2);
    self.frame=rect;
}

@end