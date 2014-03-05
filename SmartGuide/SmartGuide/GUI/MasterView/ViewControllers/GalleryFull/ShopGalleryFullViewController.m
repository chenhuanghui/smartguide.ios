//
//  ShopGalleryFullViewController.m
//  SmartGuide
//
//  Created by MacMini on 23/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopGalleryFullViewController.h"
#import "LoadingMoreCellHori.h"

@interface ShopGalleryFullViewController ()<ASIOperationPostDelegate>

@end

@implementation ShopGalleryFullViewController

-(ShopGalleryFullViewController *)initWithShop:(Shop *)shop selectedGallery:(ShopGallery *)gallery
{
    self=[super init];
    
    _shop=shop;
    _selectedGallery=gallery;

    _canLoadMore=shop.shopGalleriesObjects.count>0 && shop.shopGalleriesObjects.count%10==0;
    _isLoadingMore=false;
    _page=MAX(0,shop.shopGalleriesObjects.count/10-1);
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [table registerLoadingMoreCellHori];
    
    if(_selectedGallery)
    {
        int index=[_shop.shopGalleriesObjects indexOfObject:_selectedGallery];
        
        if(index!=NSNotFound)
        {
            [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:false];
        }
    }
}

-(id)galleryItemAtIndex:(int)index
{
    if([_shop.shopGalleriesObjects isIndexInside:index])
        return _shop.shopGalleriesObjects[index];
    
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) requestGalleries
{
    if(_operationShopGallery)
    {
        [_operationShopGallery clearDelegatesAndCancel];
        _operationShopGallery=nil;
    }
    
    _operationShopGallery=[[ASIOperationShopGallery alloc] initWithWithIDShop:_shop.idShop.integerValue userLat:userLat() userLng:userLng() page:_page+1];
    _operationShopGallery.delegatePost=self;
    
    [_operationShopGallery startAsynchronous];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _shop.shopGalleriesObjects.count+(_canLoadMore?1:0);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_canLoadMore && indexPath.row==[tableView numberOfRowsInSection:indexPath.section]-1)
    {
        if(!_isLoadingMore)
        {
            _isLoadingMore=true;
            
            [self requestGalleries];
        }
        
        return [table loadingMoreCellHori];
    }
    
    GalleryFullCell *cell=(GalleryFullCell*)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    ShopGallery *gallery=_shop.shopGalleriesObjects[indexPath.row];
    
    [cell loadImageURL:gallery.image];
    
    return cell;
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopGallery class]])
    {
        ASIOperationShopGallery *ope=(ASIOperationShopGallery*) operation;
        
        _canLoadMore=ope.galleries.count==10;
        _isLoadingMore=false;
        _page++;
        
        [self reloadData];
        
        _operationShopGallery=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopGallery class]])
    {
        _operationShopGallery=nil;
    }
}

@end
