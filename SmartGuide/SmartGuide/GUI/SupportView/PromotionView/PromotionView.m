//
//  PromotionView.m
//  SmartGuide
//
//  Created by XXX on 7/16/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "PromotionView.h"
#import "PointBar.h"
#import "GMGridViewLayoutStrategies.h"
#import <QuartzCore/QuartzCore.h>
#import "Utility.h"
#import "PromotionDetail.h"
#import "PromotionRequire.h"

@implementation PromotionView

-(PromotionView *)initWithShop:(Shop *)shop
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"PromotionView" owner:nil options:nil] objectAtIndex:0];
  
    [self setting];
    
    [self setShop:shop];
    
    return self;
}

-(id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    self=[super awakeAfterUsingCoder:aDecoder];
    
    if(self.subviews.count==0)
    {
        CGRect rect=self.frame;
        
        self=[[[NSBundle mainBundle] loadNibNamed:@"PromotionView" owner:nil options:nil] objectAtIndex:0];
        
        self.frame=rect;
        
        [self setting];
    }
    
    return self;
}

-(void) setting
{
    gridReward.itemSpacing=5;
    gridReward.style=GMGridViewStylePush;
    gridReward.minEdgeInsets=UIEdgeInsetsMake(5, 5, 5, 5);
    gridReward.centerGrid=false;
    gridReward.layoutStrategy=[GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutVertical];
    gridReward.showsHorizontalScrollIndicator=false;
    gridReward.showsVerticalScrollIndicator=false;
    gridReward.layer.masksToBounds=true;
}

-(void)setShop:(Shop *)shop
{
    _shop=shop;
    
    [gridReward reloadData];
}

-(NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return _shop.promotionDetail.requiresObjects.count;
}

-(GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    GMGridViewCell *cell=[gridView dequeueReusableCell];
    PromotionRequire *shopPoint=[_shop.promotionDetail.requiresObjects objectAtIndex:index];
    PointBar *pointBar=nil;
    
    if(!cell)
    {
        CGRect rect=CGRectZero;
        rect.size=[PointBar size];
        
        cell=[[GMGridViewCell alloc] initWithFrame:rect];
        
        pointBar=[[PointBar alloc] initWithPoint:shopPoint];
        cell.contentView=pointBar;
    }
    else
    {
        pointBar=(PointBar*)cell.contentView;
        [pointBar setPoint:shopPoint];
    }
    
    [pointBar setHighlight:[_shop.ranks containsObject:shopPoint]];
    
    return cell;
}

-(CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return [PointBar size];
}

-(void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    PromotionRequire *shopPoint=[_shop.promotionDetail.requiresObjects objectAtIndex:position];
    
    [[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%i %@",(int)shopPoint.sgpRequired.doubleValue,shopPoint.content] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    self.layer.cornerRadius=8;
    CGRect rect=lblCurrentPoint.frame;
    rect.size.width=self.frame.size.width;
    lblCurrentPoint.frame=rect;
    
    rect.size.height=lblPoint.frame.size.height;
    rect.origin.y=lblCurrentPoint.frame.size.height+lblCurrentPoint.frame.origin.y;
    lblPoint.frame=rect;
    
    rect.origin.x=gridReward.frame.origin.x;
    rect.origin.y=lblPoint.frame.size.height+lblPoint.frame.origin.y;
    rect.size.height=self.frame.size.height-lblPoint.frame.origin.y-lblPoint.frame.size.height;
    gridReward.frame=rect;
    
    [super willMoveToSuperview:newSuperview];
}

@end
