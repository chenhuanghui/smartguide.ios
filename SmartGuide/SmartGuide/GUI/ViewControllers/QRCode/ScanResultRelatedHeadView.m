//
//  ScanResultRelatedHeadView.m
//  Infory
//
//  Created by XXX on 7/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultRelatedHeadView.h"
#import "PeekTitleView.h"
#import "Utility.h"

@interface ScanResultRelatedHeadView()<PeekTitleViewDelegate>

@end

@implementation ScanResultRelatedHeadView

- (instancetype)init
{
    self = [[NSBundle mainBundle] loadNibNamed:@"ScanResultRelatedHeadView" owner:nil options:nil][0];
    if (self) {
        PeekTitleView *peek=[PeekTitleView new];
        peek.frame=CGRectMake(20, 0, titlesView.l_v_w-40, titlesView.l_v_h);
        peek.delegate=self;
        
        [titlesView addSubview:peek];
        
        peekTitle=peek;
    }
    return self;
}

-(void)loadWithTitles:(NSArray *)titles
{
    if(titles.count==0)
    {
        imgvLineBot.hidden=true;
        peekTitle.hidden=true;
    }
    else
    {
        imgvLineBot.hidden=false;
        peekTitle.hidden=false;
        [peekTitle addTitles:titles];
    }
}

-(void)peekTitleView:(PeekTitleView *)peekView touchedIndex:(int)index
{
    [self.delegate scanResultRelatedHeadView:self selectedIndex:index];
}

-(void)setTitleIndex:(int)index animate:(bool)animate
{
    [peekTitle setTitleIndex:index animate:animate];
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view=[super hitTest:point withEvent:event];
    
    return view;
}

+(float)height
{
    return 67;
}

+(float)heightEmptyTitles
{
    return 29;
}

@end
