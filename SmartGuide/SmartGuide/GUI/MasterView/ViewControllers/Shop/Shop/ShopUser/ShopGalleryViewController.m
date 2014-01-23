//
//  ShopGalleryViewController.m
//  SmartGuide
//
//  Created by MacMini on 16/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopGalleryViewController.h"
#import "ShopGalleryViewCell.h"

@interface ShopGalleryViewController ()

@end

@implementation ShopGalleryViewController
@synthesize delegate;

-(ShopGalleryViewController *)initWithShop:(Shop *)shop withMode:(enum SHOP_GALLERY_VIEW_MODE)viewMode
{
    self=[super initWithNibName:@"ShopGalleryViewController" bundle:nil];
    
    _shop=shop;
    _viewMode=viewMode;
    
    return self;
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
}

-(NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    switch (_viewMode) {
        case SHOP_GALLERY_VIEW_SHOP:
        {
            _data=_shop.shopGalleriesObjects;
            return _data.count;
        }
            
        case SHOP_GALLERY_VIEW_USER:
            _data=_shop.userGalleriesObjects;
            return _data.count;
    }
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
    
    ShopGalleryViewCell *gallery=(ShopGalleryViewCell*)cell.contentView;
    
    switch (_viewMode) {
        case SHOP_GALLERY_VIEW_SHOP:
        {
            ShopGallery *obj=_data[index];
            [gallery loadWithImage:obj.cover highlighted:_selectedGallery==obj];
        }
            break;
            
        case SHOP_GALLERY_VIEW_USER:
        {
            ShopUserGallery *obj=_data[index];
            [gallery loadWithImage:obj.thumbnail highlighted:_selectedGallery==obj];
        }
            break;
    }
    
    return cell;
}

-(void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    _selectedGallery=_data[position];
    [self.delegate shopGalleryTouchedGallery:self gallery:_selectedGallery];
}

-(void)setSelectedGallery:(id)selectedGallery
{
    _selectedGallery=selectedGallery;
    
    if(grid && _data.count>0)
    {
        [grid reloadData];
    }
}

@end
