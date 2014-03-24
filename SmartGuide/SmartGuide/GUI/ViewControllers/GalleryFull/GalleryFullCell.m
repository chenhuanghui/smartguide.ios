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

static NSMutableDictionary *_galleryFullURLSize=nil;
@implementation GalleryFullCell

+(NSString *)reuseIdentifier
{
    return @"GalleryFullCell";
}

-(void)loadImageURL:(NSString *)url imageSize:(CGSize)imgSize
{
    if(!_galleryFullURLSize)
        _galleryFullURLSize=[[NSMutableDictionary alloc] init];
    
    [imgv loadShopGalleryFullWithURL:url process:^(NSString *imgUrl, CGSize imageSize) {
        [self makeScrollScaleWithImageSize:imageSize imgUrl:imgUrl];
    } completed:^(NSString *imgUrl, CGSize imageSize) {
        [self makeScrollScaleWithImageSize:imageSize imgUrl:imgUrl];
    }];
    
    scroll.zoomScale=1;
}

-(void) makeScrollScaleWithImageSize:(CGSize) imgSize imgUrl:(NSString*) imgUrl
{
    if(CGSizeEqualToSize(imgSize,CGSizeZero))
    {
        scroll.maximumZoomScale=1;
        scroll.minimumZoomScale=1;
        
        return;
    }
    
    //Hình nhỏ hơn khung
    if(self.frame.size.width>imgSize.width || self.frame.size.height>imgSize.height)
    {
        scroll.minimumZoomScale=MIN(self.frame.size.width/imgSize.width,self.frame.size.height/imgSize.height);
        scroll.maximumZoomScale=1;
    }
    //Hình lớn hơn khung
    else
    {
        scroll.minimumZoomScale=1;
        scroll.maximumZoomScale=MAX(imgSize.width/self.frame.size.width,imgSize.height/self.frame.size.height);
    }
    
    NSLog(@"makeScrollScaleWithImageSize %f %f %@",scroll.maximumZoomScale,scroll.minimumZoomScale,NSStringFromCGSize(imgSize));
}

-(void)galleryDidScroll
{
    CGRect rect=[self.collView rectForItemAtIndexPath:self.indexPath];
    [imgv l_v_setX:self.collView.l_co_x-rect.origin.x];
    
    int idx=self.collView.l_co_y/320;
    
    if(idx==self.indexPath.row)
        imgv.alpha=1;
    else
    {
        float w=320-(rect.origin.y-self.collView.l_co_y);
        
        imgv.alpha=(w/320)*2;
    }
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

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imgv;
}

@end
