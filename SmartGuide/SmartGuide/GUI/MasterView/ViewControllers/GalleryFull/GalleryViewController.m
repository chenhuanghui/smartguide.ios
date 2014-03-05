//
//  ShopGalleryViewController.m
//  SmartGuide
//
//  Created by MacMini on 16/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "GalleryViewController.h"
#import "ShopGalleryViewCell.h"
#import "GalleryManager.h"

@interface GalleryViewController ()

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
    return @[NOTIFICATION_GALLERY_FINISED_USER,NOTIFICATION_GALLERY_FINISED_SHOP];
}

-(void)receiveNotification:(NSNotification *)notification
{
    [self reloadImage];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    grid.layoutStrategy=[GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutVertical];
    grid.centerGrid=false;
    
    int numOfColumn=3;
    int numOfRow=4;
    float itemSpacing=2;
    float cellHeight=[ShopGalleryViewCell height];
    
    UIEdgeInsets insets=UIEdgeInsetsZero;
    
    insets.top=(grid.l_v_h-(numOfRow*cellHeight)-itemSpacing*(numOfRow-1))/2;
    insets.bottom=insets.top;
    
    insets.left=(grid.l_v_w-(numOfColumn*cellHeight)-itemSpacing*(numOfColumn-1))/2;
    insets.right=insets.left;
    
    grid.itemSpacing=itemSpacing;
    grid.minEdgeInsets=insets;
    
    grid.dataSource=self;
    grid.actionDelegate=self;
    
    if(_selectedGallery)
    {
        [self.delegate shopGalleryTouchedGallery:self gallery:_selectedGallery];
    }
}

-(id)galleryAtIndex:(int)index
{
    return nil;
}

-(NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return 0;
}

-(CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return CGSizeMake([ShopGalleryViewCell height], [ShopGalleryViewCell height]);
}

-(GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    GMGridViewCell *cell=[gridView dequeueReusableCell];
    
    if(!cell)
    {
        cell=[GMGridViewCell new];
        cell.contentView=[ShopGalleryViewCell new];
    }
        
    return cell;
}

-(void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    _selectedGallery=[self galleryAtIndex:position];
    [self.delegate shopGalleryTouchedGallery:self gallery:_selectedGallery];
}

-(void)setSelectedGallery:(id)selectedGallery
{
    _selectedGallery=selectedGallery;
    
    if(grid)
    {
        [grid reloadData];
    }
}

-(void)reloadImage
{
    [grid reloadData];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    
}

@end

@implementation ShopGalleryViewController

-(GalleryViewController *)initWithShop:(Shop *)shop
{
    self=[super initWithShop:shop];
    
    return self;
}

-(void) requestGalleries
{
    [[GalleryManager shareInstanceWithShop:_shop] requestShopGallery];
}

-(NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return _shop.shopGalleriesObjects.count+([GalleryManager shareInstanceWithShop:_shop].canLoadMoreShopGallery?1:0);
}

-(GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    GMGridViewCell *cell=[super GMGridView:gridView cellForItemAtIndex:index];
    
    if([GalleryManager shareInstanceWithShop:_shop].canLoadMoreShopGallery && index==[self numberOfItemsInGMGridView:gridView]-1)
    {
        if(![GalleryManager shareInstanceWithShop:_shop].isLoadingMoreShopGallery)
        {
            [self requestGalleries];
        }
        
        [cell showLoading];
        
        return cell;
    }
    
    [cell removeLoading];
    
    ShopGalleryViewCell *gallery=(ShopGalleryViewCell*)cell.contentView;
    
    ShopGallery *obj=_shop.shopGalleriesObjects[index];
    
    [gallery loadWithImage:obj.cover highlighted:[_selectedGallery sortOrder].integerValue==obj.sortOrder.integerValue];
    
    return cell;
}

-(id)galleryAtIndex:(int)index
{
    if([_shop.shopGalleriesObjects isIndexInside:index])
        return _shop.shopGalleriesObjects[index];
    
    return nil;
}

@end

@implementation UserGalleryViewController

-(void) requestGalleries
{
    [[GalleryManager shareInstanceWithShop:_shop] requestUserGallery];
}

-(NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return _shop.userGalleriesObjects.count+([GalleryManager shareInstanceWithShop:_shop].canLoadMoreUserGallery?1:0);
}

-(GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    GMGridViewCell *cell=[super GMGridView:gridView cellForItemAtIndex:index];
    
    if([GalleryManager shareInstanceWithShop:_shop].canLoadMoreUserGallery && index==[self numberOfItemsInGMGridView:gridView]-1)
    {
        if(![GalleryManager shareInstanceWithShop:_shop].isLoadingMoreUserGallery)
        {
            [self requestGalleries];
        }
        
        [cell showLoading];
        
        return cell;
    }
    
    ShopGalleryViewCell *gallery=(ShopGalleryViewCell*)cell.contentView;
    
    ShopUserGallery *obj=_shop.userGalleriesObjects[index];
    [gallery loadWithImage:obj.thumbnail highlighted:_selectedGallery==obj];
    
    return cell;
}

-(id)galleryAtIndex:(int)index
{
    if([_shop.userGalleriesObjects isIndexInside:index])
        return _shop.userGalleriesObjects[index];
    
    return nil;
}

@end