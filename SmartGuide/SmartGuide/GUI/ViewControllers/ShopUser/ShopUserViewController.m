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
#import "EmptyCollectionCell.h"
#import "KeyboardUtility.h"
#import "ShopCameraViewController.h"

enum SHOP_USER_CELL_TYPE
{
    SHOP_USER_CELL_TYPE_SHOP_GALLERY=0,
    SHOP_USER_CELL_TYPE_SHOP_KM1_KM2_NONE=1,
    SHOP_USER_CELL_TYPE_SHOP_KMNEWS=2,
    SHOP_USER_CELL_TYPE_SHOP_INFO=3,
    SHOP_USER_CELL_TYPE_USER_GALLERY=4,
    SHOP_USER_CELL_TYPE_SHOP_COMMENT=5,
};

@interface ShopUserViewController()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,ASIOperationPostDelegate,ShopGalleryControllerCellDelegate,ShopKM1ControllerCellDelegate,ShopKM2ControllerCellDelegate,ShopInfoControllerCellDelegate,ShopCommentsControllerCellDelegate,ShopUserGalleryControllerCellDelegate,GalleryControllerDelegate,ShopCameraControllerDelegate>
{
    __weak ShopGalleryControllerCell *shopGalleryCell;
    __weak ShopKMNewsControllerCell *shopKMNews;
    __weak ShopCommentsControllerCell *shopComments;
    
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
    
#if DEBUG
    _shop=[Shop shopWithIDShop:_idShop];
    if(_shop)
    {
        [_shop markDeleted];
        [[DataManager shareInstance] save];
    }
#endif
    
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
    [table registerEmptyCollectionCell];
    
    [self requestShopUser];
    
    switch (_shop.enumDataMode) {
        case SHOP_DATA_FULL:
            [self loadCells];
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

-(NSArray *)registerNotifications
{
    return @[UIKeyboardWillShowNotification, UIKeyboardWillHideNotification,NOTIFICATION_COMMENTS_FINISHED_TIME,NOTIFICATION_COMMENTS_FINISHED_TOP_AGREED,NOTIFICATION_COMMENTS_FINISHED_NEW_COMMENT];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:UIKeyboardWillShowNotification])
    {
        if(self.navigationController.visibleViewController!=self)
            return;
        
        if(shopComments)
        {
            NSIndexPath *idx=[table indexPathForCell:shopComments];
            [table scrollToItemAtIndexPath:idx atScrollPosition:UICollectionViewScrollPositionNone animated:true];
            float duration=[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
            
            [shopComments switchToMode:SHOP_COMMENT_MODE_EDIT animate:true duration:duration];
        }
    }
    else if([notification.name isEqualToString:UIKeyboardWillHideNotification])
    {
        if(self.navigationController.visibleViewController!=self)
            return;
        
        float duration=[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        
        if(shopComments)
            [shopComments switchToMode:SHOP_COMMENT_MODE_NORMAL animate:true duration:duration];
    }
    else if([notification.name isEqualToString:NOTIFICATION_COMMENTS_FINISHED_TIME])
    {
        [self.view removeLoading];
        
        if(shopComments)
        {
            [table reloadItemsAtIndexPaths:@[[table indexPathForCell:shopComments]]];
        }
    }
    else if([notification.name isEqualToString:NOTIFICATION_COMMENTS_FINISHED_TOP_AGREED])
    {
        [self.view removeLoading];
        
        if(shopComments)
        {
            [table reloadItemsAtIndexPaths:@[[table indexPathForCell:shopComments]]];
        }
    }
    else if([notification.name isEqualToString:NOTIFICATION_COMMENTS_FINISHED_NEW_COMMENT])
    {
        [self.view removeLoading];
        
        [self.view endEditing:true];
        
        if(shopComments)
        {
            NSIndexPath *idx=[table indexPathForCell:shopComments];
            [table reloadItemsAtIndexPaths:@[idx]];
        }
    }
}

-(void) loadCells
{
    for(int i=0;i<[table numberOfItemsInSection:0];i++)
    {
        [self collectionView:table cellForItemAtIndexPath:makeIndexPath(i,0)];
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
    _opeShopUser.delegate=self;
    
    [_opeShopUser addToQueue];
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
        
        [self loadCells];
        
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

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
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
    
    // info - address, map icon
    count++;
    
    // user gallery
    count++;
    
    // comments
    count++;
    
    return count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case SHOP_USER_CELL_TYPE_SHOP_GALLERY:
            return CGSizeMake(collectionView.l_v_w,[ShopGalleryControllerCell height]);
            
        case SHOP_USER_CELL_TYPE_SHOP_KM1_KM2_NONE:
            switch (_shop.enumPromotionType) {
                case SHOP_PROMOTION_NONE:
                    break;
                    
                case SHOP_PROMOTION_KM1:
                    return CGSizeMake(collectionView.l_v_w,[ShopKM1ControllerCell heightWithKM1:_shop.km1]);
                    
                case  SHOP_PROMOTION_KM2:
                    return CGSizeMake(collectionView.l_v_w,[ShopKM2ControllerCell heightWithKM2:_shop.km2]);
            }
            break;
            
        case SHOP_USER_CELL_TYPE_SHOP_KMNEWS:
            if(_shop.promotionNewObjects.count==0)
                break;
            else
                return CGSizeMake(collectionView.l_v_w,[ShopKMNewsControllerCell heightWithKMNews:_shop.promotionNewObjects]);
            
        case SHOP_USER_CELL_TYPE_SHOP_INFO:
            return CGSizeMake(collectionView.l_v_w, [ShopInfoControllerCell heightWithShop:_shop]);

        case SHOP_USER_CELL_TYPE_USER_GALLERY:
            return CGSizeMake(collectionView.l_v_w, [ShopUserGalleryControllerCell height]);
            
        case SHOP_USER_CELL_TYPE_SHOP_COMMENT:
            return CGSizeMake(collectionView.l_v_w, MAX([ShopCommentsControllerCell heightWithShop:_shop sort:SORT_SHOP_COMMENT_TOP_AGREED], self.l_v_h));
    }
    
    return CGSizeMake(1, 0);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)tableView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case SHOP_USER_CELL_TYPE_SHOP_GALLERY:
        {
            ShopGalleryControllerCell *cell=[tableView shopGalleryControllerCellForIndexPath:indexPath];
            cell.delegate=self;
            
            [cell loadWithShop:_shop];
            shopGalleryCell=cell;
            return cell;
        }
            break;
            
        case SHOP_USER_CELL_TYPE_SHOP_KM1_KM2_NONE:
        {
            switch (_shop.enumPromotionType) {
                case SHOP_PROMOTION_NONE:
                    break;
                    
                case SHOP_PROMOTION_KM1:
                {
                    ShopKM1ControllerCell *cell=[tableView shopKM1ControllerCellForIndexPath:indexPath];
                    cell.delegate=self;
                    
                    [cell loadWithKM1:_shop.km1];
                    return cell;
                }
                    break;
                    
                case SHOP_PROMOTION_KM2:
                {
                    ShopKM2ControllerCell *cell=[tableView shopKM2ControllerCellForIndexPath:indexPath];
                    cell.delegate=self;
                    
                    [cell loadWithKM2:_shop.km2];
                    return cell;
                }
                    break;
            }
        }
            break;
            
        case SHOP_USER_CELL_TYPE_SHOP_KMNEWS:
        {
            if(_shop.promotionNewObjects.count>0)
            {
                ShopKMNewsControllerCell *cell=[tableView shopKMNewsControllerCellForIndexPath:indexPath];
                
                [cell loadWithKMNews:_shop.promotionNewObjects maxHeight:table.l_v_h];
                shopKMNews=cell;
                
                return cell;
            }
        }
            break;
            
        case SHOP_USER_CELL_TYPE_SHOP_INFO:
        {
            ShopInfoControllerCell *cell=[tableView shopInfoControllerCellWithIndexPath:indexPath];
            cell.delegate=self;
            
            [cell loadWithShop:_shop];
            return cell;
        }
            break;
            
        case SHOP_USER_CELL_TYPE_USER_GALLERY:
        {
            ShopUserGalleryControllerCell *cell=[table shopUserGalleryControllerCellForIndexPath:indexPath];
            cell.delegate=self;
            
            [cell loadWithShop:_shop];
            return cell;
        }
            break;
            
        case SHOP_USER_CELL_TYPE_SHOP_COMMENT:
        {
            ShopCommentsControllerCell *cell=[tableView shopCommentsControllerCellForIndexPath:indexPath];
            cell.delegate=self;
            
            [cell loadWithShop:_shop maxHeight:MAX(tableView.l_v_h,self.l_v_h)];
            
            shopComments=cell;
            
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    return [tableView emptyCollectionCellForIndexPath:indexPath];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSIndexPath *idx=nil;
    CGRect rect=CGRectZero;
    if(shopGalleryCell)
    {
        idx=[table indexPathForCell:shopGalleryCell];
        rect=[table rectForItemAtIndexPath:idx];
        
        [shopGalleryCell.superview bringSubviewToFront:shopGalleryCell];
        
        if(idx)
            [shopGalleryCell scrollViewDidScroll:scrollView];
    }
    
    if(shopKMNews)
    {
        idx=[table indexPathForCell:shopKMNews];
        rect=[table rectForItemAtIndexPath:idx];
        
        if(idx)
            [shopKMNews tableDidScroll:table];
    }
    
    if(shopComments)
    {
        idx=[table indexPathForCell:shopComments];
        rect=[table rectForItemAtIndexPath:idx];
        
        if(idx)
            [shopComments tableDidScroll:table];
    }
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
    if(sort==[ShopManager shareInstanceWithShop:_shop].sortComments)
        return;
    
    if(shopComments)
        [table scrollToItemAtIndexPath:[table indexPathForCell:shopComments] atScrollPosition:UICollectionViewScrollPositionNone animated:true];
    
    [self.view showLoading];
    [[ShopManager shareInstanceWithShop:_shop] requestCommentWithSort:sort];
}

-(void)shopCommentsControllerCellUserComment:(ShopCommentsControllerCell *)cell comment:(NSString *)comment
{
    [self.view showLoading];
    
    [[ShopManager shareInstanceWithShop:_shop] newCommentWithComment:comment];
}

-(void)shopUserGalleryControllerCellTouchedGallery:(ShopUserGalleryControllerCell *)cell gallery:(ShopUserGallery *)gallery
{
    UserGalleryViewController *vc=[[UserGalleryViewController alloc] initWithShop:_shop];
    vc.delegate=self;
    
    [self.navigationController pushViewController:vc animated:true];
}

-(void)shopUserGalleryControllerCellTouchedMakePicture:(ShopUserGalleryControllerCell *)cell
{
    ShopCameraViewController *vc=[[ShopCameraViewController alloc] initWithShop:_shop];
    vc.delegate=self;
    
    [self.navigationController pushViewController:vc animated:true];
}

-(void)shopCameraControllerDidUploadPhoto:(ShopCameraViewController *)controller
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

@end

@implementation TableShopUser

-(void)setContentOffset:(CGPoint)contentOffset
{
    if(contentOffset.y<-SHOP_USER_ANIMATION_ALIGN_Y)
        contentOffset.y=-SHOP_USER_ANIMATION_ALIGN_Y;
    
    [super setContentOffset:contentOffset];
}

@end