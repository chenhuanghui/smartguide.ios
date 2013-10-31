//
//  ShopListViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopListViewController.h"
#import "GUIManager.h"

@interface ShopListViewController ()

@end

@implementation ShopListViewController
@synthesize delegate,catalog;

- (id)init
{
    self = [super initWithNibName:@"ShopListViewController" bundle:nil];
    if (self) {
        
    }
    return self;
}

-(NSArray *)registerNotifications
{
    return @[UIApplicationDidBecomeActiveNotification];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:UIApplicationDidBecomeActiveNotification])
    {
        [self reloadList];
    }
}

-(void) reloadList
{
    double lat=[DataManager shareInstance].currentUser.location.latitude;
    double lon=[DataManager shareInstance].currentUser.location.longitude;
    
    if(lat==-1||lon==-1)
        return;
    
    [templateShopList reset];
    [self loadListAtPage:0];
    
    [self.view SGShowLoading];
}

-(void)loadWithCatalog:(ShopCatalog *)shopCatalog onCompleted:(void (^)(bool))onFinishedLoadCatalog
{
    _onFinishedLoadCatalog=[onFinishedLoadCatalog copy];
    self.catalog=[NSString stringWithString:shopCatalog.key];
    
    //Vì loading được hiển thị ở shop catalog nên shoplistcontroller không được push vào navigation dẫn đến viewdidload không được gọi
    // gọi self view để force view được load còn nếu đã load rồi thì gọi ko ảnh hưởng gì hết
    [self view];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopInGroup class]])
    {
        [self.view SGRemoveLoading];
        
        ASIOperationShopInGroup *ope=(ASIOperationShopInGroup*)operation;
        
        if(ope.shops.count>0)
        {
            [templateShopList.datasource addObjectsFromArray:ope.shops];
            templateShopList.page++;
        }
        
        if(_onFinishedLoadCatalog)
        {
            _onFinishedLoadCatalog(true);
            _onFinishedLoadCatalog=nil;
        }
        
        templateShopList.isAllowLoadMore=ope.shops.count==10;
        [templateShopList endLoadNext];
        
        _operationShopList=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopInGroup class]])
    {
        templateShopList.isAllowLoadMore=false;
        [templateShopList endLoadNext];
        
        if(_onFinishedLoadCatalog)
        {
            _onFinishedLoadCatalog(false);
            _onFinishedLoadCatalog=nil;
        }
        
        _operationShopList=nil;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CatalogueListCell *cell=[tableList dequeueReusableCellWithIdentifier:[CatalogueListCell reuseIdentifier]];
    Shop *shop=templateShopList.datasource[indexPath.row];
    
    [cell setData:shop];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CatalogueListCell height];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopUserViewController *vc=[ShopUserViewController shareInstance];
    vc.delegate=self;
    [[GUIManager shareInstance] presentModalViewController:vc animated:true];
}

-(void)shopUserFinished
{
    [[GUIManager shareInstance] dismissModalViewController:[ShopUserViewController shareInstance] animated:true];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [tableList registerNib:[UINib nibWithNibName:[CatalogueListCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[CatalogueListCell reuseIdentifier]];
   
    self.view.backgroundColor=COLOR_BACKGROUND_APP;
    
    blurrTop.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blur_bottom.png"]];
    blurrTop.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(180));
    blurrBot.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blur_bottom.png"]];
    
    CGRect rect=tableList.frame;
    rect.origin=CGPointZero;
    rect.size.height=16;
    UIView *vi = [[UIView alloc] initWithFrame:rect];
    vi.backgroundColor=[UIColor clearColor];
    tableList.tableHeaderView=vi;
    
    rect.origin.y=tableList.frame.size.height-rect.size.height;
    vi=[[UIView alloc] initWithFrame:rect];
    vi.backgroundColor=[UIColor clearColor];
    tableList.tableFooterView=vi;
    
    templateShopList=[[SGTableTemplate alloc] initWithTableView:tableList withDelegate:self];
    templateShopList.isAllowLoadMore=true;
    templateShopList.isAllowPullToRefresh=true;
    
    [self loadListAtPage:0];
}

-(void)SGTableTemplateLoadMore:(SGTableTemplate *)SGTemplate isWaited:(bool *)isWaited
{
    *isWaited=true;
    [self loadListAtPage:templateShopList.page];
}

-(void) loadListAtPage:(int) page
{
    int idCity=[DataManager shareInstance].currentCity.idCity.integerValue;
    int idUser=[DataManager shareInstance].currentUser.idUser.integerValue;
    double lat=[DataManager shareInstance].currentUser.location.latitude;
    double lon=[DataManager shareInstance].currentUser.location.longitude;
    enum SORT_BY sortBy=[DataManager shareInstance].currentUser.filter.sortBy;
    
    _operationShopList=[[ASIOperationShopInGroup alloc] initWithIDCity:idCity idUser:idUser lat:lat lon:lon page:page sort:sortBy group:self.catalog];
    _operationShopList.delegatePost=self;
    
    [_operationShopList startAsynchronous];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)title
{
    return CLASS_NAME;
}

- (IBAction)btn:(id)sender {
    [self.delegate shopListSelectedShop];
    
}

-(void)dealloc
{
    NSLog(@"dealloc %@", CLASS_NAME);
}

@end
