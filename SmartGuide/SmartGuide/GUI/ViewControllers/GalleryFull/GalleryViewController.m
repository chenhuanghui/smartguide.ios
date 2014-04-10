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
#import "UserUploadGalleryManager.h"

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

-(void)viewWillAppearOnce
{
    int numOfColumn=3;
//    int numOfRow=4;
    float itemSpacing=2;
    float cellHeight=[ShopGalleryViewCell height];
    
    UIEdgeInsets insets=UIEdgeInsetsZero;
    
//    insets.top=(grid.l_v_h-(numOfRow*cellHeight)-itemSpacing*((float)numOfRow-1))/2;
    float top=15;
    insets.top=top;
    insets.bottom=insets.top;
    
    insets.left=(grid.l_v_w-(numOfColumn*cellHeight)-itemSpacing*((float)numOfColumn-1))/2;
    insets.right=insets.left;
    
    grid.itemSpacing=itemSpacing;
    grid.minEdgeInsets=insets;
    
    grid.dataSource=self;
    grid.actionDelegate=self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    grid.layoutStrategy=[GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutVertical];
    grid.centerGrid=false;
    
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
    ShopGalleryViewCell *gallery=(ShopGalleryViewCell*)cell.contentView;
    
    if([GalleryManager shareInstanceWithShop:_shop].canLoadMoreShopGallery && index==[self numberOfItemsInGMGridView:gridView]-1)
    {
        if(![GalleryManager shareInstanceWithShop:_shop].isLoadingMoreShopGallery)
        {
            [self requestGalleries];
        }
        
        [gallery showLoading];
        
        return cell;
    }
    
    [gallery hideLoading];
    
    ShopGallery *obj=_shop.shopGalleriesObjects[index];
    
    [gallery loadWithURL:obj.cover highlighted:[_selectedGallery sortOrder].integerValue==obj.sortOrder.integerValue];
    
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

-(NSArray*) shopUserGalleries
{
    return [[GalleryManager shareInstanceWithShop:_shop] shopUserGalleries];
}

-(NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return [self shopUserGalleries].count+([GalleryManager shareInstanceWithShop:_shop].canLoadMoreUserGallery?1:0);
}

-(GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    GMGridViewCell *cell=[super GMGridView:gridView cellForItemAtIndex:index];
    ShopGalleryViewCell *gallery=(ShopGalleryViewCell*)cell.contentView;
    
    if([GalleryManager shareInstanceWithShop:_shop].canLoadMoreUserGallery && index==[self numberOfItemsInGMGridView:gridView]-1)
    {
        if(![GalleryManager shareInstanceWithShop:_shop].isLoadingMoreUserGallery)
        {
            [self requestGalleries];
        }
        
        [gallery showLoading];
        
        return cell;
    }
    
    [gallery hideLoading];
    
    id obj=[self shopUserGalleries][index];
    
    if([obj isKindOfClass:[ShopUserGallery class]])
    {
        ShopUserGallery *gal=obj;
        [gallery loadWithURL:gal.thumbnail highlighted:_selectedGallery==gal];
    }
    else if([obj isKindOfClass:[UserGalleryUpload class]])
    {
        UserGalleryUpload *gal=obj;
        [gallery loadWithImage:[UIImage imageWithData:gal.image] highlighted:_selectedGallery==gal];
    }
    
    return cell;
}

-(id)galleryAtIndex:(int)index
{
    if([[self shopUserGalleries] isIndexInside:index])
        return [self shopUserGalleries][index];
    
    return nil;
}

@end