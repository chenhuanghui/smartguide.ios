//
//  SUShopGalleryCell.m
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopGalleryControllerCell.h"
#import "ShopGalleryCell.h"
#import "Utility.h"
#import "ImageManager.h"
#import "GUIManager.h"
#import "LoadingMoreCollectionCell.h"
#import "ShopManager.h"

@interface ShopGalleryControllerCell()<UIScrollViewDelegate,ButtonLoveDelegate,ASIOperationPostDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation ShopGalleryControllerCell

-(void)loadWithShop:(Shop *)shop
{
    _shop=shop;
    
    switch (shop.enumDataMode) {
            
        case SHOP_DATA_IDSHOP:
        case SHOP_DATA_HOME_4:
        case SHOP_DATA_HOME_6:
            
            break;
            
        case SHOP_DATA_HOME_8:
        case SHOP_DATA_SHOP_LIST:
            
            lblShopName.text=shop.shopName;
            lblShopType.text=shop.shopTypeDisplay;
            lblNumOfComment.text=shop.numOfComment;
            lblNumOfView.text=shop.numOfView;
            
            [btnLove setLoveStatus:shop.enumLoveStatus withNumOfLove:shop.numOfLove animate:false];
            [imgvShopLogo loadShopLogoWithURL:shop.logo];
            
            [collection reloadData];
            
            break;
            
        case SHOP_DATA_FULL:
            
            lblShopName.text=shop.shopName;
            lblShopType.text=shop.shopTypeDisplay;
            lblNumOfComment.text=shop.numOfComment;
            lblNumOfView.text=shop.numOfView;
            
            [btnLove setLoveStatus:shop.enumLoveStatus withNumOfLove:shop.numOfLove animate:false];
            [imgvShopLogo loadShopLogoWithURL:shop.logo];
            
            pageControl.numberOfPages=shop.shopGalleriesObjects.count;
            [collection reloadData];
            
            break;
    }
}

+(NSString *)reuseIdentifier
{
    return @"ShopGalleryControllerCell";
}

+(float)height
{
    return 327;
}

-(void) requestShopGallery
{
    [[ShopManager shareInstanceWithShop:_shop] requestShopGallery];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView==collection)
    {
        [pageControl scrollViewDidScroll:scrollView isHorizontal:false];
        
        for(ShopGalleryCell *cell in collection.visibleCells)
        {
            if([cell isKindOfClass:[ShopGalleryCell class]])
                [cell collectionViewDidScroll:collection indexPath:[collection indexPathForCell:cell]];
        }
    }
    else
    {
        [collection l_v_setY:43.f+scrollView.contentOffset.y/2];
    }
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if(_shop.shopGalleryCover.length>0
       || _shop.shopGalleriesObjects.count>0)
        return 1;
    
    return 0;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (_shop.enumDataMode) {
        case SHOP_DATA_HOME_8:
        case SHOP_DATA_SHOP_LIST:
            
            if(_shop.shopGalleryCover.length>0)
                return 1;
            else
                return 0;
            
        case SHOP_DATA_FULL:
            return [ShopManager shareInstanceWithShop:_shop].shopGalleries.count+[ShopManager shareInstanceWithShop:_shop].canLoadMoreShopGallery;
            
        case SHOP_DATA_IDSHOP:
        case SHOP_DATA_HOME_6:
        case SHOP_DATA_HOME_4:
            return 0;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([ShopManager shareInstanceWithShop:_shop].canLoadMoreShopGallery && indexPath.row==[collection numberOfItemsInSection:indexPath.section]-1)
    {
        if(![ShopManager shareInstanceWithShop:_shop].isLoadingMoreShopGallery)
        {
            [self requestShopGallery];
        }
        
        return [collectionView loadingMoreCellAtIndexPath:indexPath];
    }
    
    ShopGalleryCell *cell=[collectionView shopGalleryCellForIndexPath:indexPath];
    
    switch (_shop.enumDataMode) {
        case SHOP_DATA_HOME_8:
        case SHOP_DATA_SHOP_LIST:
            [cell loadImage:_shop.shopGalleryCover];
            break;
            
        case SHOP_DATA_FULL:
        {
            ShopGallery *gallery=[ShopManager shareInstanceWithShop:_shop].shopGalleries[indexPath.row];
            
            [cell loadImage:gallery.cover];
        }
            break;
            
        case SHOP_DATA_IDSHOP:
        case SHOP_DATA_HOME_4:
        case SHOP_DATA_HOME_6:
            break;
    }
    
    [cell collectionViewDidScroll:collection indexPath:indexPath];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView cellForItemAtIndexPath:indexPath];
    
    if(![cell isKindOfClass:[ShopGalleryCell class]])
        return;
    
    [self.delegate shopGalleryControllerCellTouchedCover:self object:[ShopManager shareInstanceWithShop:_shop].shopGalleries[indexPath.row]];
}

-(void) reloadImage:(NSNotification*) notification
{
    [collection reloadData];
    pageControl.numberOfPages=_shop.shopGalleriesObjects.count;
    [self scrollViewDidScroll:collection];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadImage:) name:NOTIFICATION_GALLERY_FINISED_SHOP object:nil];
    
    pageControl.dotColorCurrentPage=[UIColor whiteColor];
    pageControl.dotColorOtherPage=[[UIColor whiteColor] colorWithAlphaComponent:0.5];
    
    collection.collectionViewFlowLayout.minimumLineSpacing=0;
    collection.collectionViewFlowLayout.minimumInteritemSpacing=0;
    [collection registerShopGalleryCell];
    [collection registerLoadingMoreCell];
    
    ButtonLove *love=[ButtonLove new];
    [love l_v_setO:CGPointMake(98, 288)];
    love.delegate=self;
    
    [self.contentView addSubview:love];
    
    btnLove=love;
}

-(void) love
{
    if(_operationLoveShop)
    {
        [_operationLoveShop clearDelegatesAndCancel];
        _operationLoveShop=nil;
    }
    
    switch (_shop.enumLoveStatus) {
        case LOVE_STATUS_LOVED:
            _shop.loveStatus=@(LOVE_STATUS_NONE);
            _shop.totalLove=MAX(@(0),@(_shop.totalLove.integerValue-1));
            _shop.numOfLove=[NSNumberFormatter numberFromNSNumber:_shop.totalLove];
            break;
            
        case LOVE_STATUS_NONE:
            _shop.loveStatus=@(LOVE_STATUS_LOVED);
            _shop.totalLove=@(_shop.totalLove.integerValue+1);
            _shop.numOfLove=[NSNumberFormatter numberFromNSNumber:_shop.totalLove];
            break;
    }
    
    [btnLove setLoveStatus:_shop.enumLoveStatus withNumOfLove:_shop.numOfLove animate:true];
    
    _operationLoveShop=[[ASIOperationLoveShop alloc] initWithIDShop:_shop.idShop.integerValue userLat:userLat() userLng:userLng() loveStatus:_shop.enumLoveStatus];
    _operationLoveShop.delegate=self;
    _operationLoveShop.fScreen=SCREEN_CODE_SHOP_USER;
    [_operationLoveShop addToQueue];
}

-(void)buttonLoveTouched:(ButtonLove *)buttonLoveView
{
    if(currentUser().enumDataMode==USER_DATA_TRY)
    {
        [[GUIManager shareInstance] showLoginDialogWithMessage:localizeLoginRequire() onOK:^
         {
             [SGData shareInstance].fScreen=SCREEN_CODE_SHOP_USER_LOVE_SHOP;
             [[SGData shareInstance].fData setObject:_shop.idShop forKey:IDSHOP];
         } onCancelled:nil onLogined:^(bool isLogined) {
             if(isLogined)
                 [self love];
         }];
        
        return;
    }
    else if(currentUser().enumDataMode==USER_DATA_CREATING)
    {
        [[GUIManager shareInstance] showLoginDialogWithMessage:localizeUserProfileRequire() onOK:^
         {
             [SGData shareInstance].fScreen=SCREEN_CODE_SHOP_USER_LOVE_SHOP;
             [[SGData shareInstance].fData setObject:_shop.idShop forKey:IDSHOP];
         } onCancelled:nil onLogined:^(bool isLogined) {
             if(isLogined)
                 [self love];
         }];
        
        return;
    }
    
    [self love];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationLoveShop class]])
    {
        ASIOperationLoveShop *ope=(ASIOperationLoveShop*) operation;
        
        [btnLove setLoveStatus:ope.loveStatus withNumOfLove:ope.numOfLove animate:true];
        
        _operationLoveShop=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationLoveShop class]])
    {
        _operationLoveShop=nil;
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_GALLERY_FINISED_SHOP object:nil];
    
    if(_operationLoveShop)
    {
        [_operationLoveShop clearDelegatesAndCancel];
        _operationLoveShop=nil;
    }
}

-(IBAction) btnInfoTouchUpInside:(id)sender
{
    [self.delegate shopGalleryControllerCellTouchedMoreInfo:self];
}

@end

@implementation BGShopGalleryView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.contentMode=UIViewContentModeRedraw;
}

-(void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"background_status.png"] drawAsPatternInRect:rect];
}

@end

@implementation UITableView(ShopGalleryController)

-(void)registerShopGalleryControllerCell
{
    [self registerNib:[UINib nibWithNibName:[ShopGalleryControllerCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopGalleryControllerCell reuseIdentifier]];
}

-(ShopGalleryControllerCell *)shopGalleryControllerCell
{
    return [self dequeueReusableCellWithIdentifier:[ShopGalleryControllerCell reuseIdentifier]];
}

@end