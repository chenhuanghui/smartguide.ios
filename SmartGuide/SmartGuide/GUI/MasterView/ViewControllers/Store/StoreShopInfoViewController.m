//
//  StoreShopInfoViewController.m
//  SmartGuide
//
//  Created by MacMini on 09/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "StoreShopInfoViewController.h"
#import "StoreViewController.h"
#import "ImageManager.h"

#define STORE_RAY_MIN_Y 70.f
#define STORE_NAME_BOTTOM_MIN_Y 7

@interface StoreShopInfoViewController ()

@end

@implementation StoreShopInfoViewController
@synthesize storeController;

-(StoreShopInfoViewController *)initWithStore:(StoreShop *)store
{
    self = [super initWithNibName:@"StoreShopInfoViewController" bundle:nil];
    if (self) {
        // Custom initialization
        
        _store=store;
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    
    itemLatest=[StoreItemListController new];
    itemTopSellers=[StoreItemListController new];
}

-(void) storeRect
{
    _lblNameBotFrame=lblNameBot.frame;
    _gridContainerFrame=gridContainer.frame;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _itemLastest=[_store.latestItemsObjects mutableCopy];
    _itemTopSellers=[_store.topSellerItemsObjects mutableCopy];
    
    NSLog(@"%i %i",_itemLastest.count,_itemTopSellers.count);
    
    _canLoadMoreLatest=_itemTopSellers.count==10;
    _canLoadMoreTopSellers=_itemTopSellers.count==10;
    
    [imgvShopLogo loadStoreLogoWithURL:_store.logo];
    lblShopName.text=_store.shopName;
    lblShopType.text=_store.shopType;
    lblShopDesc.text=_store.desc;
    lblNameBot.text=_store.shopName;
    
    [itemLatest view];
    [itemTopSellers view];
    
    SGNavigationController *navi=[[SGNavigationController alloc] initWithRootViewController:itemLatest];
    
    itemNavi=navi;
    
    [gridContainer l_v_setH:self.l_v_h-storeController.rayViewFrame.size.height];
    
    [self addChildViewController:navi];
    [gridContainer addSubview:navi.view];
    [navi l_v_setS:gridContainer.l_v_s];
    
    gridLatest=itemLatest.gridView;
    gridTopSellers=itemTopSellers.gridView;
    
    [self storeRect];
    
    scroll.minimumOffsetY=-storeController.rayViewFrame.size.height+12;
    
    gridLatest.dataSource=self;
    gridLatest.actionDelegate=self;
    gridLatest.delegate=self;
    gridTopSellers.dataSource=self;
    gridTopSellers.actionDelegate=self;
    gridTopSellers.delegate=self;
    
    [self makeScrollSize];
//    [scroll pauseView:self.storeController.rayView minY:STORE_RAY_MIN_Y];
//    [scroll pauseView:gridContainer minY:self.storeController.rayViewFrame.origin.y-STORE_RAY_MIN_Y-8];
//    [scroll followView:self.storeController.rayView];
//    //    [scroll pauseView:grid minY:self.storeController.rayViewFrame.origin.y-STORE_RAY_MIN_Y-8];
//    [scroll pauseView:lblNameBot minY:7];
}

-(void) makeScrollSize
{
    GMGridView *grid=[self currentGrid];
    
    float height=_gridContainerFrame.origin.y+[grid.layoutStrategy contentSize].height/2;
    
    height=MAX(scroll.l_v_h+1,height);
    
    [scroll l_cs_setH:height];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(GMGridView*) currentGrid
{
    return self.storeController.sortType==SORT_STORE_SHOP_LIST_LATEST?gridLatest:gridTopSellers;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView==scroll)
    {
        if(scrollView.l_co_y<0)
        {
//            [grid l_v_setY:_gridFrame.origin.y+scroll.l_co_y];
//            [grid l_co_setY:scroll.l_co_y];
            
            [gridContainer l_v_setY:_gridContainerFrame.origin.y];
            [[self currentGrid] l_co_setY:0];
            
            [lblNameBot l_v_setY:_lblNameBotFrame.origin.y];
            
            [self.storeController.rayView l_v_setY:self.storeController.rayViewFrame.origin.y-scrollView.l_co_y];
            [self.storeController.bgView l_v_setH:self.storeController.bgViewFrame.size.height-scrollView.l_co_y];
            [self.storeController.bgImageView l_v_setY:scrollView.contentOffset.y/6];
        }
        else
        {
            self.storeController.qrView.alpha=0.3f;
            
            float y=self.storeController.rayViewFrame.origin.y-scrollView.l_co_y;
            
            y=MAX(y,STORE_RAY_MIN_Y);
            [self.storeController.rayView l_v_setY:y];
            
            y=_gridContainerFrame.origin.y-scrollView.l_co_y;
            float diff=self.storeController.rayViewFrame.origin.y-STORE_RAY_MIN_Y;
            
            if(y<_gridContainerFrame.origin.y-diff)
            {
                y=_gridContainerFrame.origin.y+scrollView.l_co_y-diff;
                
                [gridLatest l_co_setY:y-_gridContainerFrame.origin.y];
            }
            else
            {
                y=_gridContainerFrame.origin.y;
                
                [gridLatest l_co_setY:0];
            }
            
            [gridContainer l_v_setY:y];
            
            y=_lblNameBotFrame.origin.y-scroll.l_co_y;
            
            if(y<STORE_NAME_BOTTOM_MIN_Y)
            {
                y=_lblNameBotFrame.origin.y+scrollView.l_co_y-(_lblNameBotFrame.origin.y-STORE_NAME_BOTTOM_MIN_Y);
            }
            else
                y=_lblNameBotFrame.origin.y;
            
            [lblNameBot l_v_setY:y];
            
            y=self.storeController.bgImageViewFrame.origin.y-scrollView.l_co_y/6;
            y=MAX(y,-STORE_RAY_MIN_Y);
            [self.storeController.bgImageView l_v_setY:y];
            [self.storeController.bgView l_v_setH:self.storeController.bgViewFrame.size.height];
        }
    }
}

-(void) requestStoresWithType:(enum SORT_STORE_SHOP_LIST_TYPE) sort
{
    return;
    switch (sort) {
        case SORT_STORE_SHOP_LIST_LATEST:
        {
            if(_operationItemLatest)
                return;
            
            _operationItemLatest=[[ASIOperationStoreShopItem alloc] initWithIDShop:_store.idShop page:_pageShopLatest+1 userLat:userLat() userLng:userLng() sort:SORT_STORE_SHOP_LIST_LATEST];
            _operationItemLatest.delegatePost=self;
            
            [_operationItemLatest startAsynchronous];
        }
            break;
            
        case SORT_STORE_SHOP_LIST_TOP_SELLER:
        {
            if(_operationItemTopSellers)
                return;
            
            _operationItemTopSellers=[[ASIOperationStoreShopItem alloc] initWithIDShop:_store.idShop page:_pageShopTopSellers+1 userLat:userLat() userLng:userLng() sort:SORT_STORE_SHOP_LIST_TOP_SELLER];
            _operationItemTopSellers.delegatePost=self;
            
            [_operationItemTopSellers startAsynchronous];
        }
            break;
    }
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationStoreShopItem class]])
    {
        ASIOperationStoreShopItem *ope=(ASIOperationStoreShopItem*)operation;
        
        switch (ope.sortType) {
            case SORT_STORE_SHOP_LIST_TOP_SELLER:
            {
                [_itemTopSellers addObjectsFromArray:ope.items];
                _canLoadMoreTopSellers=ope.items.count==10;
                _pageShopTopSellers++;
                
                [gridTopSellers reloadData];
                
                _operationItemTopSellers=nil;
            }
                break;
                
            case SORT_STORE_SHOP_LIST_LATEST:
            {
                [_itemLastest addObjectsFromArray:ope.items];
                _canLoadMoreLatest=ope.items.count==10;
                _pageShopLatest++;
                
                [gridLatest reloadData];
                
                _operationItemLatest=nil;
            }
                break;
        }

    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationStoreShopItem class]])
    {
        ASIOperationStoreShopItem *ope=(ASIOperationStoreShopItem*)operation;
        
        switch (ope.sortType) {
            case SORT_STORE_SHOP_LIST_TOP_SELLER:
                _operationItemTopSellers=nil;
                _canLoadMoreTopSellers=false;
                
                [gridTopSellers reloadData];
                
                break;
                
            case SORT_STORE_SHOP_LIST_LATEST:
                _operationItemLatest=nil;
                _canLoadMoreLatest=false;
                
                [gridLatest reloadData];
                
                break;
        }
    }
}

-(NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    if(gridView==gridLatest)
        return _itemLastest.count;
    else if(gridView==gridTopSellers)
        return _itemTopSellers.count;
    
    return 0;
}

-(CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return [StoreShopItemCell size];
}

-(GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    GMGridViewCell *cell=[gridView dequeueReusableCell];
    
    if(!cell)
    {
        cell=[[GMGridViewCell alloc] initWithFrame:CGRectMake(0, 0, [StoreShopItemCell size].width, [StoreShopItemCell size].height)];
        cell.contentView=[StoreShopItemCell new];
    }
    
    StoreShopItemCell *itemCell=(StoreShopItemCell*)cell.contentView;
    StoreShopItem *item=nil;
    bool needRequestLoadMore=false;
    
    bool isLoadingCell=false;
    
    if(gridView==gridLatest)
    {
        if(index<_itemLastest.count)
        {
            item=_itemLastest[index];
            
            if(index==_itemLastest.count-1 && _canLoadMoreLatest)
                needRequestLoadMore=true;
        }
        else if(_canLoadMoreLatest)
        {
            isLoadingCell=true;
            needRequestLoadMore=true;
        }
        
    }
    else if(gridView==gridTopSellers)
    {
        if(index<+_itemTopSellers.count)
        {
            item=_itemTopSellers[index];
            
            if(index==_itemTopSellers.count-1 && _canLoadMoreTopSellers)
                needRequestLoadMore=true;
        }
        else if(_canLoadMoreTopSellers)
        {
            isLoadingCell=true;
            needRequestLoadMore=true;
        }
    }
    
    if(isLoadingCell)
    {
        [itemCell loadingCell];
    }
    else if(item)
        [itemCell loadWithItem:item];
    else
        [itemCell emptyCell];
    
    if(needRequestLoadMore)
    {
        if(gridView==gridTopSellers)
        {
            [self requestStoresWithType:SORT_STORE_SHOP_LIST_TOP_SELLER];
        }
        else if(gridView==gridLatest)
        {
            [self requestStoresWithType:SORT_STORE_SHOP_LIST_LATEST];
        }
    }
    
    return cell;
}

-(void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    
}

-(void)prepareOnBack
{
    [scroll clearFollowViews];
    [scroll clearPauseViews];
}

-(void)storeControllerButtonLatestTouched:(UIButton *)btn
{
    if(itemNavi.viewControllers.count==1)
        return;
    
    int count=1;
    float duration=0.3f;
    [self.storeController disableTouch];
    
    for(int i=gridTopSellers.subviews.count-1;i>=0;i--)
    {
        GMGridViewCell *cell=gridTopSellers.subviews[i];
        
        if([cell isKindOfClass:[GMGridViewCell class]])
        {
            [UIView animateWithDuration:duration*count animations:^{
                cell.alpha=0;
            }];
            
            count++;
        }
    }
    
    count--;
    double delayInSeconds = count*duration-duration*3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [itemNavi popToRootViewControllerAnimated:false];
        
        int count=1;
        for(GMGridViewCell *cell in gridLatest.subviews)
        {
            if([cell isKindOfClass:[GMGridViewCell class]])
            {
                cell.alpha=0;
                [UIView animateWithDuration:duration*count animations:^{
                    cell.alpha=1;
                }];
                
                count++;
            }
        }
        
        count--;
        double delayInSeconds = count*duration-duration*2;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.storeController enableTouch];
        });
    });
}

-(void)storeControllerButtonTopSellersTouched:(UIButton *)btn
{
    if(![itemNavi.viewControllers containsObject:itemTopSellers])
    {
        [self.storeController disableTouch];
        
        int count=1;
        float duration=0.3f;
        for(GMGridViewCell *cell in gridLatest.subviews)
        {
            if([cell isKindOfClass:[GMGridViewCell class]])
            {
                [UIView animateWithDuration:duration*count animations:^{
                    cell.alpha=0;
                }];
                
                count++;
            }
        }
        
        count--;
        double delayInSeconds = count*duration-duration*3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [itemNavi pushViewController:itemTopSellers animated:false];
            
            int count=1;
            for(int i=gridTopSellers.subviews.count-1;i>=0;i--)
            {
                GMGridViewCell *cell=gridTopSellers.subviews[i];
                if([cell isKindOfClass:[GMGridViewCell class]])
                {
                    cell.alpha=0;
                    [UIView animateWithDuration:duration*count animations:^{
                        cell.alpha=1;
                    }];
                    
                    count++;
                }
            }
            
            count--;
            double delayInSeconds = count*duration-duration*2;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self.storeController enableTouch];
            });
        });
    }
}


@end

@implementation StoreShopInfoScrollView

@end

@implementation StoreItemListController

-(void)loadView
{
    [super loadView];
    
    self.view.autoresizingMask=UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
    
    GMGridView *gv=[[GMGridView alloc] initWithFrame:CGRectMake(0, 0, self.l_v_w, self.l_v_h)];
    gv.autoresizingMask=UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
    
    gv.style=GMGridViewStylePush;
    gv.layoutStrategy=[GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutVertical];
    gv.itemSpacing=0;
    gv.centerGrid=false;
    gv.minEdgeInsets=UIEdgeInsetsZero;
    gv.layer.masksToBounds=true;
    gv.backgroundColor=[UIColor clearColor];
    gv.scrollEnabled=false;
    
    grid=gv;
    
    [self.view addSubview:gv];
    self.view.backgroundColor=[UIColor clearColor];
}

-(GMGridView *)gridView
{
    return grid;
}

@end