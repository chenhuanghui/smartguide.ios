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
#import "GalleryFullViewController.h"
#import "KeyboardUtility.h"
#import "ShopCameraViewController.h"
#import "ShopUserController.h"

enum SHOP_USER_CELL_TYPE
{
    SHOP_USER_CELL_TYPE_SHOP_GALLERY=0,
    SHOP_USER_CELL_TYPE_SHOP_KM1_KM2_NONE=1,
    SHOP_USER_CELL_TYPE_SHOP_KMNEWS=2,
    SHOP_USER_CELL_TYPE_SHOP_INFO=3,
    SHOP_USER_CELL_TYPE_USER_GALLERY=4,
    SHOP_USER_CELL_TYPE_SHOP_COMMENT=5,
    SHOP_USER_CELL_TYPE_EMPTY_FILL=6,
};

@interface ShopUserViewController()<UITableViewDataSource, UITableViewDelegate,ASIOperationPostDelegate,ShopGalleryControllerCellDelegate,ShopKM1ControllerCellDelegate,ShopKM2ControllerCellDelegate,ShopInfoControllerCellDelegate,ShopCommentsControllerCellDelegate,ShopUserGalleryControllerCellDelegate,GalleryControllerDelegate,ShopCameraControllerDelegate,ShopDetailInfoControllerDelegate>
{
    __weak ShopGalleryControllerCell *shopGalleryCell;
    __weak ShopKMNewsControllerCell *shopKMNews;
    __weak ShopCommentsControllerCell *shopComments;
    
    ASIOperationShopUser *_opeShopUser;
    
    NSMutableArray *_cacheCells;
    float _commentsHeight;
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
        case SHOP_DATA_HOME_4:
        case SHOP_DATA_HOME_6:
            [self showLoading];
            break;
            
        case SHOP_DATA_SHOP_LIST:
            break;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:NOTIFICATION_SHOP_MANAGER_CLEAN object:nil];
}

-(void) reloadData
{
    [table reloadData];
}

-(void) reloadVisibleItems
{
    [table reloadData];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:true];
}

-(NSArray *)registerNotifications
{
    return @[UIKeyboardWillShowNotification, UIKeyboardWillHideNotification,NOTIFICATION_COMMENTS_FINISHED_TIME,NOTIFICATION_COMMENTS_FINISHED_TOP_AGREED,NOTIFICATION_COMMENTS_FINISHED_NEW_COMMENT];
}

-(void) scrollToItemAtIndexPath:(NSIndexPath*) idx
{
    if(idx)
    {
        CGRect rect=[table rectForRowAtIndexPath:idx];
        [table l_co_setY:rect.origin.y+table.l_v_y animate:true];
    }
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
            [self scrollToItemAtIndexPath:idx];
            float duration=[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
            
            [shopComments switchToMode:SHOP_COMMENT_MODE_EDIT animate:true duration:duration];
        }
    }
    else if([notification.name isEqualToString:UIKeyboardWillHideNotification])
    {
        if(self.navigationController.visibleViewController!=self)
            return;
        
        if(shopComments)
        {
            float duration=[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
            [shopComments switchToMode:SHOP_COMMENT_MODE_NORMAL animate:true duration:duration];
        }
    }
    else if([notification.name isEqualToString:NOTIFICATION_COMMENTS_FINISHED_TIME]
            || [notification.name isEqualToString:NOTIFICATION_COMMENTS_FINISHED_TOP_AGREED])
    {
        [self.view removeLoading];
        
        [shopComments clearInput];
        [self reloadVisibleItems];
        
        if(shopComments)
        {
            NSIndexPath *idx=[table indexPathForCell:shopComments];
            [self scrollToItemAtIndexPath:idx];
        }
    }
    else if([notification.name isEqualToString:NOTIFICATION_COMMENTS_FINISHED_NEW_COMMENT])
    {
        [self.view removeLoading];
        [self.view endEditing:true];
        
        [shopComments clearInput];
        [self reloadVisibleItems];
    }
    else if([notification.name isEqualToString:NOTIFICATION_SHOP_MANAGER_CLEAN])
    {
        if([notification.object integerValue]==_idShop)
        {
            [self.view showLoading];
            [self requestShopUser];
        }
    }
}

-(void) cacheCells
{
    if(!_cacheCells)
        _cacheCells=[NSMutableArray new];
    
    for(int i=0;i<[table numberOfRowsInSection:0];i++)
    {
        UITableViewCell *cell=[table cellForRowAtIndexPath:makeIndexPath(i, 0)];
        
        if([cell isKindOfClass:[ShopUserGalleryControllerCell class]])
            [_cacheCells addObject:cell];
        else
            [_cacheCells addObject:[NSNull null]];
    }
    
    _cacheCells=nil;
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
            [table showLoadingBelowIndexPath:makeIndexPath(0, 0)];
            table.scrollEnabled=false;
        }
    }
}

-(void) removeLoading
{
    [self.view removeLoading];
    [table removeLoading];
    table.scrollEnabled=true;
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

        [self reloadData];
        [self cacheCells];
        
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
    
    // info - address, map icon
    count++;
    
    // user gallery
    count++;
    
    // comments
    count++;
    
    // fill empty cell - dùng để scroll comment lên top
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
                    break;
                    
                case SHOP_PROMOTION_KM1:
                    return [ShopKM1ControllerCell heightWithKM1:_shop.km1];
                    
                case  SHOP_PROMOTION_KM2:
                    return [ShopKM2ControllerCell heightWithKM2:_shop.km2];
            }
            break;
            
        case SHOP_USER_CELL_TYPE_SHOP_KMNEWS:
            if(_shop.promotionNewObjects.count==0)
                break;
            else
                return [ShopKMNewsControllerCell heightWithKMNews:_shop.promotionNewObjects];
            
        case SHOP_USER_CELL_TYPE_SHOP_INFO:
            return [ShopInfoControllerCell heightWithShop:_shop];

        case SHOP_USER_CELL_TYPE_USER_GALLERY:
            return [ShopUserGalleryControllerCell height];
            
        case SHOP_USER_CELL_TYPE_SHOP_COMMENT:
        {
            ShopCommentsControllerCell *cell=[table shopCommentsControllerCell];
            [cell loadWithShop:_shop maxHeight:MAX(self.l_v_h,table.l_v_h)];
            [cell layoutSubviews];
            
            _commentsHeight=[cell suggestHeight];
            
            return [cell suggestHeight];
        }
            
        case SHOP_USER_CELL_TYPE_EMPTY_FILL:
        {
            float cmtHeight=_commentsHeight;
            
            if(cmtHeight>tableView.l_v_h+tableView.l_v_y)
                return 0;
            else
                return table.l_v_h+table.l_v_y-cmtHeight;
        }
    }
    
    return 0;
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
        {
            switch (_shop.enumPromotionType) {
                case SHOP_PROMOTION_NONE:
                    break;
                    
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
        }
            break;
            
        case SHOP_USER_CELL_TYPE_SHOP_KMNEWS:
        {
            if(_shop.promotionNewObjects.count>0)
            {
                ShopKMNewsControllerCell *cell=[tableView shopKMNewsControllerCell];
                
                [cell loadWithKMNews:_shop.promotionNewObjects maxHeight:table.l_v_h];
                shopKMNews=cell;
                
                return cell;
            }
        }
            break;
            
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
            
            [cell loadWithShop:_shop maxHeight:MAX(self.l_v_h,table.l_v_h)];
            
            shopComments=cell;
            
            return cell;
        }
            
        case SHOP_USER_CELL_TYPE_EMPTY_FILL:
        {
            UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
            cell.backgroundColor=[UIColor clearColor];
            cell.contentView.backgroundColor=[UIColor clearColor];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            return cell;
        }
    }
    
    return [UITableViewCell new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==SHOP_USER_CELL_TYPE_EMPTY_FILL)
        [self.view endEditing:true];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(shopGalleryCell)
    {
        [shopGalleryCell.superview bringSubviewToFront:shopGalleryCell];
        [shopGalleryCell scrollViewDidScroll:scrollView];
    }
    
    if(shopKMNews)
        [shopKMNews tableDidScroll:table];
    
    if(shopComments)
        [shopComments tableDidScroll:table];
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
    if(_shop.enumDataMode!=SHOP_DATA_FULL)
        return;
    
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
       [self scrollToItemAtIndexPath:[table indexPathForCell:shopComments]];
    
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
    [ShopManager shareInstanceWithShop:_shop].selectedUserGallery=gallery;
    
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

-(void)shopCameraControllerDidUploadPhoto:(ShopCameraViewController *)controller upload:(UserGalleryUpload *)upload
{
    [self.navigationController popToRootViewControllerAnimated:true];
    
    [[ShopManager shareInstanceWithShop:_shop] addUploadUserGallery:upload];
    [self reloadVisibleItems];
}

-(void)shopUserGalleryControllerCellTouchedUpload:(ShopUserGalleryControllerCell *)cell gallery:(UserGalleryUpload *)upload
{
    [ShopManager shareInstanceWithShop:_shop].selectedUserGallery=upload;
    
    UserGalleryViewController *vc=[[UserGalleryViewController alloc] initWithShop:_shop];
    vc.delegate=self;
    
    [self.navigationController pushViewController:vc animated:true];
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

-(void)shopDetailInfoControllerTouchedShop:(ShopDetailInfoViewController *)controller idShop:(int)idShop
{
    [self.delegate shopUserViewControllerTouchedIDShop:self idShop:idShop];
}

-(void)shopDetailInfoControllerTouchedURL:(ShopDetailInfoViewController *)controller url:(NSURL *)url
{
    [self.delegate shopUserViewControllerTouchedURL:self url:url];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_SHOP_MANAGER_CLEAN object:nil];
    [ShopManager clean:_shop];
    table.delegate=nil;
}

-(Shop *)shop
{
    return _shop;
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