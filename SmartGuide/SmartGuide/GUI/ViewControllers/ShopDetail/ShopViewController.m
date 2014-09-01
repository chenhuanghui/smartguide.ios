//
//  ShopDetailViewController.m
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopViewController.h"
#import "Cells/ShopGalleryTableCell.h"
#import "Cells/ShopInfoTableCell.h"
#import "Cells/ShopDescTableCell.h"
#import "Cells/ShopAddressTableCell.h"
#import "Cells/ShopContactTableCell.h"
#import "Cells/ShopEventTableCell.h"
#import "Cells/ShopUserGalleryTableCell.h"
#import "Cells/ShopRelatedTableCell.h"
#import "OperationShopUser.h"

enum SHOP_CONTROLLER_CELL_TYPE
{
    SHOP_CONTROLLER_CELL_TYPE_SHOP_GALLERY=0,
    SHOP_CONTROLLER_CELL_TYPE_SHOP_INFO=1,
    SHOP_CONTROLLER_CELL_TYPE_SHOP_DESC=2,
    SHOP_CONTROLLER_CELL_TYPE_SHOP_ADDRESS=3,
    SHOP_CONTROLLER_CELL_TYPE_SHOP_CONTACT=4,
    SHOP_CONTROLLER_CELL_TYPE_SHOP_EVENT=5,
    SHOP_CONTROLLER_CELL_TYPE_SHOP_USER_GALLERY=6,
    SHOP_CONTROLLER_CELL_TYPE_SHOP_RELATED=7,
};

@interface ShopViewController ()<UITableViewDataSource, UITableViewDelegate, ASIOperationPostDelegate>
{
    OperationShopUser *_opeShopUser;
}

@property (nonatomic, assign) int idShop;
@property (nonatomic, strong) NSMutableArray *shopGalleries;
@property (nonatomic, strong) NSMutableArray *userGalleries;
@property (nonatomic, strong) NSMutableArray *comments;
@property (nonatomic, strong) NSMutableArray *events;

@end

@implementation ShopViewController

-(ShopViewController *)initWithIDShop:(int)idShop
{
    self=[super init];
    
    _idShop=idShop;
    
#if DEBUG
    _idShop=39352;
#endif
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [table registerShopGalleryTableCell];
    [table registerShopInfoTableCell];
    [table registerShopDescTableCell];
    [table registerShopAddressTableCell];
    [table registerShopContactTableCell];
    [table registerShopEventTableCell];
    [table registerShopUserGalleryTableCell];
    [table registerShopRelatedTableCell];
    
    [table showLoading];
    
    [self requestShopUser];
}

-(void) requestShopUser
{
    _opeShopUser=[[OperationShopUser alloc] initWithIDShop:_idShop userLat:userLat() userLng:userLng()];
    _opeShopUser.delegate=self;
    
    [_opeShopUser addToQueue];
}

#pragma mark ASIOperation Delegate

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[OperationShopUser class]])
    {
        [table removeLoading];
        
        OperationShopUser *ope=(id)operation;
        
        self.shopGalleries=ope.shopGalleries;
        
        [table beginUpdates];
        
        NSMutableArray *idx=[NSMutableArray array];
        
        [idx addObject:makeIndexPath(SHOP_CONTROLLER_CELL_TYPE_SHOP_GALLERY, 0)];
        [table reloadRowsAtIndexPaths:idx withRowAnimation:UITableViewRowAnimationNone];
        
        [table endUpdates];
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    
}

#pragma mark UITableView DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ((enum SHOP_CONTROLLER_CELL_TYPE)indexPath.row) {
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_ADDRESS:
            return [ShopAddressTableCell height];
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_CONTACT:
            return [ShopContactTableCell height];
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_DESC:
            return [ShopDescTableCell height];
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_EVENT:
            return [ShopEventTableCell height];
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_GALLERY:
            return [ShopGalleryTableCell height];
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_INFO:
            return [ShopInfoTableCell height];
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_RELATED:
            return [ShopRelatedTableCell height];
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_USER_GALLERY:
            return [ShopUserGalleryTableCell height];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ((enum SHOP_CONTROLLER_CELL_TYPE)indexPath.row) {
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_USER_GALLERY:
            return [tableView shopUserGalleryTableCell];
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_RELATED:
            return [tableView shopRelatedTableCell];
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_INFO:
            return [tableView shopInfoTableCell];
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_GALLERY:
        {
            ShopGalleryTableCell *cell=[tableView shopGalleryTableCell];
            
            [cell loadWithGalleries:_shopGalleries];
            
            return cell;
        }
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_EVENT:
            return [tableView shopEventTableCell];
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_DESC:
            return [tableView shopDescTableCell];
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_CONTACT:
            return [tableView shopContactTableCell];
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_ADDRESS:
            return [tableView shopAddressTableCell];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation TableShopInfo

-(void)setContentInset:(UIEdgeInsets)contentInset
{
    [super setContentInset:contentInset];
}

@end