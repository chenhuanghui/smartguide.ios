//
//  NewFeedImageCell.m
//  SmartGuide
//
//  Created by MacMini on 25/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "HomeImageCell.h"
#import "Utility.h"
#import "ImageManager.h"

@implementation HomeImageCell

-(void)tableDidScroll
{
    float tableOffsetY=self.table.l_co_y;
    CGRect rect=[self.table rectForRowAtIndexPath:self.indexPath];
    
    scroll.contentOffset=CGPointMake((rect.origin.y-tableOffsetY)/2, 0);
}

-(void)loadImage:(NSString *)url
{
    [imgv loadImageHomeListWithURL:url];
}

+(NSString *)reuseIdentifier
{
    return @"HomeImageCell";
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    CGRect rect=self.frame;
    self.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*2);
    self.frame=rect;
    
    imgv.layer.cornerRadius=2;
    imgv.layer.masksToBounds=true;
}

@end
