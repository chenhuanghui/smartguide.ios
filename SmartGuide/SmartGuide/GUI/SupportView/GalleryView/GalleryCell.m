//
//  GalleryCell.m
//  SmartGuide
//
//  Created by XXX on 8/16/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "GalleryCell.h"
#import "UIImageView+AFNetworking.h"
#import "Utility.h"
#import "Constant.h"

@interface GalleryCell()
{
}

@property (nonatomic,strong) UITapGestureRecognizer *tap;

@end

@implementation GalleryCell
@synthesize tap;

- (id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:NIB_PHONE(@"GalleryCell") owner:nil options:nil] objectAtIndex:0];
    
    scroll.delegate=self;
    scroll.showsHorizontalScrollIndicator=false;
    scroll.showsVerticalScrollIndicator=false;
    scroll.minimumZoomScale=1;
    scroll.maximumZoomScale=1;
    scroll.scrollEnabled=false;
    scroll.clipsToBounds=true;
    scroll.contentSize=scroll.frame.size;
    
    self.tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired=2;
    tap.numberOfTouchesRequired=1;
    
    [scroll addGestureRecognizer:tap];
    
    return self;
}

-(void) tap:(UITapGestureRecognizer*) tapGes
{
    if(tapGes.state==UIGestureRecognizerStateEnded)
    {
        [self zoomIn:[tapGes locationInView:scroll]];
    }
}

-(void) zoomOut
{
    scroll.maximumZoomScale=1;
    scroll.minimumZoomScale=1;
    scroll.scrollEnabled=false;
    [scroll setZoomScale:1 animated:false];
    _isZoomed=false;
}

-(void) zoomIn:(CGPoint) zoomLocation
{
    if(_isZoomed)
    {
        [self zoomOut];
        return;
    }
    
    if(!imgv.image)
        return;

    CGSize scrollViewSize = scroll.frame.size;
    
    CGFloat widthScale = imgv.image.size.width / self.frame.size.width;
    CGFloat heightScale = imgv.image.size.height / self.frame.size.height;
    scroll.maximumZoomScale=MAX(MIN(widthScale, heightScale),1)*2;
    
    CGFloat zoomScale = (scroll.zoomScale == scroll.maximumZoomScale) ?
    scroll.minimumZoomScale : scroll.maximumZoomScale;
    
    CGFloat width = scrollViewSize.width / zoomScale;
    CGFloat height = scrollViewSize.height / zoomScale;
    CGFloat x = zoomLocation.x - (width / 2);
    CGFloat y = zoomLocation.y - (height / 2);
    
    CGRect rect=[UIScreen mainScreen].bounds;
    rect.origin=scroll.frame.origin;
    scroll.frame=rect;
    scroll.scrollEnabled=true;
    [scroll zoomToRect:CGRectMake(x, y, width, height) animated:YES];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imgv;
}

-(void) setImageURL:(NSURL*) url desc:(NSString *)desc
{
    [self zoomOut];
    imgv.image=nil;
    [imgv setImageWithLoading:url emptyImage:UIIMAGE_LOADING_SHOP_GALLERY success:^(UIImage *image) {
        [self setIMG:image desc:desc];
    } failure:^(UIImage *emptyImage) {
        [self setIMG:emptyImage desc:desc];
    }];
    
    txt.text=desc;
    
    txt.hidden=_isHiddenDesc;
}

-(void)setIMG:(UIImage *)image desc:(NSString *)desc
{
    imgv.image=nil;
    
    if(![image isKindOfClass:[UIImage class]])
        return;

    imgv.image=image;
    scroll.contentSize=scroll.frame.size;
    
    txt.text=desc;
}

+(NSString *)reuseIdentifier
{
    return @"GalleryCell";
}

-(UIImageView *)imgv
{
    return imgv;
}

+(CGSize)size
{
    return CGSizeMake(320, SCREEN_HEIGHT);
}

-(void)setDescriptionVisibleWithDuration:(bool)visible duration:(float)duration
{
    _isHiddenDesc=!visible;
    txt.hidden=false;
    
    if(visible)
        txt.alpha=0;
    else
        txt.alpha=1;
    
    [UIView animateWithDuration:duration animations:^{
        txt.alpha=visible?1:0;
    } completion:^(BOOL finished) {
        txt.hidden=!visible;
    }];
}

-(void)setDescriptVisible:(bool)visible
{
    _isHiddenDesc=!visible;
    txt.hidden=_isHiddenDesc;
}

@end

@implementation ScrollGallery

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return false;
}

@end