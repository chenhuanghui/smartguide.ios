//
//  IntroView.m
//  SmartGuide
//
//  Created by XXX on 8/28/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "IntroView.h"
#import "Utility.h"

@implementation IntroView
@synthesize delegate;

- (id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:NIB_PHONE(@"IntroView") owner:nil options:nil] objectAtIndex:0];
    
    grid.minEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 0);
    grid.layoutStrategy=[GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutHorizontalPagedLTR];
    grid.itemSpacing=0;
    grid.style=GMGridViewStylePush;
    grid.dataSource=self;

    return self;
}

-(NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return [self source].count;
}

-(CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return gridView.frame.size;
}

-(GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    
    if(!cell)
    {
        cell=[[GMGridViewCell alloc] init];
        UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, gridView.frame.size.width, gridView.frame.size.height)];
        imgv.contentMode=UIViewContentModeScaleAspectFill;
        cell.contentView=imgv;
    }
    
    UIImageView *imgv=(UIImageView*)cell.contentView;
    
    [imgv setImage:[UIImage imageNamed:[[self source] objectAtIndex:index]]];
    
    return cell;
}

-(NSArray*) source
{
    return @[@"intro_1.png",@"intro_2.png",@"intro_3.png",@"intro_4.png",@"intro_5.png",@"intro_6.png"];
}

- (IBAction)btnTouchUpInside:(id)sender {
    self.userInteractionEnabled=false;
    [delegate introViewClose:self];
}


@end
