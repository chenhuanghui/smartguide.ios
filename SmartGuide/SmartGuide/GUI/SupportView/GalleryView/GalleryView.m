//
//  GalleryView.m
//  SmartGuide
//
//  Created by XXX on 8/16/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "GalleryView.h"
#import "Utility.h"
#import "Constant.h"
#import "GMGridViewLayoutStrategies.h"

@interface GalleryView()
{
    bool _isHideInfo;
}

@property (nonatomic,strong) UITapGestureRecognizer *_tap;

@end

@implementation GalleryView
@synthesize delegate,_tap;
@synthesize selectedIndex;

- (id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:NIB_PHONE(@"GalleryView") owner:nil options:nil] objectAtIndex:0];
    
    bg.backgroundColor=[UIColor blackColor];;
    blurr.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blur_gallery.png"]];
    
    grid.itemSpacing=0;
    grid.centerGrid=false;
    grid.minEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 0);
    grid.style=GMGridViewStylePush;
    grid.layoutStrategy=[GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutHorizontalPagedLTR];
    
    
    self._tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    _tap.numberOfTapsRequired=1;
    _tap.delegate=self;
    
    [self addGestureRecognizer:_tap];
    
    return self;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if(touch.view ==btn)
        return false;
    
    return true;
}

-(NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return 0;
}

-(void) tap:(UITapGestureRecognizer*) tap
{
    switch (tap.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
            if(_isHideInfo)
            {
                tap.enabled=false;
                [self showInfo:^{
                    tap.enabled=true;
                }];
            }
            else
            {
                tap.enabled=false;
                [self hideInfo:^{
                    tap.enabled=true;
                }];
            }
            break;
            
        default:
            break;
    }
}

-(void) hideInfo:(void(^)()) completed
{
    _isHideInfo=true;
    
    [UIView animateWithDuration:DURATION_SHOW_GALLERY_VIEW_INFO animations:^{
        btn.alpha=0;
        blurr.alpha=0;
        txt.alpha=0;
    } completion:^(BOOL finished) {
        btn.hidden=true;
        blurr.hidden=true;
        txt.hidden=true;
        
        completed();
    }];
}

-(void) showInfo:(void(^)()) completed
{
    _isHideInfo=false;
    
    btn.hidden=false;
    blurr.hidden=false;
    txt.hidden=false;
    
    [UIView animateWithDuration:DURATION_SHOW_GALLERY_VIEW_INFO animations:^{
        btn.alpha=1;
        blurr.alpha=1;
        txt.alpha=1;
    } completion:^(BOOL finished) {
        completed();
    }];
}

-(GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    GMGridViewCell *cell=[gridView dequeueReusableCellWithIdentifier:[GalleryCell reuseIdentifier]];
    
    if(!cell)
    {
        cell=[[GMGridViewCell alloc] init];
        cell.reuseIdentifier=[GalleryCell reuseIdentifier];
        cell.contentView=[[GalleryCell alloc] init];
    }
    
    return cell;
}

-(CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return [GalleryCell size];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self refreshDesc];
}

-(void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    
}

-(void) refreshDesc
{
    if(_isAllowDescription)
        if(delegate && [delegate respondsToSelector:@selector(galleryViewDescriptionImage:)])
        {
            txt.text=[delegate galleryViewDescriptionImage:grid.currentPage];
        }
}

- (IBAction)btnTouchUpInside:(id)sender {
    int index=[grid.layoutStrategy itemPositionFromLocation:grid.contentOffset];
    GMGridViewCell *cell=[grid cellForItemAtIndex:index];
    GalleryCell *gallery=(GalleryCell*)cell.contentView;
    
    UIImage *img=gallery.imgv.image;
    UIImageView *imgv=[[UIImageView alloc] initWithImage:img];
    imgv.contentMode=UIViewContentModeScaleAspectFit;
    imgv.frame=CGRectMake(0, 0, grid.frame.size.width, grid.frame.size.height);
    
    [self addSubview:imgv];
    
    [grid removeFromSuperview];
    
    [UIView animateWithDuration:DURATION_SHOW_USER_GALLERY_IMAGE animations:^{
        CGRect rect=[delegate galleryViewFrameForAnimationHide:self index:index];
        imgv.frame=rect;
        txt.alpha=0.3f;
        btn.alpha=0.3f;
        blurr.alpha=0.3f;
        bg.alpha=0;
    } completion:^(BOOL finished) {
        [imgv removeFromSuperview];
        [delegate galleryViewBack:self];
    }];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    
    if(newSuperview)
    {
        if(delegate)
        {
            _isAllowDescription=[delegate galleryViewAllowDescription:self];
            
            if(!_isAllowDescription)
            {
                [blurr removeFromSuperview];
                blurr=nil;
            }
            
        }
        
        [self refreshDesc];
    }
}

-(void)animationImage:(UIImage *)image startRect:(CGRect)rect
{
    grid.hidden=true;
    
    txt.alpha=0.f;
    btn.alpha=0.f;
    blurr.alpha=0.f;
    bg.alpha=0;
    
    UIImageView *imgv=[[UIImageView alloc] initWithFrame:rect];
    imgv.image=image;
    imgv.backgroundColor=[UIColor clearColor];
    imgv.contentMode=UIViewContentModeScaleAspectFit;
    
    [self insertSubview:imgv aboveSubview:bg];
    
    [UIView animateWithDuration:DURATION_SHOW_USER_GALLERY_IMAGE animations:^{
        CGSize size=grid.frame.size;
        imgv.frame=CGRectMake(0, 0, size.width, size.height);
        
        txt.alpha=1;
        btn.alpha=1;
        bg.alpha=1;
        blurr.alpha=1;
    } completion:^(BOOL finished) {
        [grid reloadData];
        [grid scrollToObjectAtIndex:selectedIndex atScrollPosition:GMGridViewScrollPositionNone animated:false];
        grid.hidden=false;
        
        imgv.image=nil;
        [imgv removeFromSuperview];
    }];
}

-(GMGridView *)gridView
{
    return grid;
}

@end
