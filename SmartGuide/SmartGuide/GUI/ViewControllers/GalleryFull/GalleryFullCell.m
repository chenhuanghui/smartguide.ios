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
    [self zoomOut:false];
}

-(void)galleryDidScroll
{
    CGRect rect=[self.table rectForRowAtIndexPath:self.indexPath];
    [scroll l_v_setX:self.table.l_co_y-rect.origin.y];
    
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

-(bool)isZoomed
{
    return CGSizeEqualToSize(imgv.frame.size, imgv.image.size);
}

-(void)zoomInAtPoint:(CGPoint)pnt
{
    [UIView animateWithDuration:0.3f animations:^{
        [imgv l_v_setS:imgv.image.size];
    } completion:^(BOOL finished) {
        scroll.contentSize=imgv.image.size;
        scroll.userInteractionEnabled=true;
        scroll.scrollEnabled=true;
    }];
}

-(void)zoomOut
{
    [self zoomOut:true];
}

-(void)zoomOut:(bool) animate
{
    if(animate)
    {
        [UIView animateWithDuration:0.3f animations:^{
            [imgv l_v_setS:scroll.frame.size];
        } completion:^(BOOL finished) {
            scroll.contentSize=imgv.frame.size;
            scroll.userInteractionEnabled=false;
            scroll.scrollEnabled=false;
        }];
    }
    else
    {
        [imgv l_v_setS:scroll.frame.size];
        scroll.contentSize=imgv.frame.size;
        scroll.userInteractionEnabled=false;
        scroll.scrollEnabled=false;
    }
}

@end
