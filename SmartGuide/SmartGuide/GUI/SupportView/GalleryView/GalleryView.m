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

@interface GalleryView()
{
    bool _isHideInfo;
}

@property (nonatomic,strong) UITapGestureRecognizer *_tap;

@end

@implementation GalleryView
@synthesize delegate,_tap;

- (id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"GalleryView" owner:nil options:nil] objectAtIndex:0];
    
    bg.backgroundColor=[UIColor blackColor];;
    blurr.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blur_gallery.png"]];
    
    CGRect rect=table.frame;
    table.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45*6));
    table.frame=rect;
    
    [table registerNib:[UINib nibWithNibName:[GalleryCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[GalleryCell reuseIdentifier]];
    
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GalleryCell *cell=[tableView dequeueReusableCellWithIdentifier:[GalleryCell reuseIdentifier]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 320;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self refreshDesc];
}

-(void) refreshDesc
{
    if(_isAllowDescription)
        if(delegate && [delegate respondsToSelector:@selector(galleryViewDescriptionImage:)])
        {
            txt.text=[delegate galleryViewDescriptionImage:table.currentPageForHoriTable];
        }
}

- (IBAction)btnTouchUpInside:(id)sender {
    
    if([table indexPathsForVisibleRows].count>0)
    {
        NSIndexPath *indexPath=[table.indexPathsForVisibleRows objectAtIndex:0];
        UIImageView *imgvCell=[((GalleryCell*)[table cellForRowAtIndexPath:indexPath]) imgv];
        UIImageView *imgv=[[UIImageView alloc] initWithImage:imgvCell.image];
        imgv.frame=imgvCell.frame;
        
        [self addSubview:imgv];
        table.hidden=true;
        
        if(imgv.image)
        {
            [UIView animateWithDuration:DURATION_SHOW_USER_GALLERY_IMAGE animations:^{
                CGRect rect=[delegate galleryViewFrameForAnimationHide:self indexPath:indexPath];
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
        else
            [delegate galleryViewBack:self];
    }
    else
        [delegate galleryViewBack:self];
}

-(UITableView *)table
{
    return table;
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    
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

-(void)animationImage:(UIImage *)image startRect:(CGRect)rect
{
    table.hidden=true;
    txt.alpha=0.f;
    btn.alpha=0.f;
    blurr.alpha=0.f;
    bg.alpha=0;
    
    UIImageView *imgv=[[UIImageView alloc] initWithFrame:rect];
    imgv.image=image;
    imgv.backgroundColor=[UIColor clearColor];
    
    [UIView animateWithDuration:DURATION_SHOW_USER_GALLERY_IMAGE animations:^{
        CGSize size=[Utility scaleProportionallyFromSize:image.size toSize:[UIScreen mainScreen].bounds.size];
        imgv.frame=CGRectMake(0, (self.frame.size.height-size.height)/2, size.width, size.height);
        
        txt.alpha=1;
        btn.alpha=1;
        bg.alpha=1;
        blurr.alpha=1;
    } completion:^(BOOL finished) {
        table.hidden=false;
        [imgv removeFromSuperview];
    }];
    
    [self insertSubview:imgv aboveSubview:bg];
}

@end
