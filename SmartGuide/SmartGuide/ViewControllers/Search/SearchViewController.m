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

-(void)search:(NSString *)text
{
    [self cancelSearch];
    
    CGRect rect=self.view.frame;
    rect.origin=CGPointZero;
    table.frame=rect;
    
    [templateTable resetData];
    templateTable.page=0;
    templateTable.datasource=[[NSMutableArray alloc] init];
    
    _searchText=[[NSString alloc] initWithString:text];
    [table setContentOffset:CGPointZero];
    
    [self.view.window showLoadingWithTitle:nil];
    
    [self loadAtPage:0];
}

-(void)handleResult:(NSArray *)shops text:(NSString *)text page:(int)page
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
    
    [table reloadData];
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
    
    _operation=[[ASIOperationSearchShop alloc] initWithShopName:_searchText idUser:idUser lat:lat lon:lon page:page];
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

@end
