//
//  ShopListCell.m
//  SmartGuide
//
//  Created by MacMini on 15/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopSearchCell.h"
#import "Utility.h"
#import "Constant.h"

@implementation ShopSearchCell
@synthesize delegate;

-(void)loadContent
{
    imgvVoucher.highlighted=rand()%2==0;
    
    scroll.contentOffset=CGPointZero;
    scroll.contentSize=CGSizeMake(scroll.l_v_w+imgvLine.l_v_x+5, 0);
    imgvHeartAni.hidden=true;
    imgvHeartAni.transform=CGAffineTransformMakeScale(1, 1);
}

+(NSString *)reuseIdentifier
{
    return @"ShopSearchCell";
}

-(void)prepareForReuse
{
    [super prepareForReuse];
}

-(void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    scroll.contentOffset=CGPointZero;
    scroll.contentSize=CGSizeMake(scroll.l_v_w+imgvLine.l_v_x+5, 0);
    
    tapGes.delegate=nil;
    [tapGes removeTarget:self action:@selector(panGes:)];
    [scroll removeGestureRecognizer:tapGes];
    tapGes=nil;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes:)];
    tapGes=tap;
    
    [scroll.panGestureRecognizer requireGestureRecognizerToFail:tap];
    [scroll addGestureRecognizer:tap];
}

-(void) tapGes:(UIPanGestureRecognizer*) tap
{
    if(scroll.l_co_x<=5)
        [self.delegate shopListCellTouched:self];
}

+(float)height
{
    return 88;
}

- (IBAction)btnLoveTouchUpInside:(id)sender {
    
    imgvHeartAni.alpha=0;
    imgvHeartAni.hidden=false;
    [UIView animateWithDuration:0.3f animations:^{
        imgvHeartAni.alpha=1;
        imgvHeartAni.transform=CGAffineTransformMakeScale(4, 4);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3f animations:^{
        imgvHeartAni.transform=CGAffineTransformMakeScale(1.5f, 1.5f);
        } completion:^(BOOL finished) {
            imgvHeartAni.hidden=true;
            
            [scroll setContentOffset:CGPointZero animated:true];
        }];
    }];
}

- (IBAction)btnAddTouchUpInside:(id)sender {
    [scroll setContentOffset:CGPointZero animated:true];
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