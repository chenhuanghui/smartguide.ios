//
//  NewFeedListImageCell.m
//  SmartGuide
//
//  Created by MacMini on 27/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "HomeListImageCell.h"
#import "ImageManager.h"
#import "Utility.h"

@implementation HomeListImageCell

-(void)loadImageWithURL:(NSString *)url
{
    [imgv loadImageHomeListWithURL:url];
}

+(NSString *)reuseIdentifier
{
    return @"HomeListImageCell";
}

-(void)tableDidScroll
{
    float tableOffsetY=self.table.l_co_y;
    CGRect rect=[self.table rectForRowAtIndexPath:self.indexPath];
    
    scroll.contentOffset=CGPointMake((rect.origin.y-tableOffsetY)/2, 0);
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    CGRect rect=self.frame;
    self.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*2);
    self.frame=rect;
}

@end