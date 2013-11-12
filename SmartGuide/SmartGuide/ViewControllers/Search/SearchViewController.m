//
//  SearchViewController.m
//  SmartGuide
//
//  Created by XXX on 8/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SearchViewController.h"
#import "ActivityIndicator.h"
#import "CatalogueListCell.h"
#import "Shop.h"
#import "RootViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize delegate;

-(bool) isHighlighted:(UIView*) filter
{
    return filter.tag;
}

-(void)search:(NSString *)text
{
    if(!([self isHighlighted:food]
         || [self isHighlighted:drink]
         || [self isHighlighted:health]
         || [self isHighlighted:entertaiment]
         || [self isHighlighted:fashion]
         || [self isHighlighted:travel]
         || [self isHighlighted:production]
         || [self isHighlighted:education]))
    {
        [AlertView showAlertOKWithTitle:nil withMessage:@"Bạn phải chọn ít nhất 1 danh mục" onOK:nil];
        return;
    }
    
    
    [self cancelSearch];
    
    [self setFilterVisibled:false];
    [[RootViewController shareInstance].navigationBarView endEditing:true];
    
    CGRect rect=self.view.frame;
    rect.origin=CGPointZero;
    table.frame=rect;
    
    [templateTable resetData];
    templateTable.page=0;
    templateTable.datasource=[[NSMutableArray alloc] init];
    
    _searchText=[[NSString alloc] initWithString:text];
    _sortBy=[DataManager shareInstance].currentUser.filter.sortBy;
    _promotionFilter=[DataManager shareInstance].currentUser.filter.shopPromotionFilterType;
    _groups=[[DataManager shareInstance].currentUser.filter.groups copy];
    
    [table setContentOffset:CGPointZero];
    
    rect=self.view.window.frame;
    if([UIScreen mainScreen].bounds.size.height==480)
    {
        rect.size.height-=150;
    }
    else
    {
        rect.size.height-=150;
    }
    
    [self.view.window showLoadingWithTitle:nil rect:rect];
    
    [self loadAtPage:0];
}

-(void)handleResult:(NSArray *)shops text:(NSString *)text page:(int)page groups:(NSString *)groups sortBy:(enum SORT_BY)sortBy promotionFilter:(enum SHOP_PROMOTION_FILTER_TYPE)promotionFilter
{
    for(Shop *shop in shops)
    {
        if(shop.selected)
            _selectedShop=shop;
    }
    
    templateTable.datasource=[[NSMutableArray alloc] init];
    [templateTable resetData];
    templateTable.datasource=[shops mutableCopy];
    templateTable.page=page;

    _searchText=[[NSString alloc] initWithString:text];
    _groups=[groups copy];
    _sortBy=sortBy;
    _promotionFilter=promotionFilter;
    
    [table reloadData];
    
    [self setFilterVisibled:false];
}

-(void)removeFromParentViewController
{
    [super removeFromParentViewController];
    
    [self cancelSearch];
}

-(void)cancelSearch
{
    if(_operation)
    {
        [_operation cancel];
        _operation=nil;
    }
}

-(void) loadAtPage:(int) page
{
    int idUser=[DataManager shareInstance].currentUser.idUser.integerValue;
    double lat=[DataManager shareInstance].currentUser.location.latitude;
    double lon=[DataManager shareInstance].currentUser.location.longitude;

    _operation=[[ASIOperationSearchShop alloc] initWithKeyword:_searchText groups:_groups idUser:idUser lat:lat lon:lon page:page promotionFilter:_promotionFilter sortType:_sortBy];
    _operation.delegatePost=self;
    
    [_operation startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    [self.view.window removeLoading];
    
    ASIOperationSearchShop*ope = (ASIOperationSearchShop*)operation;
    
    if(ope.shops.count>0)
    {
        templateTable.page++;
        [templateTable.datasource addObjectsFromArray:ope.shops];
    }
    
    [templateTable setAllowLoadMore:ope.shops.count==10];
    
    [templateTable endLoadNext];
    
    _operation=nil;
    
    if(templateTable.datasource.count>0)
    {
        [[RootViewController shareInstance].navigationBarView endEditing:true];
    }
    
    if(searchView.hidden)
    {
        searchView.alpha=0;
        searchView.hidden=false;
        
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            searchView.alpha=1;
        } completion:^(BOOL finished) {
            searchView.hidden=false;
        }];
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    [self.view removeLoading];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor=COLOR_BACKGROUND_APP;
    templateTable=[[TableTemplate alloc] initWithTableView:table withDelegate:self];
    [table registerNib:[UINib nibWithNibName:[CatalogueListCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[CatalogueListCell reuseIdentifier]];
    
    blurTop.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blur_bottom.png"]];
    blurTop.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(180));
    blurBot.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blur_bottom.png"]];
    
    CGRect rect=table.frame;
    rect.origin=CGPointZero;
    rect.size.height=18;
    UIView *vi = [[UIView alloc] initWithFrame:rect];
    vi.backgroundColor=[UIColor clearColor];
    table.tableHeaderView=vi;
    
    rect.origin.y=table.frame.size.height-rect.size.height;
    vi=[[UIView alloc] initWithFrame:rect];
    vi.backgroundColor=[UIColor clearColor];
    table.tableFooterView=vi;
    
    [self loadFilter];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.delegate=self;
    [filterView addGestureRecognizer:tap];
    
    tapGes=tap;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void) searchKeyboardWillShow:(NSNotification*) notification
{
    [self setFilterVisibled:true];
}

-(void) searchKeyboardWillHide:(NSNotification*) notification
{
    
}

-(void) tap:(UITapGestureRecognizer*) tap
{
    switch (tap.state) {
        case UIGestureRecognizerStateEnded:
        {
            if(filterView.hidden)
                return;
            
            CGPoint pnt=[tap locationInView:filterView];
            
            UIView *filter=nil;
            for(filter in [self filters])
            {
                if(CGRectContainsPoint(filter.frame, pnt))
                {
                    [self setHighlight:![self isHighlighted:filter] filter:filter];
                    [self storeFilter];
                    break;
                }
            }
        }
            break;
            
        default:
            break;
    }
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer==tapGes)
    {
        [[RootViewController shareInstance].navigationBarView endEditing:true];
        if(filterView.hidden)
            return false;
        
        CGPoint pnt=[tapGes locationInView:self.view];
        
        for(UIView *filter in [self filters])
        {
            if(CGRectContainsPoint(filter.frame, pnt))
                return true;
        }
        
        return false;
    }
    
    return true;
}

-(void)loadFilter
{
    Filter *filter=[[DataManager shareInstance] currentUser].filter;
    
    
    [self setHighlight:filter.food.boolValue filter:food];
    [self setHighlight:filter.drink.boolValue filter:drink];
    [self setHighlight:filter.health.boolValue filter:health];
    [self setHighlight:filter.entertaiment.boolValue filter:entertaiment];
    [self setHighlight:filter.fashion.boolValue filter:fashion];
    [self setHighlight:filter.travel.boolValue filter:travel];
    [self setHighlight:filter.production.boolValue filter:production];
    [self setHighlight:filter.education.boolValue filter:education];
    
//    btnPoint.selected=filter.mostGetPoint.boolValue;
    btnLike.selected=filter.mostLike.boolValue;
    btnView.selected=filter.mostView.boolValue;
    btnDistance.selected=filter.distance.boolValue;
    btnShopKM.selected=filter.isShopKM.boolValue;
}

-(void) setHighlight:(bool) highlighted filter:(UIView*) filter
{
    UIColor *colorName=[UIColor whiteColor];
    UIColor *colorSubname=[UIColor whiteColor];
    if(highlighted)
    {
        colorName=[UIColor whiteColor];
        colorSubname=[UIColor color255WithRed:162 green:173 blue:180 alpha:255];
        [self iconWithFilter:filter].highlighted=false;
        [self pinWithFilter:filter].highlighted=false;
    }
    else
    {
        colorName=[UIColor color255WithRed:117 green:117 blue:117 alpha:255];
        colorSubname=colorName;
        [self iconWithFilter:filter].highlighted=true;
        [self pinWithFilter:filter].highlighted=true;
    }
    
    filter.tag=highlighted;
    [self nameWithFilter:filter].textColor=colorName;
    [self subnameWithFilter:filter].textColor=colorSubname;
}

-(UIButton*) iconWithFilter:(UIView*) filter
{
    for (id btn in filter.subviews) {
        if([btn isKindOfClass:[FilterButton class]])
            return btn;
    }
    
    return nil;
}

-(UIButton*) pinWithFilter:(UIView*) filter
{
    for(UIButton *btn in filter.subviews)
        if(btn.tag==2)
            return btn;
    
    return nil;
}

-(UILabel*) nameWithFilter:(UIView*) filter
{
    return (UILabel*)[filter viewWithTag:3];
}

-(UILabel*) subnameWithFilter:(UIView*) filter
{
    return (UILabel*)[filter viewWithTag:4];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return templateTable.datasource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CatalogueListCell *cell=[table dequeueReusableCellWithIdentifier:[CatalogueListCell reuseIdentifier]];
    Shop *shop=[templateTable.datasource objectAtIndex:indexPath.row];
    
    [cell setData:shop];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CatalogueListCell height]+5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    _selectedRow=indexPath;
    
    Shop *shop=[templateTable.datasource objectAtIndex:indexPath.row];
    
    if(_selectedShop)
        _selectedShop.selected=false;
    
    _selectedShop=shop;
    
    [tableView reloadData];
    
    [delegate searchView:self selectedShop:shop];
}

-(bool)tableTemplateAllowLoadMore:(TableTemplate *)tableTemplate
{
    return true;
}

-(void)tableTemplateLoadNext:(TableTemplate *)tableTemplate wait:(bool *)isWait
{
    [self loadAtPage:templateTable.page];
    *isWait=true;
}

- (void)viewDidUnload {
    table = nil;
    [super viewDidUnload];
}

-(NSString *)searchText
{
    return _searchText;
}

-(NSArray *)result
{
    return templateTable.datasource;
}

-(int)page
{
    return templateTable.page;
}

-(Shop *)selectedShop
{
    return _selectedShop;
}

-(NSIndexPath *)selectedRow
{
    return _selectedRow;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[RootViewController shareInstance].navigationBarView endEditing:true];
    [[RootViewController shareInstance].navigationBarView enableCancelButton];
}

- (IBAction)btnShopKMTouchUpInside:(id)sender {
    btnShopKM.selected=!btnShopKM.selected;
    
    [self storeFilter];
}

-(NSArray*) filters
{
    return @[food,drink,health,entertaiment,fashion,travel,production,education];
}

- (IBAction)btnCheckAllTouchUpInside:(id)sender {
    for(UIView *filter in [self filters])
        [self setHighlight:true filter:filter];
    
    [self storeFilter];
}

- (IBAction)btnCheckNonTouchUpInside:(id)sender {
    for(UIView *filter in [self filters])
        [self setHighlight:false filter:filter];
    
    [self storeFilter];
}

- (IBAction)btnGetAwardTouchUpInside:(id)sender {
    [self setChecked:sender checked:true];
}

- (IBAction)btnGetPointTouchUpInside:(id)sender {
    [self setChecked:sender checked:true];
}

- (IBAction)btnMostLikeTouchUpInside:(id)sender {
    [self setChecked:sender checked:true];
}

- (IBAction)btnMostViewTouchUpInside:(id)sender {
    [self setChecked:sender checked:true];
}

- (IBAction)btnDistanceTouchUpInside:(id)sender {
    [self setChecked:sender checked:true];
}

-(void) setChecked:(UIButton*) btnChecked checked:(bool) checked
{
    if(btnChecked.selected)
        checked=false;
    
    for(UIButton *btn in [self radioButtons])
        [btn setSelected:false];
    
    [btnChecked setSelected:checked];
    
    [self storeFilter];
}

-(NSArray*) radioButtons
{
    return @[btnDistance,btnLike,btnView];
}

-(void) setFilterVisibled:(bool) visibled
{
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        filterView.alpha=visibled?1:0;
        searchView.alpha=visibled?0:1;
    } completion:^(BOOL finished) {
        filterView.hidden=filterView.alpha==0;
        searchView.hidden=searchView.alpha==0;
    }];
}

-(void) storeFilter
{
    Filter *filter=[DataManager shareInstance].currentUser.filter;
    
    filter.food=@([self isHighlighted:food]);
    filter.drink=@([self isHighlighted:drink]);
    filter.health=@([self isHighlighted:health]);
    filter.entertaiment=@([self isHighlighted:entertaiment]);
    filter.fashion=@([self isHighlighted:fashion]);
    filter.travel=@([self isHighlighted:travel]);
    filter.production=@([self isHighlighted:production]);
    filter.education=@([self isHighlighted:education]);
    
    filter.mostLike=@(btnLike.selected);
    filter.mostView=@(btnView.selected);
    filter.distance=@(btnDistance.selected);
    filter.isShopKM=@(btnShopKM.selected);
    
    [[DataManager shareInstance] save];
    
    [[RootViewController shareInstance].navigationBarView endEditing:true];
}

-(NSString *)groups
{
    return _groups;
}

-(enum SORT_BY)sortBy
{
    return _sortBy;
}

-(enum SHOP_PROMOTION_FILTER_TYPE)promotionFilter
{
    return _promotionFilter;
}

-(BOOL)wantsFullScreenLayout
{
    return true;
}

@end
