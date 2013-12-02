//
//  ShopListCell.m
//  SmartGuide
//
//  Created by MacMini on 15/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopListCell.h"
#import "Utility.h"
#import "Constant.h"

@implementation ShopListCell
@synthesize delegate;

-(void)loadContent
{
    imgvVoucher.highlighted=rand()%2==0;
    
    scroll.contentOffset=CGPointZero;
    scroll.contentSize=CGSizeMake(self.frame.size.width+slideView.frame.size.width, 0);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.1f animations:^{
        [visibleView l_v_setW:MIN(320, 320-scroll.contentOffset.x)];
    }];
}

+(NSString *)reuseIdentifier
{
    return @"ShopListCell";
}

-(void)prepareForReuse
{
    [super prepareForReuse];
}

-(void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    scroll.contentOffset=CGPointZero;
    scroll.contentSize=CGSizeMake(self.frame.size.width+slideView.frame.size.width, 0);
    
    
    tapGes.delegate=nil;
    [tapGes removeTarget:self action:@selector(panGes:)];
    [scroll removeGestureRecognizer:tapGes];
    tapGes=nil;
    
    UITapGestureRecognizer *pan=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:)];
    tapGes=pan;
    
    [scroll.panGestureRecognizer requireGestureRecognizerToFail:pan];
    [scroll addGestureRecognizer:pan];
}

-(void) panGes:(UIPanGestureRecognizer*) pan
{
    [self.delegate shopListCellTouched:self];
}

+(float)height
{
    return 55;
}

- (IBAction)btnLoveTouchUpInside:(id)sender {
    [scroll setContentOffset:CGPointZero animated:true];
    NSLog(@"love");
}

- (IBAction)btnShareTouchUpInside:(id)sender {
    [scroll setContentOffset:CGPointZero animated:true];
    NSLog(@"share");
}

@end

@implementation ScrollListCell
@synthesize offset;

-(void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    if(self.superview)
    {
        self.panGestureRecognizer.delegate=self;
    }
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer==self.panGestureRecognizer)
    {
        CGPoint velocity=[self.panGestureRecognizer velocityInView:self.panGestureRecognizer.view];
        
        return fabsf(velocity.x)>fabsf(velocity.y);
    }
    
    return true;
}

-(void)setContentOffset:(CGPoint)contentOffset
{
    offset=CGPointMake(contentOffset.x-self.contentOffset.x, contentOffset.y-self.contentOffset.y);
    
    [super setContentOffset:contentOffset];
}

@end