//
//  ShopDetailInfoViewController.m
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoViewController.h"
#import "GUIManager.h"
#import "ShopDetailInfoCell.h"
#import "ShopDetailInfoBlockCell.h"
#import "ShopDetailInfoHeaderView.h"
#import "ShopDetailInfoDescCell.h"
#import "ASIOperationShopDetailInfo.h"
#import "Shop.h"
#import "ShopList.h"
#import "ShopDetailBGView.h"
#import "ImageManager.h"
#import "WebViewController.h"

enum SHOP_DETAIL_INFO_SECTION_TYPE
{
    SHOP_DETAIL_INFO_SECTION_TYPE_INFO=0,
    SHOP_DETAIL_INFO_SECTION_TYPE_DESC=1,
    SHOP_DETAIL_INFO_SECTION_TYPE_BLOCK=2,
};

@interface ShopDetailInfoViewController ()<ShopDetailInfoDescCellDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,ASIOperationPostDelegate>
{
    ASIOperationShopDetailInfo *_operation;
    enum SHOP_DETAIL_INFO_DESCRIPTION_MODE _descMode;
}

@end

@implementation ShopDetailInfoViewController

- (ShopDetailInfoViewController *)initWithShop:(Shop *)shop
{
    self = [super initWithNibName:@"ShopDetailInfoViewController" bundle:nil];
    if (self) {
        // Custom initialization
        _shop=shop;
    }
    return self;
}

-(void)dealloc
{
    if(_operation)
    {
        [_operation clearDelegatesAndCancel];
        _operation=nil;
    }
    
    table.delegate=nil;
}

-(void) storeRect
{
    _coverFrame=coverView.frame;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self storeRect];
    
    [table registerShopDetailInfoCell];
    [table registerShopDetailInfoBlockCell];
    [table registerShopDetailInfoDescCell];
    
    _infos=[NSMutableArray new];
    _didLoadShopDetail=false;
    _descMode=SHOP_DETAIL_INFO_DESCRIPTION_NORMAL;
    
    [self requestShopDetailInfo];
    
    if(_shop.shopGalleriesObjects.count>0)
    {
        ShopGallery *gallery=_shop.shopGalleriesObjects[0];
        
        [imgvCover loadShopCoverWithURL:gallery.cover];
    }
    
    [self showLoading];
}

-(void)viewWillAppearOnce
{
    [self reloadData];
}

-(void) requestShopDetailInfo
{
    _operation=[[ASIOperationShopDetailInfo alloc] initWithIDShop:_shop.idShop.integerValue userLat:userLat() userLng:userLng()];
    _operation.delegate=self;
    _operation.fScreen=SCREEN_CODE_SHOP_USER;
    
    [_operation addToQueue];
}

-(void) showLoading
{
    
}

-(void) removeLoading
{
    
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopDetailInfo class]])
    {
        [self removeLoading];
        ASIOperationShopDetailInfo *ope=(ASIOperationShopDetailInfo*) operation;
        
        [_infos addObjectsFromArray:ope.infos];
        _didLoadShopDetail=true;
        
        [self reloadData];
        
        _operation=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopDetailInfo class]])
    {
        _operation=nil;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView==table)
    {
        if(scrollView.offsetYWithInsetTop<0)
            [coverView l_v_setY:_coverFrame.origin.y+scrollView.offsetYWithInsetTop/4];
        else
        {
            float y=_coverFrame.origin.y+scrollView.offsetYWithInsetTop/4;
            
            y=MIN(0,y);
            
            [coverView l_v_setY:y];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // address, shop name
    int count=1;
    
    // description
    count++;
    
    // các block info
    count+=_infos.count;
    
    return count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch ((enum SHOP_DETAIL_INFO_SECTION_TYPE) section) {
        case SHOP_DETAIL_INFO_SECTION_TYPE_INFO: //address
            return 1;
            
        case SHOP_DETAIL_INFO_SECTION_TYPE_DESC: //desc
            return 1;
            
        case SHOP_DETAIL_INFO_SECTION_TYPE_BLOCK:
            return 1;
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ((enum SHOP_DETAIL_INFO_SECTION_TYPE) indexPath.section) {
        case SHOP_DETAIL_INFO_SECTION_TYPE_INFO:
        {
            ShopDetailInfoCell *cell=[tableView shopDetailInfoCell];
            
            [cell loadWithShop:_shop];
            [cell layoutSubviews];
            
            return [cell suggestHeight];
        }
            
        case SHOP_DETAIL_INFO_SECTION_TYPE_DESC:
        {
                ShopDetailInfoDescCell *cell=[tableView shopDetailInfoDescCell];
                
                [cell loadWithShop:_shop mode:_descMode];
                [cell layoutSubviews];
                
                return [cell suggestHeight];
        }
            
        case SHOP_DETAIL_INFO_SECTION_TYPE_BLOCK:
        {
            ShopDetailInfoBlockCell *cell=[tableView shopDetailInfoBlockCell];
            
            [cell loadWithInfoObject:_infos[indexPath.section-2]];
            [cell layoutSubviews];
            
            return [cell suggestHeight];
        }
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ((enum SHOP_DETAIL_INFO_SECTION_TYPE)indexPath.section) {
        case SHOP_DETAIL_INFO_SECTION_TYPE_INFO:
        {
            ShopDetailInfoCell *cell=[table shopDetailInfoCell];
            
            [cell loadWithShop:_shop];
            
            return cell;
        }
            
        case SHOP_DETAIL_INFO_SECTION_TYPE_DESC:
        {
            ShopDetailInfoDescCell *cell=[tableView shopDetailInfoDescCell];
            cell.delegate=self;
            
            [cell loadWithShop:_shop mode:_descMode];
            
            return cell;
        }
            
        case SHOP_DETAIL_INFO_SECTION_TYPE_BLOCK:
        {
            ShopDetailInfoBlockCell *cell=[tableView shopDetailInfoBlockCell];
            [cell loadWithInfoObject:_infos[indexPath.section-2]];

            return cell;
        }
    }
    
    return [tableView emptyCell];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch ((enum SHOP_DETAIL_INFO_SECTION_TYPE) section) {
        case SHOP_DETAIL_INFO_SECTION_TYPE_INFO:
            return 0;
        case SHOP_DETAIL_INFO_SECTION_TYPE_DESC:
            return [ShopDetailInfoHeaderView height];
            
        default:
            return [ShopDetailInfoHeaderView height];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section==tableView.numberOfSections-1)
        return 5;
    
    return 25;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v=[UIView new];
    v.backgroundColor=[UIColor clearColor];
    return v;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [UIView new];
            
        default:
        {
            NSString *title=@"";
            
            if(section==1)
                title=@"GIỚI THIỆU";
            else
                title=[_infos[section-2] header];
            
            ShopDetailInfoHeaderView *headerView=[[ShopDetailInfoHeaderView alloc] initWithTitle:title];
            headerView.section=section;
            
            headerView.frame=[tableView rectForHeaderInSection:section];
            
            return headerView;
        }
    }
}

-(void)shopDetailInfoDescCellTouchedReadLess:(ShopDetailInfoDescCell *)cell
{
    _descMode=SHOP_DETAIL_INFO_DESCRIPTION_NORMAL;
    [table beginUpdates];
    [table endUpdates];
}

-(void)shopDetailInfoDescCellTouchedReadMore:(ShopDetailInfoDescCell *)cell
{
    _descMode=SHOP_DETAIL_INFO_DESCRIPTION_FULL;
    [table beginUpdates];
    [table endUpdates];
}

-(void) reloadData
{
    [table reloadData];
}

@end