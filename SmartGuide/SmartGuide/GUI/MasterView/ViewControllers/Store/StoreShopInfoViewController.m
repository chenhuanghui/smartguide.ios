//
//  StoreShopInfoViewController.m
//  SmartGuide
//
//  Created by MacMini on 09/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "StoreShopInfoViewController.h"
#import "StoreViewController.h"

#define STORE_RAY_MIN_Y 70.f

@interface StoreShopInfoViewController ()

@end

@implementation StoreShopInfoViewController
@synthesize storeController;

- (id)init
{
    self = [super initWithNibName:@"StoreShopInfoViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) storeRect
{
    _gridFrame=grid.frame;
    _lblNameBotFrame=lblNameBot.frame;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self storeRect];
    
    grid.layoutStrategy=[GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutVertical];
    grid.style=GMGridViewStylePush;
    grid.itemSpacing=0;
    grid.centerGrid=false;
    grid.minEdgeInsets=UIEdgeInsetsZero;
    grid.layer.masksToBounds=true;
    grid.clipsToBounds=true;
    
    grid.actionDelegate=self;
    grid.dataSource=self;
    
    [scroll l_cs_setH:grid.l_v_y+grid.l_cs_h];
    
    [grid l_v_setH:grid.l_cs_h];
    
    [scroll pauseView:self.storeController.rayView minY:STORE_RAY_MIN_Y];
    [scroll followView:self.storeController.rayView];
    [scroll pauseView:grid minY:self.storeController.rayViewFrame.origin.y-STORE_RAY_MIN_Y-8];
    [scroll pauseView:lblNameBot minY:7];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView==scroll)
    {
        if(scrollView.l_co_y<0)
        {
            [grid l_v_setY:_gridFrame.origin.y+scroll.l_co_y];
            [grid l_co_setY:scroll.l_co_y];
            
            [lblNameBot l_v_setY:_lblNameBotFrame.origin.y];
            
            [self.storeController.rayView l_v_setY:self.storeController.rayViewFrame.origin.y-scrollView.l_co_y];
            [self.storeController.bgView l_v_setH:self.storeController.bgViewFrame.size.height-scrollView.l_co_y];
            [self.storeController.bgImageView l_v_setY:scroll.contentOffset.y/6];
        }
        else
        {
            return;
            float y=self.storeController.rayViewFrame.origin.y-scroll.l_co_y;
            
            if(y<=STORE_RAY_MIN_Y)
            {
                [grid l_v_setY:_gridFrame.origin.y+STORE_RAY_MIN_Y-y];
                [grid l_co_setY:scroll.l_co_y-self.storeController.rayViewFrame.origin.y+STORE_RAY_MIN_Y];
            }
            
            y=MAX(STORE_RAY_MIN_Y, y);
            
            [self.storeController.rayView l_v_setY:y];
            
            y=_lblNameBotFrame.origin.y-scroll.l_co_y;
            
            if(y<7)
            {
                [lblNameBot l_v_setY:scroll.l_co_y+7];
            }
        }
    }
}

-(NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return 10;
}

-(GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    GMGridViewCell *cell=[gridView dequeueReusableCell];
    
    if(!cell)
    {
        cell=[[GMGridViewCell alloc] initWithFrame:CGRectMake(0, 0, [StoreShopItemCell size].width, [StoreShopItemCell size].height)];
        cell.contentView=[StoreShopItemCell new];
    }
    
    return cell;
}

-(CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return [StoreShopItemCell size];
}

-(void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    
}

-(void)prepareOnBack
{
    [scroll clearFollowViews];
    [scroll clearPauseViews];
}

@end

@implementation StoreShopInfoScrollView

@end