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

@interface ShopCell : NSObject

@property (nonatomic, assign) enum SHOP_CONTROLLER_CELL_TYPE cellType;
@property (nonatomic, strong) id object;

@end

@interface ShopViewController ()<UITableViewDataSource, UITableViewDelegate, ASIOperationPostDelegate>
{
    OperationShopUser *_opeShopUser;
}

@property (nonatomic, assign) int idShop;
@property (nonatomic, strong) NSMutableArray *shopGalleries;
@property (nonatomic, strong) NSMutableArray *userGalleries;
@property (nonatomic, strong) NSMutableArray *comments;
@property (nonatomic, strong) NSMutableArray *events;
@property (nonatomic, strong) ShopInfo *shop;
@property (nonatomic, strong) NSMutableArray *cells;

@end

@implementation ShopViewController

-(ShopViewController *)initWithIDShop:(int)idShop
{
    self=[super init];
    
    _idShop=idShop;
    
#if DEBUG
    _idShop=39488;
#endif
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.cells=[NSMutableArray new];
    
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
        
        self.shop=ope.shop;
        self.shopGalleries=ope.shopGalleries;
        self.events=ope.shopEvents;
        
        [self.cells removeAllObjects];
        
        ShopCell *obj=[ShopCell new];
        obj.cellType=SHOP_CONTROLLER_CELL_TYPE_SHOP_GALLERY;
        obj.object=self.shop;
        
        [self.cells addObject:obj];
        
        obj=[ShopCell new];
        obj.cellType=SHOP_CONTROLLER_CELL_TYPE_SHOP_INFO;
        obj.object=self.shop;
        
        [self.cells addObject:obj];
        
        obj=[ShopCell new];
        obj.cellType=SHOP_CONTROLLER_CELL_TYPE_SHOP_DESC;
        obj.object=self.shop;
        
        [self.cells addObject:obj];
        
        obj=[ShopCell new];
        obj.cellType=SHOP_CONTROLLER_CELL_TYPE_SHOP_ADDRESS;
        obj.object=self.shop;
        
        [self.cells addObject:obj];
        
        obj=[ShopCell new];
        obj.cellType=SHOP_CONTROLLER_CELL_TYPE_SHOP_CONTACT;
        obj.object=self.shop;
        
        [self.cells addObject:obj];
        
        for(ShopInfoEvent *event in self.events)
        {
            obj=[ShopCell new];
            obj.cellType=SHOP_CONTROLLER_CELL_TYPE_SHOP_EVENT;
            obj.object=event;
            
            [self.cells addObject:obj];
        }
        
        obj=[ShopCell new];
        obj.cellType=SHOP_CONTROLLER_CELL_TYPE_SHOP_USER_GALLERY;
        obj.object=self.shop;
        
        [self.cells addObject:obj];
        
        obj=[ShopCell new];
        obj.cellType=SHOP_CONTROLLER_CELL_TYPE_SHOP_RELATED;
        obj.object=self.shop;
        
        [self.cells addObject:obj];

        [table reloadData];
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    
}

#pragma mark UITableView DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return MIN(_cells.count, 1);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cells.count;
}

-(float) cellHeightAtIndexPath:(NSIndexPath*) idx
{
    if(_cells.count<idx.row)
        return 0;
    
    ShopCell *obj=_cells[idx.row];
    
    switch (obj.cellType) {
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_ADDRESS:
            return [[table shopAddressTablePrototypeCell] calculatorHeight:obj.object];
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_CONTACT:
            return [ShopContactTableCell height];
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_DESC:
            return [[table shopDescTablePrototypeCell] calculatorHeight:obj.object];
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_EVENT:
            return [[table shopEventTablePrototypeCell] calculatorHeight:obj.object];
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_GALLERY:
            return [ShopGalleryTableCell height];
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_INFO:
            return [[table ShopInfoTablePrototypeCell] calculatorHeight:obj.object];
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_RELATED:
            return [ShopRelatedTableCell height];
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_USER_GALLERY:
            return [ShopUserGalleryTableCell height];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self cellHeightAtIndexPath:indexPath];
}

-(UITableViewCell*) cellForRowAtIndexPath:(NSIndexPath*) idx
{
    if(_cells.count<idx.row)
        return [table emptyCell];
    
    ShopCell *obj=[_cells objectAtIndex:idx.row];
    switch (obj.cellType) {
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_USER_GALLERY:
            return [table shopUserGalleryTableCell];
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_RELATED:
            return [table shopRelatedTableCell];
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_INFO:
        {
            ShopInfoTableCell *cell=[table shopInfoTableCell];
            
            [cell loadWithShop:obj.object];
            
            return cell;
        }
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_GALLERY:
        {
            ShopGalleryTableCell *cell=[table shopGalleryTableCell];
            
            [cell loadWithGalleries:_shopGalleries];
            
            return cell;
        }
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_EVENT:
        {
            ShopEventTableCell *cell=[table shopEventTableCell];
            
            [cell loadWithEvent:obj.object];
            
            return cell;
        }
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_DESC:
        {
            ShopDescTableCell *cell=[table shopDescTableCell];
            
            [cell loadWithShopInfo:obj.object];
            
            return cell;
        }
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_CONTACT:
        {
            ShopContactTableCell *cell=[table shopContactTableCell];
            
            [cell loadWithShopInfo:obj.object];
            
            return cell;
        }
            
        case SHOP_CONTROLLER_CELL_TYPE_SHOP_ADDRESS:
        {
            ShopAddressTableCell *cell=[table shopAddressTableCell];
            
            [cell loadWithShopInfo:obj.object];
            
            return cell;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self cellForRowAtIndexPath:indexPath];
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

@implementation ShopCell



@end