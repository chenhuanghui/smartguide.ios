//
//  ShopUserViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopUserViewController.h"
#import "ASIOperationShopUser.h"
#import "ShopGalleryControllerCell.h"
#import "ShopKM1ControllerCell.h"
#import "ShopKM2ControllerCell.h"
#import "ShopKMNewsControllerCell.h"
#import "ShopInfoControllerCell.h"
#import "ShopCommentsControllerCell.h"
#import "ShopuserGalleryControllerCell.h"
#import "ShopManager.h"
#import "GalleryViewController.h"
#import "ShopDetailInfoViewController.h"
#import "ShopMap/ShopMapViewController.h"
#import "QRCodeViewController.h"
#import "GalleryFullViewController.h"

enum SHOP_USER_CELL_TYPE
{
    SHOP_USER_CELL_TYPE_SHOP_GALLERY=0,
    SHOP_USER_CELL_TYPE_SHOP_KM1_KM2_NONE=1,
    SHOP_USER_CELL_TYPE_SHOP_KMNEWS=2,
    SHOP_USER_CELL_TYPE_SHOP_INFO=3,
    SHOP_USER_CELL_TYPE_USER_GALLERY=4,
    SHOP_USER_CELL_TYPE_SHOP_COMMENT=5,
};

@interface ShopUserViewController()<UITableViewDataSource,UITableViewDelegate,ASIOperationPostDelegate,ShopGalleryControllerCellDelegate,ShopKM1ControllerCellDelegate,ShopKM2ControllerCellDelegate,ShopInfoControllerCellDelegate,ShopCommentsControllerCellDelegate,ShopUserGalleryControllerCellDelegate,GalleryControllerDelegate>
{
    __strong ShopGalleryControllerCell *shopGalleryCell;
    
    ASIOperationShopUser *_opeShopUser;
}

@end

@implementation ShopUserViewController

-(ShopUserViewController *)initWithShopUser:(Shop *)shop
{
    self = [super initWithNibName:@"ShopUserViewController" bundle:nil];
    if (self) {
        _shop=shop;
        _idShop=_shop.idShop.integerValue;
    }
    return self;
}

-(ShopUserViewController *)initWithIDShop:(int)idShop
{
    self=[super initWithNibName:@"ShopUserViewController" bundle:nil];
    
    _idShop=idShop;
    _shop=[Shop makeWithIDShop:_idShop];
    if([_shop hasChanges])
        [[DataManager shareInstance] save];
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];

    [table registerShopGalleryControllerCell];
    [table registerShopKM1ControllerCell];
    [table registerShopKM2ControllerCell];
    [table registerShopKMNewsControllerCell];
    [table registerShopInfoControllerCell];
    [table registerShopUserGalleryControllerCell];
    [table registerShopCommentsControllerCell];
    
    [self requestShopUser];
    
    switch (_shop.enumDataMode) {
        case SHOP_DATA_FULL:
            
            break;
            
        case SHOP_DATA_HOME_8:
            break;
            
        case SHOP_DATA_IDSHOP:
            [self showLoading];
            break;
            
        case SHOP_DATA_SHOP_LIST:
            break;
    }
}

-(void) showLoading
{
    if([table numberOfSections]==0)
    {
        [self.view showLoading];
    }
    else if([table numberOfSections]>0)
    {
        if(_shop.enumDataMode!=SHOP_DATA_FULL)
        {
            CGRect rect=[table rectForSection:0];
            rect.origin.y+=rect.size.height;
            rect.size.height=MAX(table.contentSize.height,table.l_v_h)-rect.size.height;
            [table showLoadingInsideFrame:rect];
        }
    }
}

-(void) removeLoading
{
    [self.view removeLoading];
    [table removeLoading];
}

-(void) requestShopUser
{
    if(_opeShopUser)
        return;
    
    _opeShopUser=[[ASIOperationShopUser alloc] initWithIDShop:_idShop userLat:userLat() userLng:userLng()];
    _opeShopUser.delegatePost=self;
    
    [_opeShopUser startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopUser class]])
    {
        [self removeLoading];
        
        _shop=_opeShopUser.shop;
        [ShopManager shareInstanceWithShop:_shop];
        [[ShopManager shareInstanceWithShop:_shop] makeData];

        [table reloadData];
        
        _opeShopUser=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopUser class]])
    {
        _opeShopUser=nil;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count=0;
    
    // shop gallery
    count++;
    
    if(_shop.enumDataMode!=SHOP_DATA_FULL)
        return count;
    
    // km1, km2, no km
    count++;
    
    // km news. Nếu không có return [UITableViewCell new];
    count++;
    
    return count;
    
    // info - address, map icon
    count++;
    
    // user gallery
    count++;
    
    // comments
    count++;
    
    return count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case SHOP_USER_CELL_TYPE_SHOP_GALLERY:
            return [ShopGalleryControllerCell height];
            
        case SHOP_USER_CELL_TYPE_SHOP_KM1_KM2_NONE:
            switch (_shop.enumPromotionType) {
                case SHOP_PROMOTION_NONE:
                    return 0;
                    
                case SHOP_PROMOTION_KM1:
                    return [ShopKM1ControllerCell heightWithKM1:_shop.km1];
                    
                case  SHOP_PROMOTION_KM2:
                    return [ShopKM2ControllerCell heightWithKM2:_shop.km2];
            }
            
            return 0;
            
        case SHOP_USER_CELL_TYPE_SHOP_KMNEWS:
            if(_shop.promotionNewObjects.count==0)
                return 0;
            else
                return [ShopKMNewsControllerCell heightWithKMNews:_shop.promotionNewObjects];
            
        case SHOP_USER_CELL_TYPE_SHOP_INFO:
            return [ShopInfoControllerCell heightWithShop:_shop];
            
        case SHOP_USER_CELL_TYPE_USER_GALLERY:
            return [ShopUserGalleryControllerCell height];
            
        case SHOP_USER_CELL_TYPE_SHOP_COMMENT:
            return [ShopCommentsControllerCell heightWithShop:_shop sort:SORT_SHOP_COMMENT_TOP_AGREED];
            
        default:
            return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case SHOP_USER_CELL_TYPE_SHOP_GALLERY:
        {
            ShopGalleryControllerCell *cell=[tableView shopGalleryControllerCell];
            cell.delegate=self;
            
            [cell loadWithShop:_shop];
            shopGalleryCell=cell;
            return cell;
        }
            
        case SHOP_USER_CELL_TYPE_SHOP_KM1_KM2_NONE:
            
            switch (_shop.enumPromotionType) {
                case SHOP_PROMOTION_NONE:
                    return [UITableViewCell new];
                    
                case SHOP_PROMOTION_KM1:
                {
                    ShopKM1ControllerCell *cell=[tableView shopKM1ControllerCell];
                    cell.delegate=self;
                    
                    [cell loadWithKM1:_shop.km1];
                    return cell;
                }
                    
                case SHOP_PROMOTION_KM2:
                {
                    ShopKM2ControllerCell *cell=[tableView shopKM2ControllerCell];
                    cell.delegate=self;
                    
                    [cell loadWithKM2:_shop.km2];
                    return cell;
                }
            }
            
        case SHOP_USER_CELL_TYPE_SHOP_KMNEWS:
        {
            if(_shop.promotionNewObjects.count==0)
                return [UITableViewCell new];
            else
            {
                ShopKMNewsControllerCell *cell=[tableView shopKMNewsControllerCell];
                
                [cell loadWithKMNews:_shop.promotionNewObjects maxHeight:table.l_v_h];
                return cell;
            }
        }
            
        case SHOP_USER_CELL_TYPE_SHOP_INFO:
        {
            ShopInfoControllerCell *cell=[tableView shopInfoControllerCell];
            cell.delegate=self;
            
            [cell loadWithShop:_shop];
            return cell;
        }
            
        case SHOP_USER_CELL_TYPE_USER_GALLERY:
        {
            ShopUserGalleryControllerCell *cell=[table shopUserGalleryControllerCell];
            cell.delegate=self;
            
            [cell loadWithShop:_shop];
            return cell;
        }
            
        case SHOP_USER_CELL_TYPE_SHOP_COMMENT:
        {
            ShopCommentsControllerCell *cell=[tableView shopCommentsControllerCell];
            cell.delegate=self;
            
            [cell loadWithShop:_shop sort:SORT_SHOP_COMMENT_TOP_AGREED maxHeight:tableView.l_v_h];
            return cell;
        }
            
        default:
            return [UITableViewCell new];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([cell isKindOfClass:[ShopGalleryControllerCell class]])
    {
        [cell.superview bringSubviewToFront:cell];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(shopGalleryCell)
        [shopGalleryCell scrollViewDidScroll:scrollView];
}

#pragma mark SHOP USER CELL DELEGATE

-(void)shopGalleryControllerCellTouchedCover:(ShopGalleryControllerCell *)cell object:(ShopGallery *)gallery
{
    [ShopManager shareInstanceWithShop:_shop].selectedShopGallery=gallery;
    
    
    ShopGalleryViewController *vc=[[ShopGalleryViewController alloc] initWithShop:_shop];
    vc.delegate=self;
    
    [self.navigationController pushViewController:vc animated:true];
}

-(void)shopGalleryControllerCellTouchedMoreInfo:(ShopGalleryControllerCell *)cell
{
    ShopDetailInfoViewController *vc=[[ShopDetailInfoViewController alloc] initWithShop:_shop];
    vc.delegate=self;
    
    [self.navigationController pushViewController:vc animated:true];
}

-(void)shopInfoControllerCellTouchedMap:(ShopInfoControllerCell *)cell
{
    ShopMapViewController *vc=[[ShopMapViewController alloc] initWithShop:_shop];
    vc.delegate=self;
    
    [self.navigationController pushViewController:vc animated:true];
}

-(void)shopKM1ControllerCellTouchedScan:(ShopKM1ControllerCell *)km1
{
    [self.delegate shopUserViewControllerTouchedQRCode:self];
}

-(void)shopKM2ControllerCellDelegateTouchedScan:(ShopKM2ControllerCell *)cell
{
    [self.delegate shopUserViewControllerTouchedQRCode:self];    
}

-(void)shopCommentsControllerCellChangeSort:(ShopCommentsControllerCell *)cell sort:(enum SORT_SHOP_COMMENT)sort
{
    
}

-(void)shopCommentsControllerCellUserComment:(ShopCommentsControllerCell *)cell comment:(NSString *)comment
{
    
}

-(void)shopUserGalleryControllerCellTouchedGallery:(ShopUserGalleryControllerCell *)cell gallery:(ShopUserGallery *)gallery
{
    UserGalleryViewController *vc=[[UserGalleryViewController alloc] initWithShop:_shop];
    vc.delegate=self;
    
    [self.navigationController pushViewController:vc animated:true];
}

-(void)shopUserGalleryControllerCellTouchedMakePicture:(ShopUserGalleryControllerCell *)cell
{
    
}

-(void)shopUserGalleryControllerCellTouchedUpload:(ShopUserGalleryControllerCell *)cell gallery:(UserGalleryUpload *)upload
{
    
}

-(void)galleryControllerTouchedGallery:(GalleryViewController *)controller gallery:(id)gallery
{
    if([gallery isKindOfClass:[ShopGallery class]])
    {
        [ShopManager shareInstanceWithShop:_shop].selectedShopGallery=gallery;
        
        ShopGalleryFullViewController *vc=[[ShopGalleryFullViewController alloc] initWithShop:_shop];
        [self.delegate shopUserViewControllerPresentGallery:self galleryController:vc];
    }
    else
    {
        [ShopManager shareInstanceWithShop:_shop].selectedUserGallery=gallery;
        
        UserGalleryFullViewController *vc=[[UserGalleryFullViewController alloc] initWithShop:_shop];
        [self.delegate shopUserViewControllerPresentGallery:self galleryController:vc];
    }
}

-(UITableView *)table
{
    return table;
}

@end

@implementation TableShopUser
@synthesize offset;

-(void)setContentOffset:(CGPoint)contentOffset
{
    if(contentOffset.y<-SHOP_USER_ANIMATION_ALIGN_Y)
        contentOffset.y=-SHOP_USER_ANIMATION_ALIGN_Y;
    
    offset=CGPointMake(contentOffset.x-self.contentOffset.x, contentOffset.y-self.contentOffset.y);
    
    [super setContentOffset:contentOffset];
}

@end