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
#define DURATION_ZOOM_GALLERY 0.25f

@implementation GalleryFullCell

+(NSString *)reuseIdentifier
{
    return @"GalleryFullCell";
}

-(void)loadImageURL:(NSString *)url
{
    [imgv loadShopGalleryFullWithURL:url];
    
    [self zoomOut:false completed:nil];
}

-(void)loadWithImage:(UIImage *)image
{
    imgv.image=image;
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
        
        [UIView animateWithDuration:DURATION_ZOOM_GALLERY animations:^{
            imgv.frame=rect;
            scroll.contentSize=self.l_v_s;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:DURATION_ZOOM_GALLERY animations:^{
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
    // Nếu width và height của hình nhỏ hơn frame thì ko zoom do bị vỡ pixcel
    if([imgv isImageSmaller])
    {
        if(onCompleted)
            onCompleted();
        
        return;
    }
    
    CGRect imgFrame=[imgv imageFrame];
    
    if(CGRectContainsPoint(imgFrame, pnt))
    {
        // Vị trí tương đối giữa hình trước và sau khi zoom;
        float perX=pnt.x/self.collView.frame.size.width;
        float perY=pnt.y/self.collView.frame.size.height;
        
        pnt.x=imgv.image.size.width*perX;
        pnt.y=imgv.image.size.height*perY;
    }
    else
    {
        // Touch vào vùng đen ngoài hình->mặc định zoom vào top left;
        pnt=CGPointZero;
        
        [self.delegate galleryFullCellTouchedOutsideImage:self];
        return;
    }
    
    CGRect visiRect=CGRectMake(pnt.x-scroll.frame.size.width/2, pnt.y-scroll.frame.size.height/2, scroll.frame.size.width, scroll.frame.size.height);
    
    scroll.contentSize=imgv.image.size;
    scroll.userInteractionEnabled=true;
    
    CGRect rect=imgv.frame;
    
    //Center hình nếu 1 cạnh nhỏ hơn frame
    rect.size.width=MAX(imgv.image.size.width,scroll.frame.size.width);
    rect.size.height=MAX(imgv.image.size.height,scroll.frame.size.height);
    
    if(animate)
    {
        float w=MAX(rect.size.height,rect.size.width)*GALLERY_FULL_CELL_BOUNCE;
        
        CGRect oriRect=rect;
        
        rect.origin.x-=w/2;
        rect.origin.y-=w/2;
        rect.size.width+=w;
        rect.size.height+=w;
        [UIView animateWithDuration:DURATION_ZOOM_GALLERY animations:^{
            imgv.frame=rect;
            [scroll scrollRectToVisible:visiRect animated:false];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:DURATION_ZOOM_GALLERY animations:^{
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
        {
            if([self.collView indexPathForCell:self].row==0)
                imgv.frame=CGRectMake(0, 0, imgv.frame.size.width, imgv.frame.size.height);
            else
                imgv.frame=CGRectMake(self.collView.contentOffset.x-rect.origin.x, 0, imgv.frame.size.width, imgv.frame.size.height);
        }
    }
}

-(bool)isZoomed
{
    return scroll.userInteractionEnabled;
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