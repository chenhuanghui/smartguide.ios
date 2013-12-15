//
//  StoreShopViewController.m
//  SmartGuide
//
//  Created by MacMini on 08/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "StoreShopViewController.h"
#import "StoreAdsCell.h"
#import "StoreShopCell.h"
#import "StoreViewController.h"

#define STORE_NUMBER_OF_ITEM_IN_GRID 4

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
    _gridContainerFrame=gridContainer.frame;
    _gridLatestFrame=gridLatest.frame;
    _gridTopFrame=gridTopSellers.frame;
}

-(void)loadView
{
    [super loadView];
    
    shopLatest=[StoreShopListController new];
    shopTopSellers=[StoreShopListController new];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _willReloadGridLatest=false;
    _willReloadGridTopSellers=false;
    
    [shopLatest view];
    [shopTopSellers view];
    
    shopLatest.view.backgroundColor=[UIColor color255WithRed:235 green:235 blue:235 alpha:255];
    shopTopSellers.view.backgroundColor=[UIColor color255WithRed:235 green:235 blue:235 alpha:255];
    
    gridLatest=[shopLatest gridView];
    gridTopSellers=[shopTopSellers gridView];
    
    gridLatest.backgroundColor=[UIColor clearColor];
    gridTopSellers.backgroundColor=[UIColor clearColor];
    
    SGNavigationController *naviShop=[[SGNavigationController alloc] initWithRootViewController:shopLatest];
    shopNavi=naviShop;
    
    [self addChildViewController:shopNavi];
    
    [gridContainer addSubview:shopNavi.view];
    [shopNavi l_v_setS:gridContainer.l_v_s];
    
    _shopsLatest=[[NSMutableArray alloc] init];
    _shopsTopSellers=[[NSMutableArray alloc] init];
    
    //    scroll.minContentOffsetY=-80;
    
    CGRect rect=tableAds.frame;
    tableAds.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*6);
    tableAds.frame=rect;
    
    [tableAds registerNib:[UINib nibWithNibName:[StoreAdsCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[StoreAdsCell reuseIdentifier]];
    
    tableAds.dataSource=self;
    tableAds.delegate=self;
    
    [tableAds reloadData];
    
    [self storeRect];
    
    [self requestAllStore];
    
    gridTopSellers.delegate=self;
    gridLatest.delegate=self;
    gridTopSellers.actionDelegate=self;
    gridLatest.actionDelegate=self;
    
    _pageShopLatest=0;
    _pageShopTopSellers=0;
    
    gridTopSellers.minimumOffsetY=-storeController.rayViewFrame.size.height+12;
    gridLatest.minimumOffsetY=-storeController.rayViewFrame.size.height+12;
    
    [gridTopSellers.panGestureRecognizer addTarget:self action:@selector(gridTopSellersPanGes:)];
    [gridLatest.panGestureRecognizer addTarget:self action:@selector(gridLatestPanGes:)];
}

-(void) gridTopSellersPanGes:(UIPanGestureRecognizer*) pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            if(_willReloadGridTopSellers)
            {
                _willReloadGridTopSellers=false;
                [gridTopSellers reloadData];
            }
            break;
            
        default:
            break;
    }
}

-(void) gridLatestPanGes:(UIPanGestureRecognizer*) pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            if(_willReloadGridLatest)
            {
                _willReloadGridLatest=false;
                [gridLatest reloadData];
            }
            break;
            
        default:
            break;
    }
}

-(void) requestStoresWithType:(enum SORT_STORE_SHOP_LIST_TYPE) sort
{
    switch (sort) {
        case SORT_STORE_SHOP_LIST_LATEST:
        {
            if(_operationShopsLatest)
                return;
            
            _operationShopsLatest=[[ASIOperationStoreShopList alloc] initWithUserLat:userLat() userLng:userLng() sort:SORT_STORE_SHOP_LIST_LATEST page:_pageShopLatest+1];
            _operationShopsLatest.delegatePost=self;
            
            [_operationShopsLatest startAsynchronous];
        }
            break;
            
        case SORT_STORE_SHOP_LIST_TOP_SELLER:
        {
            if(_operationShopsTopSellers)
                return;
            
            _operationShopsTopSellers=[[ASIOperationStoreShopList alloc] initWithUserLat:userLat() userLng:userLng() sort:SORT_STORE_SHOP_LIST_TOP_SELLER page:_pageShopTopSellers+1];
            _operationShopsTopSellers.delegatePost=self;
            
            [_operationShopsTopSellers startAsynchronous];
        }
            break;
    }
}

-(void) requestAllStore
{
    _canLoadMoreTopSellers=false;
    _canLoadMoreShopLatest=false;
    
    _shopsTopSellers=[[NSMutableArray alloc] init];
    _shopsLatest=[[NSMutableArray alloc] init];
    
    gridLatest.dataSource=self;
    gridTopSellers.dataSource=self;
    
    _operationAllStore=[[ASIOperationStoreAllStore alloc] initWithUserLat:userLat() withUserLng:userLng()];
    _operationAllStore.delegatePost=self;
    
    [_operationAllStore startAsynchronous];
    
    [shopNavi.view showLoading];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationStoreShopList class]])
    {
        ASIOperationStoreShopList *ope=(ASIOperationStoreShopList*) operation;
        
        switch (ope.sortType) {
            case SORT_STORE_SHOP_LIST_TOP_SELLER:
            {
                [_shopsTopSellers addObjectsFromArray:ope.shops];
                _canLoadMoreTopSellers=ope.shops.count==10;
                _pageShopTopSellers++;
                
                [gridTopSellers reloadData];
                
                _operationShopsTopSellers=nil;
            }
                break;
                
            case SORT_STORE_SHOP_LIST_LATEST:
            {
                [_shopsLatest addObjectsFromArray:ope.shops];
                _canLoadMoreShopLatest=ope.shops.count==10;
                _pageShopLatest++;
                
                [gridLatest reloadData];
                
                _operationShopsLatest=nil;
            }
                break;
        }
    }
    else if([operation isKindOfClass:[ASIOperationStoreAllStore class]])
    {
        [shopNavi.view removeLoading];
        
        ASIOperationStoreAllStore *ope=(ASIOperationStoreAllStore*)operation;
        
        [_shopsLatest addObjectsFromArray:ope.shopsLatest];
        [_shopsTopSellers addObjectsFromArray:ope.shopsTopSellers];
        
        _canLoadMoreShopLatest=_shopsLatest.count==10;
        _canLoadMoreTopSellers=_shopsTopSellers.count==10;
        
        [gridLatest reloadData];
        [gridTopSellers reloadData];
        
        _operationAllStore=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    [shopNavi.view removeLoading];
    
    if([operation isKindOfClass:[ASIOperationStoreShopList class]])
    {
        ASIOperationStoreShopList *ope=(ASIOperationStoreShopList*) operation;
        
        switch (ope.sortType) {
            case SORT_STORE_SHOP_LIST_LATEST:
                _operationShopsLatest=nil;
                _canLoadMoreShopLatest=false;
                
                [gridLatest reloadData];
                
                break;
                
            case SORT_STORE_SHOP_LIST_TOP_SELLER:
                _operationShopsTopSellers=nil;
                _canLoadMoreTopSellers=false;
                
                [gridTopSellers reloadData];
                
                break;
        }
    }
    else if([operation isKindOfClass:[ASIOperationStoreAllStore class]])
    {
        _operationAllStore=nil;
    }
}

-(void) tapShop:(UITapGestureRecognizer*) tap
{
    //    CGPoint pnt=[tap locationInView:tableShop];
    //    [tableShop tapGestureUpdated:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView==gridLatest|| scrollView==gridTopSellers)
    {
        if(scrollView.l_co_y<0)
        {
            [self.storeController.rayView l_v_setY:self.storeController.rayViewFrame.origin.y-scrollView.l_co_y];
            [self.storeController.bgView l_v_setH:self.storeController.bgViewFrame.size.height-scrollView.l_co_y];
            [self.storeController.bgImageView l_v_setY:scrollView.contentOffset.y/6];
        }
        else
        {
            [self.storeController.rayView l_v_setY:self.storeController.rayViewFrame.origin.y];
            [self.storeController.bgView l_v_setH:self.storeController.bgViewFrame.size.height];
            [self.storeController.bgImageView l_v_setY:self.storeController.bgImageViewFrame.origin.y];
            
            [tableAds l_v_setY:_tableAdsFrame.origin.y];
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
    int count=0;
    
    if(gridView==gridLatest)
        count=_shopsLatest.count;
    else if(gridView==gridTopSellers)
        count=_shopsTopSellers.count;
    
    while (count%STORE_NUMBER_OF_ITEM_IN_GRID!=0) {
        count++;
    }
    
    return count;
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
        StoreAdsCell *cell=[tableView dequeueReusableCellWithIdentifier:[StoreAdsCell reuseIdentifier]];
        
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
        cell.backgroundColor=[UIColor clearColor];
        cell.contentView=[StoreShopCell new];
    }
    
    StoreShopCell *shopCell=(StoreShopCell*)cell.contentView;
    StoreShop *store=nil;
    bool needRequestLoadMore=false;
    
    bool isLoadingCell=false;
    
    if(gridView==gridLatest)
    {
        if(index<_shopsLatest.count)
        {
            store=_shopsLatest[index];
            
            if(index==_shopsLatest.count-1 && _canLoadMoreShopLatest)
                needRequestLoadMore=true;
        }
        else if(_canLoadMoreShopLatest)
        {
            isLoadingCell=true;
            needRequestLoadMore=true;
        }
        
    }
    else if(gridView==gridTopSellers)
    {
        if(index<_shopsTopSellers.count)
        {
            store=_shopsTopSellers[index];
            
            if(index==_shopsTopSellers.count-1 && _canLoadMoreTopSellers)
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
        [shopCell loadingCell];
    }
    else
        [shopCell loadWithStore:store];
    
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
    StoreShop *store=nil;
    GMGridViewCell *cell=[gridView cellForItemAtIndex:position];
    StoreShopCell *storeCell=(StoreShopCell*)cell.contentView;
    
    store=storeCell.store;
    
    if(store)
        [self.storeController showShop:store];
}

-(void)storeControllerButtonLatestTouched:(UIButton *)btn
{
    if(shopNavi.viewControllers.count==1)
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
        [shopNavi popToRootViewControllerAnimated:false];
        
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
    if(![shopNavi.viewControllers containsObject:shopTopSellers])
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
            [shopNavi pushViewController:shopTopSellers animated:false];
            
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

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return true;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
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

@implementation StoreShopListController

-(GMGridView *)gridView
{
    return grid;
}

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
    
    grid=gv;
    
    [self.view addSubview:gv];
    self.view.backgroundColor=[UIColor clearColor];
}

@end