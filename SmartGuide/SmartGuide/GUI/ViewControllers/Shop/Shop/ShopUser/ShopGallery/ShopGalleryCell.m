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
#import "ImageManager.h"

@implementation ShopGalleryCell
@synthesize table;

+(NSString *)reuseIdentifier
{
    return @"ShopGalleryCell";
}

-(void)loadImage:(NSString *)url
{
    [imgv loadShopCoverWithURL:url];
}

-(void)tableViewDidScroll
{
    float tableOffsetY=table.l_co_y;
    CGRect rect=[table rectForRowAtIndexPath:self.indexPath];
    
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
