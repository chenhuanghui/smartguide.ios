//
//  CatalogueListViewController.m
//  SmartGuide
//
//  Created by XXX on 7/11/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "CatalogueListViewController.h"
#import "CatalogueListCell.h"
#import "Shop.h"
#import "ShopDetailViewController.h"
#import "RootViewController.h"
#import "BannerAdsViewController.h"
#import "SlideQRCodeViewController.h"
#import "FrontViewController.h"

@interface CatalogueListViewController ()
{
}

@end

@implementation CatalogueListViewController
@synthesize delegate,mode,templateList,templateSearch;

- (id)init
{
    self = [super initWithNibName:NIB_PHONE(@"CatalogueListViewController") bundle:nil];
    if (self) {
    }
    return self;
}

-(void)switchToModeList
{
    if(mode==LIST_SHOP)
        return;
    
    if(templateSearch)
    {
        [templateSearch reset];
        self.templateSearch=nil;
    }
    
    [templateList setTableView:tableShop];
    
    self.title=@"";
    if(templateList.group.count==1)
        self.title=((ShopCatalog*)[templateList.group objectAtIndex:0]).name;
    if(templateList.group.count>1)
        self.title=@"Nhiều danh mục";
    
    mode=LIST_SHOP;
    
    [tableShop reloadData];
    
    [tableShop scrollToRowAtIndexPath:templateList.lastSelectedRow atScrollPosition:UITableViewScrollPositionNone animated:false];
}

-(bool)tableTemplateAllowAutoScrollFullCell:(TableTemplate *)tableTemplate
{
    return false;
}

-(void)handleSearchResult:(NSString *)searchKey result:(NSArray *)array page:(int)page selectedShop:(Shop *)selectedShop selectedRow:(NSIndexPath *)lastSelectedRow
{
    if(templateSearch)
    {
        [templateSearch reset];
        self.templateSearch=nil;
    }
    
    self.title=searchKey;
    mode=LIST_SEARCH;
    
    self.templateSearch=[[TemplateSearch alloc] initWithSearchKey:searchKey result:array page:page withTableView:tableShop withDelegate:self selectedShop:selectedShop selectedRow:lastSelectedRow];
    templateSearch.catalogueList=self;
}

-(void)reloadDataForChangedCity:(int)_city
{
    [self loadGroups:templateList.group sortType:templateList.sortBy city:_city];
}

-(void)loadGroup:(ShopCatalog *)_group city:(int)_city sortType:(enum SORT_BY)sortBy
{
    _isNeedReload=false;
    
    if(!templateList)
    {
        if(delegate)
            [delegate catalogueListLoadShopFinished:self];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CATALOGUE_LIST_FINISHED object:nil];
        
        return;
    }
    
    if(_group!=nil  && templateList.group.count==1)
    {
        if(_group.idCatalog.integerValue==templateList.firstGroup.idCatalog.integerValue && _city==templateList.city && sortBy==templateList.sortBy)
        {
            if(delegate)
            {
                self.title=_group.name;
                [delegate catalogueListLoadShopFinished:self];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CATALOGUE_LIST_FINISHED object:nil];
            }
            
            return;
        }
    }
    
    templateList.group=[@[_group] mutableCopy];
    templateList.city=_city;
    templateList.sortBy=sortBy;
    
    [self switchToModeList];
    
    [self resetData];
    
    [tableShop setContentOffset:CGPointZero];
    
    templateList.lastSelectedRow=nil;
    templateList.selectedShop=nil;
    
    [self loadShopAtPage:0];
    
    [self.view showLoadingWithTitle:nil];
    self.title=_group.name;
}

-(void)loadGroups:(NSArray *)group sortType:(enum SORT_BY)sortBy city:(int)city
{
    _isNeedReload=false;
    
    if(!templateList)
    {
        if(delegate)
            [delegate catalogueListLoadShopFinished:self];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CATALOGUE_LIST_FINISHED object:nil];
        
        return;
    }
    
    if(group.count==1)
    {
        [self loadGroup:group.firstObject city:city sortType:sortBy];
        return;
    }
    
    if(templateList.group.count==group.count && templateList.sortBy==sortBy && templateList.city==city)
    {
        bool hasDiff=false;
        for(ShopCatalog *g in group)
        {
            if(![templateList.group containsObject:g])
            {
                hasDiff=true;
                break;
            }
        }
        
        if(!hasDiff)
        {
            if(delegate && [delegate respondsToSelector:@selector(catalogueListLoadShopFinished:)])
            {
                [delegate catalogueListLoadShopFinished:self];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CATALOGUE_LIST_FINISHED object:nil];
            }
            return;
        }
    }
    
    templateList.group=[group mutableCopy];
    templateList.city=city;
    templateList.sortBy=sortBy;
    
    [self switchToModeList];
    
    [self resetData];
    
    [tableShop setContentOffset:CGPointZero];
    
    templateList.lastSelectedRow=nil;
    templateList.selectedShop=nil;
    
    [self loadShopAtPage:0];
    
    [self.view showLoadingWithTitle:nil];
    self.title=@"Nhiều danh mục";
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    mode=LIST_SHOP;
    
    self.view.backgroundColor=COLOR_BACKGROUND_APP;
    
    self.view.autoresizingMask=UIViewAutoresizingNone;
    
    self.templateList=[[TemplateList alloc] initWithTableView:tableShop withDelegate:self];
    templateList.catalogueList=self;
    
    [tableShop registerNib:[UINib nibWithNibName:[CatalogueListCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[CatalogueListCell reuseIdentifier]];
    
    btnUp.hidden=true;
    btnDown.hidden=true;
    
    blurTop.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blur_bottom.png"]];
    blurTop.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(180));
    blurBottom.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blur_bottom.png"]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userScanedQRCode:) name:NOTIFICATION_USER_SCANED_QR_CODE object:nil];
    
    CGRect rect=tableShop.frame;
    rect.origin=CGPointZero;
    rect.size.height=16;
    UIView *vi = [[UIView alloc] initWithFrame:rect];
    vi.backgroundColor=[UIColor clearColor];
    tableShop.tableHeaderView=vi;
    
    rect.origin.y=tableShop.frame.size.height-rect.size.height;
    vi=[[UIView alloc] initWithFrame:rect];
    vi.backgroundColor=[UIColor clearColor];
    tableShop.tableFooterView=vi;
    
    [[LocationManager shareInstance] checkLocationAuthorize];
    
    if(![LocationManager shareInstance].isAllowLocation)
    {
        __block __weak id obs=[[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_CATALOGUEBLOCK_FINISHED object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            [self loadGroup:[ShopCatalog all] city:[DataManager shareInstance].currentCity.idCity.integerValue sortType:[DataManager shareInstance].currentUser.filter.sortBy];
            
            [[NSNotificationCenter defaultCenter] removeObserver:obs];
        }];
    }
}

-(void) userScanedQRCode:(NSNotification*) notification
{
    if(notification.object)
        [tableShop reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.view.userInteractionEnabled=true;
    
    //clear shopdetail
    [[RootViewController shareInstance].shopDetail setShop:nil];
    [[RootViewController shareInstance].shopDetail removeFromParentViewController];
    [[RootViewController shareInstance].shopDetail.view removeFromSuperview];
    
//    CGRect rect=CGRectMake(0, 37, 320, [UIScreen mainScreen].bounds.size.height-[RootViewController shareInstance].heightAds_QR);
//    [RootViewController shareInstance].frontViewController.view.frame=rect;
    
    [[RootViewController shareInstance].bannerAds animationHideShopDetail];
    
    if(self.mode==LIST_SHOP)
    {
        if(templateList.selectedShop && [templateList.datasource containsObject:templateList.selectedShop])
        {
            [tableShop scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[templateList.datasource indexOfObject:templateList.selectedShop] inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:false];
        }
    }
    else
    {
        if(templateSearch.selectedShop && [templateSearch.datasource containsObject:templateSearch.selectedShop])
        {
            [tableShop scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[templateSearch.datasource indexOfObject:templateSearch.selectedShop] inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:false];
        }
    }
    
    if(![Flags isShowedTutorialSlideList])
    {
        if(!imgvTutorial)
        {
            imgvTutorial=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Truot.png"]];
            imgvTutorial.frame=CGRectMake(0, self.view.frame.size.height/2-56/2, 62, 56);
            
            imgvTutorial.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-8));
            
            imgvTutorialText=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Truot_text.png"]];
            imgvTutorialText.frame=CGRectMake(0, imgvTutorial.frame.origin.y+imgvTutorial.frame.size.height-10, 62, 32);
            
            [self.view addSubview:imgvTutorial];
            [self.view addSubview:imgvTutorialText];
            
            [self startAnimationTutorial];
            
            __block __weak id obs = [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_USER_FINISHED_TUTORIAL_SLIDE_LIST object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
                
                if(imgvTutorial)
                {
                    [imgvTutorial removeFromSuperview];
                    imgvTutorial=nil;
                    
                    [imgvTutorialText removeFromSuperview];
                    imgvTutorialText=nil;
                }
                
                [[NSNotificationCenter defaultCenter] removeObserver:obs];
            }];
        }
    }
    else
    {
        if(imgvTutorial)
        {
            [imgvTutorial removeFromSuperview];
            imgvTutorial=nil;
            
            [imgvTutorialText removeFromSuperview];
            imgvTutorialText=nil;
        }
    }
}

-(void) startAnimationTutorial
{
    [UIView animateWithDuration:0.5f animations:^{
        imgvTutorial.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(15));
//        imgvTutorial.center=CGPointMake(imgvTutorial.center.x, imgvTutorial.center.y-10)
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5f animations:^{
            imgvTutorial.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-8));
        } completion:^(BOOL finished) {
            [self startAnimationTutorial];
        }];
    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(self.mode==LIST_SHOP && _isNeedReload)
    {
        [self reloadDataForChangedCity:[DataManager shareInstance].currentCity.idCity.integerValue];
    }
}

-(void) loadShopAtPage:(int) page
{
    [templateList loadShopAtPage:page];
}

-(void) loadSearchAtPage:(int) page
{
    [templateSearch loadAtPage:page];
}

-(void) resetData
{
    [templateList reset];
    [templateList resetData];
}

-(bool)tableTemplateAllowLoadMore:(TableTemplate *)tableTemplate
{
    return true;
}

-(void)tableTemplateLoadNext:(TableTemplate *)tableTemplate wait:(bool *)isWait
{
    if(mode==LIST_SHOP)
        [self loadShopAtPage:templateList.page];
    else
        [self loadSearchAtPage:templateSearch.page];
    
    *isWait=true;
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    [self.view removeLoading];
    
    if(self.mode==LIST_SHOP)
    {
        btnUp.hidden=templateList.datasource.count==0;
        btnDown.hidden=templateList.datasource.count==0;
        
        if(delegate)
            [delegate catalogueListLoadShopFinished:self];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CATALOGUE_LIST_FINISHED object:nil];
        
        [[RootViewController shareInstance] setNeedRemoveLoadingScreen];
    }
    else
    {
        btnUp.hidden=templateSearch.datasource.count==0;
        btnDown.hidden=templateSearch.datasource.count==0;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    [self.view removeLoading];
    
    if(self.mode==LIST_SHOP)
    {
        if(delegate)
            [delegate catalogueListLoadShopFinished:self];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CATALOGUE_LIST_FINISHED object:nil];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.mode==LIST_SHOP)
        return templateList.datasource.count;
    else
        return templateSearch.datasource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CatalogueListCell *cell=[tableView dequeueReusableCellWithIdentifier:[CatalogueListCell reuseIdentifier]];
    Shop *shop=nil;
    
    if(self.mode==LIST_SHOP)
        shop=[templateList.datasource objectAtIndex:indexPath.row];
    else
        shop=[templateSearch.datasource objectAtIndex:indexPath.row];
    
    [cell setData:shop];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Shop *shop=nil;
    
    if(self.mode==LIST_SHOP)
    {
        templateList.selectedShop.selected=false;
        
        if(templateList.lastSelectedRow)
            [((CatalogueListCell*)[tableView cellForRowAtIndexPath:templateList.lastSelectedRow]) refreshData];
        
        templateList.lastSelectedRow=tableView.indexPathForSelectedRow;
        
        shop=[templateList.datasource objectAtIndex:indexPath.row];
        templateList.selectedShop=shop;
    }
    else
    {
        templateSearch.selectedShop.selected=false;
        
        if(templateSearch.lastSelectedRow)
            [((CatalogueListCell*)[tableView cellForRowAtIndexPath:templateSearch.lastSelectedRow]) refreshData];
        
        templateSearch.lastSelectedRow=tableView.indexPathForSelectedRow;
        
        shop=[templateSearch.datasource objectAtIndex:indexPath.row];
        templateSearch.selectedShop=shop;
    }
    
    shop.selected=true;
    
    [((CatalogueListCell*)[tableView cellForRowAtIndexPath:indexPath]) refreshData];
    
    self.view.userInteractionEnabled=false;
    
    while (!_isInitedShopDetail) {
        sleep(0.1f);
    }
    
    [self pushShopDetailWithShop:shop animated:true];
}

-(void)pushShopDetailWithShop:(Shop *)shop animated:(bool)animate
{
    if(animate)
    {
        self.frontViewController.isPushingViewController=true;
        [RootViewController shareInstance].shopDetail.shoplMode=SHOPDETAIL_FROM_LIST;
        [[RootViewController shareInstance].shopDetail removeFromParentViewController];
        [[RootViewController shareInstance].shopDetail.view removeFromSuperview];
        
        [[RootViewController shareInstance].shopDetail setShop:shop];
        
        [RootViewController shareInstance].navigationBarView.delegate=[RootViewController shareInstance].shopDetail;
        
        CGRect rect=self.navigationController.view.frame;
        rect.size.height+=[RootViewController shareInstance].heightAds_QR;
        self.navigationController.view.frame=rect;
        
        [RootViewController shareInstance].shopDetail.view.frame=rect;
        
        [[RootViewController shareInstance].bannerAds prepareAnimationShowShopDetail];
        [[RootViewController shareInstance].bannerAds animationShowShopDetail:^(BOOL finished) {
            [RootViewController shareInstance].bannerAds.view.hidden=true;
            [self.navigationController pushViewController:[RootViewController shareInstance].shopDetail animated:true];
        }];
    }
    else
    {
        self.frontViewController.isPushingViewController=true;
        [RootViewController shareInstance].shopDetail.shoplMode=SHOPDETAIL_FROM_LIST;
        [[RootViewController shareInstance].shopDetail removeFromParentViewController];
        [[RootViewController shareInstance].shopDetail.view removeFromSuperview];
        
        [[RootViewController shareInstance].shopDetail setShop:shop];
        
        [RootViewController shareInstance].navigationBarView.delegate=[RootViewController shareInstance].shopDetail;
        
        CGRect rect=self.navigationController.view.frame;
        rect.size.height+=[[RootViewController shareInstance] heightAds_QR];
        self.navigationController.view.frame=rect;
        
        [RootViewController shareInstance].shopDetail.view.frame=rect;
        
        [[RootViewController shareInstance].bannerAds prepareAnimationShowShopDetail];
        [[RootViewController shareInstance].bannerAds animationShowShopDetail:false completed:nil];
        [RootViewController shareInstance].bannerAds.view.hidden=true;
        [self.navigationController pushViewController:[RootViewController shareInstance].shopDetail animated:true];
    }
}

-(void) showShopDetail
{
    self.frontViewController.isPushingViewController=true;
    [RootViewController shareInstance].shopDetail.shoplMode=SHOPDETAIL_FROM_LIST;
    [[RootViewController shareInstance].shopDetail removeFromParentViewController];
    [[RootViewController shareInstance].shopDetail.view removeFromSuperview];
    
    [RootViewController shareInstance].navigationBarView.delegate=[RootViewController shareInstance].shopDetail;
    
    CGRect rect=self.navigationController.view.frame;
    rect.size.height+=[[RootViewController shareInstance] heightAds_QR];
    self.navigationController.view.frame=rect;
    
    [RootViewController shareInstance].shopDetail.view.frame=rect;
    
    [[RootViewController shareInstance].bannerAds prepareAnimationShowShopDetail];
    [[RootViewController shareInstance].bannerAds animationShowShopDetail:false completed:nil];
    [RootViewController shareInstance].bannerAds.view.hidden=true;
    [self.navigationController pushViewController:[RootViewController shareInstance].shopDetail animated:false];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CatalogueListCell height]+5;
}

-(NSArray *)currentShops
{
    if(mode==LIST_SEARCH)
        return templateSearch.datasource;
    
    return templateList.datasource;
}

- (void)viewDidUnload {
    tableShop = nil;
    btnUp = nil;
    btnDown = nil;
    blurTop = nil;
    blurBottom = nil;
    [super viewDidUnload];
}


- (IBAction)btnUpTouchUpInside:(id)sender {
    if(templateList.datasource.count>0)
    {
        [tableShop setContentOffset:CGPointZero animated:true];
    }
}
- (IBAction)btnDownTouchUpInsid:(id)sender {
    if(templateList.datasource.count>0)
    {
        [tableShop scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[tableShop numberOfRowsInSection:0]-1 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:true];
    }
}

-(NSArray *)rightNavigationItems
{
    return @[@(ITEM_FILTER),@(ITEM_COLLECTION),@(ITEM_MAP)];
}

-(void)loadView
{
    [super loadView];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _isInitedShopDetail=false;
        [RootViewController shareInstance].shopDetail=[[ShopDetailViewController alloc] init];
        [[RootViewController shareInstance].shopDetail view];
        
        _isInitedShopDetail=true;
    });
}

-(bool)allowDragPreviousView:(UIPanGestureRecognizer *)pan
{
    CGPoint pnt=[pan translationInView:pan.view];
    
    if(pnt.x<0)
        return false;
    
    return fabsf(pnt.x)>fabsf(pnt.y);
}

-(void)setIsNeedReload
{
    _isNeedReload=true;
}

@end

@implementation CatalogueListView
@end

@implementation TemplateList
@synthesize lastSelectedRow,selectedShop,opeartionShopInGroup,catalogueList,sortBy;

-(TableTemplate *)initWithTableView:(UITableView *)tableView withDelegate:(id<TableTemplateDelegate>)delegate
{
    self=[super initWithTableView:tableView withDelegate:delegate];
    
    self.sortBy=[DataManager shareInstance].currentUser.filter.sortBy;
    
    return self;
}

-(void) loadShopAtPage:(int) page
{
    if(self.group==nil || self.group.count==0)
        return;
    
    User *user=[DataManager shareInstance].currentUser;
    
    NSString *ids=[[self.group valueForKey:ShopCatalog_IdCatalog] componentsJoinedByString:@","];
    
    for(ShopCatalog *g in self.group)
    {
        if(g.idCatalog.integerValue==0)
        {
            ids=@"1,2,3,4,5,6,7,8";
            break;
        }
    }
    
    self.sortBy=[DataManager shareInstance].currentUser.filter.sortBy;
    
    int idCity=self.city;
    self.opeartionShopInGroup=[[ASIOperationShopInGroup alloc] initWithIDCity:idCity idUser:user.idUser.integerValue lat:user.location.latitude lon:user.location.longitude page:page sort:sortBy group:ids];
    self.opeartionShopInGroup.delegatePost=self;
    
    [self.opeartionShopInGroup startAsynchronous];
}

-(ShopCatalog *)firstGroup
{
    if(self.group.count>0)
        return self.group.firstObject;
    
    return nil;
}

-(void)reset
{
    self.page=0;
    
    if(self.opeartionShopInGroup)
    {
        [self.opeartionShopInGroup cancel];
        self.opeartionShopInGroup=nil;
    }
    
    self.datasource=[[NSMutableArray alloc] init];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    NSArray *shops=((ASIOperationShopInGroup*)operation).shops;
    
    if(shops.count>0)
    {
        self.page++;
        [self.datasource addObjectsFromArray:shops];
    }
    
    [catalogueList ASIOperaionPostFinished:operation];
    
    [self setAllowLoadMore:shops.count==10];
    
    [self endLoadNext];
    
    self.opeartionShopInGroup=nil;
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    [catalogueList ASIOperaionPostFailed:operation];
    
    
    self.opeartionShopInGroup=nil;
}

@end

@implementation TemplateSearch
@synthesize searchKey,lastSelectedRow,selectedShop,operationSearchShop,catalogueList;

-(TemplateSearch *)initWithSearchKey:(NSString *)_searchKey result:(NSArray *)array page:(int)page withTableView:(UITableView *)table withDelegate:(id<TableTemplateDelegate>)delegate selectedShop:(Shop *)_selectedShop selectedRow:(NSIndexPath *)_lastSelectedRow
{
    self=[super initWithTableView:table withDelegate:delegate];
    
    self.searchKey=[NSString stringWithString:_searchKey];
    self.page=page;
    self.datasource=[NSMutableArray arrayWithArray:array];
    self.selectedShop=_selectedShop;
    self.lastSelectedRow=[NSIndexPath indexPathForRow:_lastSelectedRow.row inSection:_lastSelectedRow.section];
    
    return self;
}

-(void)loadAtPage:(int)page
{
    User *user=[DataManager shareInstance].currentUser;
    self.operationSearchShop=[[ASIOperationSearchShop alloc] initWithShopName:self.searchKey idUser:user.idUser.integerValue lat:user.location.latitude lon:user.location.longitude page:page];
    self.operationSearchShop.delegatePost=self;
    
    [self.operationSearchShop startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    ASIOperationSearchShop*ope = (ASIOperationSearchShop*)operation;
    
    if(ope.shops.count>0)
    {
        self.page++;
        [self.datasource addObjectsFromArray:ope.shops];
    }
    
    [self.catalogueList ASIOperaionPostFinished:operation];
    
    [self setAllowLoadMore:ope.shops.count==10];
    
    [self endLoadNext];
    
    
    self.operationSearchShop=nil;
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    [self.catalogueList ASIOperaionPostFailed:operation];
    
    self.operationSearchShop=nil;
}

-(void)reset
{
    self.searchKey=nil;
    
    if(self.operationSearchShop)
    {
        [self.operationSearchShop cancel];
        self.operationSearchShop=nil;
    }
    
    self.datasource=nil;
    self.selectedShop=nil;
    self.lastSelectedRow=nil;
    
    _tableView.dataSource=nil;
    _tableView.delegate=nil;
}

@end

@implementation TableList

@end