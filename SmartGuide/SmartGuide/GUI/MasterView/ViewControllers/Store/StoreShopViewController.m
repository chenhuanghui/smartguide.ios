//
//  StoreShopViewController.m
//  SmartGuide
//
//  Created by MacMini on 08/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "StoreShopViewController.h"
#import "StoreTopAdsCell.h"
#import "StoreShopCell.h"
#import "StoreViewController.h"

@interface StoreShopViewController ()

@end

@implementation StoreShopViewController
@synthesize storeController,delegate;

- (id)init
{
    self = [super initWithNibName:@"StoreShopViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) storeRect
{
    _tableAdsFrame=tableAds.frame;
    _tableShopFrame=tableShop.frame;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _shops=[[NSMutableArray alloc] init];
    
    for(int i=0;i<1;i++)
    {
        [_shops addObject:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."];
    }
    
    scroll.minContentOffsetY=-80;
    
    CGRect rect=tableAds.frame;
    tableAds.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*6);
    tableAds.frame=rect;
    
    [tableAds registerNib:[UINib nibWithNibName:[StoreTopAdsCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[StoreTopAdsCell reuseIdentifier]];
    
    tableAds.dataSource=self;
    tableAds.delegate=self;
    
    [tableAds reloadData];
    
//    [tableShop registerNib:[UINib nibWithNibName:[StoreShopCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[StoreShopCell reuseIdentifier]];
//
    GMGridViewLayoutVerticalStrategy *ver=[GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutVertical];
    
    tableShop.style=GMGridViewStylePush;
    tableShop.layoutStrategy=ver;
    tableShop.itemSpacing=0;
    tableShop.centerGrid=false;
    tableShop.minEdgeInsets=UIEdgeInsetsZero;
    tableShop.layer.masksToBounds=true;
    
    tableShop.actionDelegate=self;
    tableShop.dataSource=self;
    
    [self storeRect];
    
    [scroll l_cs_setH:tableShop.l_v_y+tableShop.l_cs_h];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapShop:)];
    
    [scroll addGestureRecognizer:tap];
    [scroll.panGestureRecognizer requireGestureRecognizerToFail:tap];
}

-(void) tapShop:(UITapGestureRecognizer*) tap
{
//    CGPoint pnt=[tap locationInView:tableShop];
    [tableShop tapGestureUpdated:tap];
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
            [tableShop l_v_setY:_tableShopFrame.origin.y+scroll.l_co_y];
            [tableShop l_co_setY:scroll.l_co_y];
            
            [tableAds l_v_setY:scroll.contentOffset.y/4];
            [self.storeController.rayView l_v_setY:self.storeController.rayViewFrame.origin.y-scrollView.l_co_y];
            [self.storeController.bgView l_v_setH:self.storeController.bgViewFrame.size.height-scrollView.l_co_y];
            [self.storeController.bgImageView l_v_setY:scroll.contentOffset.y/6];
        }
        else
        {
            [self.storeController.rayView l_v_setY:self.storeController.rayViewFrame.origin.y];
            [self.storeController.bgView l_v_setH:self.storeController.bgViewFrame.size.height];
            
            [tableAds l_v_setY:_tableAdsFrame.origin.y+scroll.l_co_y];
            
            [tableShop l_v_setY:_tableShopFrame.origin.y+scroll.l_co_y];
            [tableShop l_co_setY:scroll.l_co_y];
        }
    }
    else if(scrollView==tableAds)
    {
        float x=MIN(0, -tableAds.contentOffset.y/8);
        
        [self.storeController.bgImageView l_v_setX:x];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableAds)
        return 10;
    else
        return 3;
}

-(NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return _shops.count<4?4:_shops.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tableAds)
        return tableView.l_v_w;

    return 0;
}


-(CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return [StoreShopCell smallSize];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tableAds)
    {
        StoreTopAdsCell *cell=[tableView dequeueReusableCellWithIdentifier:[StoreTopAdsCell reuseIdentifier]];
        
        return cell;
    }
    
    return nil;
}

-(GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    GMGridViewCell *cell=[gridView dequeueReusableCell];
    if(!cell)
    {
        cell=[[GMGridViewCell alloc] initWithFrame:CGRectMake(0, 0, 163, 131)];
        cell.contentView=[StoreShopCell new];
    }
    
    StoreShopCell *shopCell=(StoreShopCell*)cell.contentView;
    
    [shopCell emptyCell:index>=_shops.count];
    
    return cell;
}

-(void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    [self.delegate storeShopControllerTouchedShop:self];
}

@end

@implementation StoreShopScrollView
@synthesize minContentOffsetY;

-(void)setContentOffset:(CGPoint)contentOffset
{
    if(minContentOffsetY!=-1)
    {
        if(contentOffset.y<=minContentOffsetY)
            contentOffset.y=minContentOffsetY;
    }
    
    _offset.x=contentOffset.x-self.contentOffset.x;
    _offset.y=contentOffset.y-self.contentOffset.y;
    
    [super setContentOffset:contentOffset];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return true;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return true;
}

-(CGPoint)offset
{
    return _offset;
}

@end

@implementation StoreShopTableAds

-(void)setContentOffset:(CGPoint)contentOffset
{
    _offset.x=contentOffset.x-self.contentOffset.x;
    _offset.y=contentOffset.y-self.contentOffset.y;
    
    [super setContentOffset:contentOffset];
}

-(CGPoint)offset
{
    return _offset;
}

@end