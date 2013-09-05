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

-(bool)tableTemplateAllowLoadMore:(TableTemplate *)tableTemplate
{
    return true;
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
    return [GalleryCell size].width;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
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
    [UIView animateWithDuration:DURATION_SHOW_USER_GALLERY_IMAGE animations:^{
        txt.alpha=0.0f;
        btn.alpha=0.0f;
        blurr.alpha=0.0f;
        bg.alpha=0;
        table.alpha=0;
    } completion:^(BOOL finished) {
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
    txt.alpha=0.f;
    btn.alpha=0.f;
    blurr.alpha=0.f;
    bg.alpha=0;
    table.alpha=0;
    
    [table reloadData];
    [table scrollToRowAtIndexPath:selectedIndex atScrollPosition:UITableViewScrollPositionNone animated:false];
    
    [UIView animateWithDuration:DURATION_SHOW_USER_GALLERY_IMAGE animations:^{
        txt.alpha=1;
        btn.alpha=1;
        bg.alpha=1;
        blurr.alpha=1;
        table.alpha=1;
    } completion:^(BOOL finished) {
    }];
}

-(UITableView *)table
{
    return table;
}

@end
