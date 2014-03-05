//
//  GalleryFullCell.m
//  SmartGuide
//
//  Created by MacMini on 05/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "GalleryFullCell.h"
#import "ImageManager.h"
#import "Utility.h"

@implementation GalleryFullCell

+(NSString *)reuseIdentifier
{
    return @"GalleryFullCell";
}

-(void)loadImageURL:(NSString *)url
{
    [imgv loadShopGalleryWithURL:url];
}

-(void)tableDidScroll
{
    CGRect rect=[self.table rectForRowAtIndexPath:self.indexPath];
    [scroll l_v_setX:self.table.l_co_y-rect.origin.y];
//    [scroll l_v_setW:320];
    
    int idx=self.table.l_co_y/320;
    
    if(idx==self.indexPath.row)
        imgv.alpha=1;
    else
    {
        float w=320-(rect.origin.y-self.table.l_co_y);
        
        imgv.alpha=(w/320)*2;
    }
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    CGRect rect=self.frame;
    self.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*2);
    self.frame=rect;
}

@end
