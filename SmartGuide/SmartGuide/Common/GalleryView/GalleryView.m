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
@property (nonatomic, strong) UITapGestureRecognizer *_doubleTap;

@end

@implementation GalleryView
@synthesize delegate,_tap,_doubleTap;

-(GalleryView *)initWithDelegate:(id<GalleryViewDelegate>)_delegate defaultIndex:(NSUInteger)currentIndex
{
    self = [[[NSBundle mainBundle] loadNibNamed:NIB_PHONE(@"GalleryView") owner:nil options:nil] objectAtIndex:0];
    
    bg.backgroundColor=[UIColor blackColor];;

    self.delegate=_delegate;
    
    _page=0;
    _isAllowDescription=[self.delegate galleryViewAllowDescription:self];
    _isAllowLoadMore=[self.delegate galleryViewAllowLoadMore:self];
    
    self._tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    _tap.numberOfTapsRequired=1;
    _tap.numberOfTouchesRequired=1;
    _tap.delegate=self;
    
    [self addGestureRecognizer:_tap];
    
    self._doubleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    _doubleTap.numberOfTapsRequired=2;
    _doubleTap.numberOfTouchesRequired=1;
    
    [_tap requireGestureRecognizerToFail:_doubleTap];
    
    [self addGestureRecognizer:_doubleTap];
    
    grid.centerGrid=false;
    grid.minEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 0);
    grid.style=GMGridViewStylePush;
    grid.itemSpacing=30;
    grid.layoutStrategy=[[GalleryLayoutStragery alloc] init];
    grid.pagingEnabled=true;
    grid.clipsToBounds=false;
    
    grid.delegate=self;
    grid.dataSource=self;
    
    _currentIndex=currentIndex;
    
    [grid scrollToObjectAtIndex:currentIndex atScrollPosition:GMGridViewScrollPositionNone animated:false];
    
    return self;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if(touch.view==btn)
        return false;
    
    return true;
}

-(void) doubleTap:(UITapGestureRecognizer*) tap
{
    
}

-(void) tap:(UITapGestureRecognizer*) tap
{
    switch (tap.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
            if(_isHideInfo)
            {
                [self showInfo:^{
                }];
            }
            else
            {
                [self hideInfo:^{
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
    } completion:^(BOOL finished) {
        btn.hidden=true;
        
        completed();
    }];
    
    [self setVisibleDescription:false];
}

-(void) showInfo:(void(^)()) completed
{
    _isHideInfo=false;
    
    btn.hidden=false;
    
    [UIView animateWithDuration:DURATION_SHOW_GALLERY_VIEW_INFO animations:^{
        btn.alpha=1;
    } completion:^(BOOL finished) {
        completed();
    }];
    
    [self setVisibleDescription:true];
}

-(void) setVisibleDescription:(bool) visible
{
    for(GMGridViewCell *cell in [grid itemSubviews])
    {
        if([cell.contentView isKindOfClass:[GalleryCell class]])
        {
            GalleryCell *gCell=(GalleryCell*)cell.contentView;
            [gCell setDescriptionVisibleWithDuration:visible duration:DURATION_SHOW_GALLERY_VIEW_INFO];
        }
    }
}

-(NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    NSUInteger count=[delegate numberOfItemInGallery:self];
    
    if(count>0 && _isAllowLoadMore)
        return count+1;
    
    return count;
}

-(void)endLoadMore
{
    _page++;
    _isNeedReload=true;
    _isLoadingMore=false;
    
    [self tryReloadGrid];
}

-(void) tryReloadGrid
{
    [grid reloadData];
}

-(GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    if(_isAllowLoadMore && index==[gridView totalItemCount]-1)
    {
        GMGridViewCell *cell=[gridView dequeueReusableCellWithIdentifier:@"Loading"];
        
        if(!cell)
        {
            cell=[[GMGridViewCell alloc] init];
            cell.reuseIdentifier=@"Loading";
            cell.contentView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        }
        
        UIActivityIndicatorView *indicator=(UIActivityIndicatorView*)cell.contentView;
        
        [indicator startAnimating];
        
        if(!_isLoadingMore)
        {
            bool isNeedWait=false;
            [delegate galleryViewLoadMore:self atPage:_page+1 needWait:&isNeedWait];
            
            if(isNeedWait)
                _isLoadingMore=true;
            else
            {
                [self endLoadMore];
            }
        }
        
        return cell;
    }
    
    GalleryGridCell *cell=(GalleryGridCell*)[gridView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(!cell)
    {
        cell=[[GalleryGridCell alloc] init];
        cell.reuseIdentifier=@"Cell";
        cell.contentView=[[GalleryCell alloc] init];
    }
    
    GalleryCell *gcell=(GalleryCell*)cell.contentView;
    
    if([gcell isKindOfClass:[GalleryCell class]])
    {
        GalleryItem *item=[delegate galleryViewItemAtIndex:self index:index];
        
        [gcell setDescriptVisible:_isAllowDescription && !_isHideInfo];
        
        if(item.image)
            [gcell setIMG:item.image desc:item.imageDescription];
        else
            [gcell setImageURL:item.imageURL desc:item.imageDescription];
    }
    
    return cell;
}

-(CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return [UIScreen mainScreen].bounds.size;
}

- (IBAction)btnTouchUpInside:(id)sender {
    
    btn.userInteractionEnabled=false;
    
    [UIView animateWithDuration:DURATION_SHOW_USER_GALLERY_IMAGE animations:^{
        btn.alpha=0.0f;
        bg.alpha=0;
        grid.alpha=0;
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
            if(!_isAllowDescription)
            {
            }
        }
    }
}

-(NSUInteger)currentIndex
{
    return grid.currentPage;
}

-(void)setAllowLoadMore:(bool)isAllowLoadMore
{
    _isAllowLoadMore=isAllowLoadMore;
}

-(void)setPage:(int)page
{
    _page=page;
}

@end

@implementation GalleryItem
@synthesize imageDescription,imageURL,image;

@end

@implementation GalleryGridView

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UITapGestureRecognizer class]])
        return true;
    
    return false;
}

@end

@implementation GalleryGridCell

@end

@implementation GalleryLayoutStragery

- (NSRange)rangeOfPositionsInBoundsFromOffset:(CGPoint)offset
{
    CGPoint contentOffset = CGPointMake(MAX(0, offset.x),
                                        MAX(0, offset.y));
    
    NSInteger page = floor(contentOffset.x / self.gridBounds.size.width);
    
    NSInteger firstPosition = MAX(0, (page) * self.numberOfItemsPerPage);
    NSInteger lastPosition  = MIN(firstPosition + 2 * self.numberOfItemsPerPage, self.itemCount);
    
    return NSMakeRange(firstPosition, (lastPosition - firstPosition));
}

@end