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
    
    [imgv loadShopGalleryFullWithURL:url];
    
    [self zoomOut:false];
}

-(void) zoomOut:(bool) animate
{
    if(animate)
    {
        scroll.userInteractionEnabled=false;
        
        [UIView animateWithDuration:0.15f animations:^{
            CGRect rect=imgv.frame;
            rect.size=self.frame.size;
            
            imgv.frame=rect;
            scroll.contentSize=rect.size;
        }];
    }
    else
    {
        scroll.userInteractionEnabled=false;
        
        CGRect rect=imgv.frame;
        rect.size=self.frame.size;
        
        imgv.frame=rect;
        scroll.contentSize=rect.size;
    }
}

-(void) zoomIn:(bool) animate point:(CGPoint) pnt
{
    CGRect imgFrame=[self imageFrame];
    
    if(CGRectContainsPoint(imgFrame, pnt))
    {
        float perX=pnt.x/self.collView.frame.size.width;
        float perY=pnt.y/self.collView.frame.size.height;
        
        pnt.x=(imgv.image.size.width*perX);
        pnt.y=(imgv.image.size.height*perY);
    }
    else
    {
        pnt=CGPointZero;
    }
    
    CGRect rect=imgv.frame;
    rect.size=imgv.image.size;
    
    scroll.contentSize=rect.size;
    scroll.userInteractionEnabled=true;
    
    if(animate)
    {
        [UIView animateWithDuration:0.15f animations:^{
            imgv.frame=rect;
            [scroll scrollRectToVisible:CGRectMake(pnt.x-scroll.frame.size.width/2, pnt.y-scroll.frame.size.height/2, scroll.frame.size.width, scroll.frame.size.height) animated:false];
        }];
    }
    else
    {
        imgv.frame=rect;
        [scroll scrollRectToVisible:CGRectMake(pnt.x-scroll.frame.size.width/2, pnt.y-scroll.frame.size.height/2, scroll.frame.size.width, scroll.frame.size.height) animated:false];
    }
}

-(void)zoom:(CGPoint)pnt
{
    if(scroll.userInteractionEnabled)
    {
        [self zoomOut:true];
    }
    else
    {
        [self zoomIn:true point:pnt];
    }
}

- (CGRect)imageFrame
{
    UIImageView *iv=imgv; // your image view
    CGSize imageSize = iv.image.size;
    CGFloat imageScale = fminf(CGRectGetWidth(iv.bounds)/imageSize.width, CGRectGetHeight(iv.bounds)/imageSize.height);
    CGSize scaledImageSize = CGSizeMake(imageSize.width*imageScale, imageSize.height*imageScale);
    CGRect imageFrame = CGRectMake(roundf(0.5f*(CGRectGetWidth(iv.bounds)-scaledImageSize.width)), roundf(0.5f*(CGRectGetHeight(iv.bounds)-scaledImageSize.height)), roundf(scaledImageSize.width), roundf(scaledImageSize.height));
    
    return imageFrame;
}

-(void)collectionViewDidScroll
{
    CGRect rect=[self.collView layoutAttributesForItemAtIndexPath:self.indexPath].frame;
    
    if(scroll.userInteractionEnabled)
        imgv.frame=CGRectMake(0, 0, imgv.frame.size.width, imgv.frame.size.height);
    else
    {
        bool hasZoom=false;;
        for(GalleryFullCell *cell in self.collView.visibleCells)
        {
            if(cell.isZoomed)
            {
                hasZoom=true;
                break;
            }
        }
        
        if(hasZoom)
            imgv.frame=CGRectMake(0, 0, imgv.frame.size.width, imgv.frame.size.height);
        else
            imgv.frame=CGRectMake(self.collView.contentOffset.x-rect.origin.x, 0, imgv.frame.size.width, imgv.frame.size.height);
    }
}

-(bool)isZoomed
{
    return scroll.userInteractionEnabled;
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

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imgv;
}

@end

@implementation ScrollFullCell
@synthesize limitScrollOffset;

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.limitScrollOffset=CGPointMake(-1, -1);
}

-(void)setContentOffset1:(CGPoint)contentOffset
{
    NSLog(@"%@ %@",NSStringFromCGPoint(contentOffset),NSStringFromCGPoint(self.limitScrollOffset));
    
    if(limitScrollOffset.x!=-1 && fabsf(contentOffset.x)<limitScrollOffset.x)
        contentOffset.x=limitScrollOffset.x*(contentOffset.x==0? 1 : (contentOffset.x/contentOffset.x));
    if(limitScrollOffset.y!=-1)
    {
        if(contentOffset.y<0 && contentOffset.y<-limitScrollOffset.y)
            contentOffset.y=-limitScrollOffset.y;
        else if(contentOffset.y>0 && contentOffset.y>limitScrollOffset.y)
            contentOffset.y=limitScrollOffset.y;
    }
    
    [super setContentOffset:contentOffset];
}

@end