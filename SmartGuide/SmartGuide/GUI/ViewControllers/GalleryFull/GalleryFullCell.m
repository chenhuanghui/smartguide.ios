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

#define GALLERY_FULL_CELL_BOUNCE 0.02f

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
    
    [self zoomOut:false completed:nil];
}

-(void) zoomOut:(bool) animate completed:(void(^)()) onCompleted
{
    if(animate)
    {
        scroll.userInteractionEnabled=false;
        
        CGRect rect=self.frame;
        rect.origin=CGPointZero;
        
        float w=MAX(rect.size.height,rect.size.width)*GALLERY_FULL_CELL_BOUNCE;
        
        CGRect oriRect=rect;
        rect.origin.x+=w/2;
        rect.origin.y+=w/2;
        rect.size.width-=w;
        rect.size.height-=w;
        
        [UIView animateWithDuration:0.15f animations:^{
            imgv.frame=rect;
            scroll.contentSize=self.l_v_s;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15f animations:^{
                imgv.frame=oriRect;
            } completion:^(BOOL finished) {
                if(onCompleted)
                    onCompleted();
            }];
        }];
    }
    else
    {
        scroll.userInteractionEnabled=false;
        
        CGRect rect=imgv.frame;
        rect.size=self.frame.size;
        
        imgv.frame=rect;
        scroll.contentSize=rect.size;
        
        if(onCompleted)
            onCompleted();
    }
}

-(void) zoomIn:(bool) animate point:(CGPoint) pnt completed:(void(^)()) onCompleted
{
    if(![imgv isImageBigger])
        return;
    
    CGRect imgFrame=[imgv imageFrame];
    
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
    rect.size=[Utility scaleProportionallyHeightFromSize:imgv.image.size toHeight:imgv.l_v_h];
    
    float h=imgv.l_v_h/imgv.image.size.height;
    CGRect visiRect=CGRectMake(pnt.x*h-scroll.frame.size.width/2, pnt.y*h-scroll.frame.size.height/2, scroll.frame.size.width, scroll.frame.size.height);
    
    scroll.contentSize=rect.size;
    scroll.userInteractionEnabled=true;
    
    if(animate)
    {
        float w=MAX(rect.size.height,rect.size.width)*GALLERY_FULL_CELL_BOUNCE;
        
        CGRect oriRect=rect;
        rect.origin.x-=w/2;
        rect.origin.y-=w/2;
        rect.size.width+=w;
        rect.size.height+=w;
        
        [UIView animateWithDuration:0.15f animations:^{
            imgv.frame=rect;
            [scroll scrollRectToVisible:visiRect animated:false];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15f animations:^{
                imgv.frame=oriRect;
            } completion:^(BOOL finished) {
                if(onCompleted)
                    onCompleted();
            }];
        }];
    }
    else
    {
        imgv.frame=rect;
        [scroll scrollRectToVisible:visiRect animated:false];
        if(onCompleted)
            onCompleted();
    }
}

-(void)zoom:(CGPoint)pnt completed:(void (^)())onCompleted
{
    if(scroll.userInteractionEnabled)
    {
        [self zoomOut:true completed:onCompleted];
    }
    else
    {
        [self zoomIn:true point:pnt completed:onCompleted];
    }
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
    [self zoomOut:true completed:nil];
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