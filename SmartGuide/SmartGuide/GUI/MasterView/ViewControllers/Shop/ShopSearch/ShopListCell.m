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

-(void)loadWithShopList:(ShopList *)shopList
{
    _shop=shopList;
    imgvVoucher.highlighted=rand()%2==0;

    [self makeScrollSize];
    
    imgvHeartAni.hidden=true;
    imgvHeartAni.transform=CGAffineTransformMakeScale(1, 1);
    
    lblName.text=shopList.shopName;
    lblAddress.text=shopList.address;
    lblContent.text=shopList.desc;
}

-(void) makeScrollSize
{
    scroll.contentOffset=CGPointZero;
    scroll.contentSize=CGSizeMake(scroll.l_v_w+1, 0);
}

+(NSString *)reuseIdentifier
{
    return @"ShopListCell";
}

+(float)heightWithContent:(NSString *)content
{
    float height=[content sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(249, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height+10;
    
    if(height>45)
        height=45;
    
    return height+44;
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

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [scroll.panGestureRecognizer addTarget:self action:@selector(panGes:)];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes:)];
    tap.delegate=self;
    
    [scroll addGestureRecognizer:tap];
    
    [scroll.panGestureRecognizer requireGestureRecognizerToFail:tap];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(scroll.contentOffset.x>5)
    {
        return false;
    }
    
    return true;
}

-(void) tapGes:(UITapGestureRecognizer*) tap
{
    [self.delegate shopListCellTouched:_shop];
}

-(void) panGes:(UIPanGestureRecognizer*) pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
            
            if(scroll.contentOffset.x>rightView.l_v_w/2)
            {
                scroll.contentInset=UIEdgeInsetsMake(0, 0, 0, rightView.l_v_w);
                [scroll setContentOffset:CGPointMake(rightView.l_v_w, 0) animated:true];
            }
            else
            {
                [scroll setContentOffsetX:CGPointZero animated:true completed:^{
                    //scroll.contentInset=UIEdgeInsetsZero;
                }];
            }
            
            break;
            
        default:
            break;
    }
}

@end

@implementation ScrollListCell

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

@end