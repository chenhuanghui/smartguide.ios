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
#import "BGBlurView.h"
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
    self = [super initWithNibName:@"CatalogueListViewController" bundle:nil];
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
    
    self.title=templateList.group.name;
    mode=LIST_SHOP;
    
    [tableShop reloadData];
    
    [tableShop scrollToRowAtIndexPath:templateList.lastSelectedRow atScrollPosition:UITableViewScrollPositionNone animated:false];
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

-(void)loadGroup:(Group *)_group city:(City *)_city
{
    if(!templateList)
    {
        if(delegate)
            [delegate catalogueListLoadShopFinished:self];
        
        return;
    }
    
    if(_group!=nil && templateList.group.idGroup.integerValue==_group.idGroup.integerValue && _city!=nil && templateList.city.idCity.integerValue==_city.idCity.integerValue)
    {
        if(delegate)
            [delegate catalogueListLoadShopFinished:self];
        return;
    }
    
    [self switchToModeList];
    
    [self resetData];
    
    [tableShop setContentOffset:CGPointZero];
    templateList.city=_city;
    templateList.group=_group;
    
    templateList.lastSelectedRow=nil;
    templateList.selectedShop=nil;
    
    [self loadShopAtPage:0];
    
    [self.view showLoadingWithTitle:nil];
    self.title=_group.name;
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
}

-(void) userScanedQRCode:(NSNotification*) notification
{
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
    
    self.navigationController.view.frame=CGRectMake(0, 37, 320, 337);
    
    [[RootViewController shareInstance].bannerAds animationHideShopDetail];
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
    [self removeIndicator];
    
    if(self.mode==LIST_SHOP)
    {
        btnUp.hidden=templateList.datasource.count==0;
        btnDown.hidden=templateList.datasource.count==0;
        
        if(delegate)
            [delegate catalogueListLoadShopFinished:self];
    }
    else
    {
        btnUp.hidden=templateSearch.datasource.count==0;
        btnDown.hidden=templateSearch.datasource.count==0;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    [self removeIndicator];
    
    if(self.mode==LIST_SHOP)
        if(delegate)
            [delegate catalogueListLoadShopFinished:self];
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
        rect.size.height+=[BannerAdsViewController size].height;
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
        rect.size.height+=[BannerAdsViewController size].height;
        self.navigationController.view.frame=rect;

        [RootViewController shareInstance].shopDetail.view.frame=rect;
        
        [[RootViewController shareInstance].bannerAds prepareAnimationShowShopDetail];
        [[RootViewController shareInstance].bannerAds animationShowShopDetail:false completed:nil];
        [RootViewController shareInstance].bannerAds.view.hidden=true;
        [self.navigationController pushViewController:[RootViewController shareInstance].shopDetail animated:true];
    }
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
    return @[@(ITEM_COLLECTION),@(ITEM_MAP)];
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

@end

@implementation CatalogueListView
@end

@implementation TemplateList
@synthesize lastSelectedRow,selectedShop,opeartionShopInGroup,catalogueList;

-(void) loadShopAtPage:(int) page
{
    if(self.group==nil || self.city==nil)
        return;
    
    User *user=[DataManager shareInstance].currentUser;
    
    int idCity=self.city.idCity.integerValue;
    self.opeartionShopInGroup=[[ASIOperationShopInGroup alloc] initWithIDCity:idCity idUser:user.idUser.integerValue lat:user.location.latitude lon:user.location.longitude page:page sort:SORT_DISTANCE group:self.group,nil];
    self.opeartionShopInGroup.delegatePost=self;
    
    [self.opeartionShopInGroup startAsynchronous];
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