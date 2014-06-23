//
//  ShopGalleryViewController.m
//  SmartGuide
//
//  Created by MacMini on 16/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "GalleryViewController.h"
#import "GalleryViewCell.h"
#import "ShopManager.h"
#import "UserUploadGalleryManager.h"
#import "LoadingMoreCollectionCell.h"

@interface GalleryViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation GalleryViewController
@synthesize delegate;

-(GalleryViewController *)initWithShop:(Shop *)shop
{
    self=[super initWithNibName:@"GalleryViewController" bundle:nil];
    
    _shop=shop;
    
    return self;
}

-(NSArray *)registerNotifications
{
    return @[NOTIFICATION_GALLERY_FINISED_USER,NOTIFICATION_GALLERY_FINISED_SHOP,NOTIFICATION_GALLERY_SELECTED_CHANGE];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:NOTIFICATION_GALLERY_FINISED_USER]
       || [notification.name isEqualToString:NOTIFICATION_GALLERY_FINISED_SHOP])
        [self reloadImage];
    else if([notification.name isEqualToString:NOTIFICATION_GALLERY_SELECTED_CHANGE])
    {
        [self reloadImage];
    }
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    collection.contentInset=UIEdgeInsetsMake(54, 0, 54, 0);
    
    [collection registerGalleryViewCell];
    [collection registerLoadingMoreCell];
}

-(void)viewWillAppearOnce
{
    [super viewWillAppearOnce];
}

-(id)galleryAtIndex:(int)index
{
    return nil;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [collectionView galleryViewCellForIndexPath:indexPath];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id selectedGallery=[self galleryAtIndex:indexPath.row];
    [self.delegate galleryControllerTouchedGallery:self gallery:selectedGallery];
}

-(void)reloadImage
{
    [collection reloadData];
}

-(void) reloadVisibleImage
{
    [collection reloadVisibleItems];
}

@end

@implementation ShopGalleryViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    if([ShopManager shareInstanceWithShop:_shop].selectedShopGallery)
    {
        int idx=[[self galleries] indexOfObject:[ShopManager shareInstanceWithShop:_shop].selectedShopGallery];
        
        if(idx!=NSNotFound)
        {
            [collection scrollToItemAtIndexPath:makeIndexPath(idx, 0) atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:false];
        }
    }
}

-(void) requestGalleries
{
    [[ShopManager shareInstanceWithShop:_shop] requestShopGallery];
}

-(NSArray*) galleries
{
    return [ShopManager shareInstanceWithShop:_shop].shopGalleries;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self galleries].count+([ShopManager shareInstanceWithShop:_shop].canLoadMoreShopGallery?1:0);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([ShopManager shareInstanceWithShop:_shop].canLoadMoreShopGallery && indexPath.row==[self galleries].count)
    {
        if(![ShopManager shareInstanceWithShop:_shop].isLoadingMoreShopGallery)
        {
            [self requestGalleries];
        }
        
        return [collectionView loadingMoreCellAtIndexPath:indexPath];
    }
    
    GalleryViewCell *cell=(GalleryViewCell*)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    ShopGallery *obj=[self galleries][indexPath.row];
    
    [cell loadWithURL:obj.cover highlighted:[ShopManager shareInstanceWithShop:_shop].selectedShopGallery==obj];
    
    return cell;
}

-(id)galleryAtIndex:(int)index
{
    if([[self galleries] isIndexInside:index])
        return [self galleries][index];
    
    return nil;
}

@end

@implementation UserGalleryViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    if([ShopManager shareInstanceWithShop:_shop].selectedUserGallery)
    {
        int idx=[[self galleries] indexOfObject:[ShopManager shareInstanceWithShop:_shop].selectedUserGallery];
        
        if(idx!=NSNotFound)
        {
            [collection scrollToItemAtIndexPath:makeIndexPath(idx, 0) atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:false];
        }
    }
}

-(void) requestGalleries
{
    [[ShopManager shareInstanceWithShop:_shop] requestUserGallery];
}

-(NSArray*) galleries
{
    return [ShopManager shareInstanceWithShop:_shop].userGalleries;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self galleries].count+([ShopManager shareInstanceWithShop:_shop].canLoadMoreUserGallery?1:0);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([ShopManager shareInstanceWithShop:_shop].canLoadMoreUserGallery && indexPath.row==[self galleries].count)
    {
        if(![ShopManager shareInstanceWithShop:_shop].isLoadingMoreUserGallery)
        {
            [self requestGalleries];
        }
        
        return [collectionView loadingMoreCellAtIndexPath:indexPath];
    }
    
    GalleryViewCell *cell=(GalleryViewCell*)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    id obj=[self galleries][indexPath.row];
    
    if([obj isKindOfClass:[ShopUserGallery class]])
    {
        ShopUserGallery *gal=obj;
        [cell loadWithURL:gal.thumbnail highlighted:[ShopManager shareInstanceWithShop:_shop].selectedUserGallery==gal];
    }
    else if([obj isKindOfClass:[UserGalleryUpload class]])
    {
        UserGalleryUpload *gal=obj;
        [cell loadWithImage:[UIImage imageWithData:gal.image] highlighted:[ShopManager shareInstanceWithShop:_shop].selectedUserGallery==gal];
    }
    
    return cell;
}

-(id)galleryAtIndex:(int)index
{
    if([[self galleries] isIndexInside:index])
        return [self galleries][index];
    
    return nil;
}

@end