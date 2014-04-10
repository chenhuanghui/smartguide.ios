//
//  ShopGalleryManager.m
//  SmartGuide
//
//  Created by MacMini on 05/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "GalleryManager.h"
#import "UserUploadGalleryManager.h"

static GalleryManager *_galleryManager;
@implementation GalleryManager

+(GalleryManager *)shareInstanceWithShop:(Shop *)shop
{
    if(_galleryManager)
    {
        if(_galleryManager.shop==shop)
            return _galleryManager;
        
        _galleryManager=nil;
    }

    _galleryManager=[[GalleryManager alloc] initWithShop:shop];
    
    return _galleryManager;
}

+(void)clean
{
    _galleryManager=nil;
}

-(Shop *)shop
{
    return _shop;
}

-(GalleryManager*) initWithShop:(Shop*) shop
{
    self=[super init];
    
    _shop=shop;
    
    [self makeData];
    
    return self;
}

-(void) makeData
{
    _canLoadMoreShopGallery=_shop.shopGalleriesObjects.count==10;
    _isLoadingMoreShopGallery=false;
    _pageShopGallery=0;
    
    _canLoadMoreUserGallery=_shop.userGalleries.count==10;
    _isLoadingMoreUserGallery=false;
    _pageUserGallery=0;
}

-(NSArray *)shopUserGalleries
{
    NSMutableArray *galleries=[[_shop userGalleriesUpload] mutableCopy];
    
    if(galleries.count>0)
        [galleries sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:UserGalleryUpload_SortOrder ascending:false]]];
    
    [galleries addObjectsFromArray:_shop.userGalleriesObjects];
    
    return galleries;
}

-(void)requestShopGallery
{
    if(_isLoadingMoreShopGallery)
        return;
    
    if(_operationShopGallery)
        return;
    
    _isLoadingMoreShopGallery=true;
    
    _operationShopGallery=[[ASIOperationShopGallery alloc] initWithWithIDShop:_shop.idShop.integerValue userLat:userLat() userLng:userLng() page:_pageShopGallery+1];
    _operationShopGallery.delegatePost=self;
    
    [_operationShopGallery startAsynchronous];
}

-(void)requestUserGallery
{
    if(_isLoadingMoreUserGallery)
        return;
    
    if(_operationUserGallery)
        return;
    
    _isLoadingMoreUserGallery=true;
    
    _operationUserGallery=[[ASIOperationUserGallery alloc] initWithIDShop:_shop.idShop.integerValue userLat:userLat() userLng:userLng() page:_pageUserGallery+1];
    _operationUserGallery.delegatePost=self;
    
    [_operationUserGallery startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopGallery class]])
    {
        ASIOperationShopGallery *ope=(ASIOperationShopGallery*) operation;
        
        _canLoadMoreShopGallery=ope.galleries.count==10;
        _isLoadingMoreShopGallery=false;
        _pageShopGallery++;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_GALLERY_FINISED_SHOP object:nil];
        
        _operationShopGallery=nil;
    }
    else if([operation isKindOfClass:[ASIOperationUserGallery class]])
    {
        ASIOperationUserGallery *ope=(ASIOperationUserGallery*) operation;
        
        _canLoadMoreUserGallery=ope.galleries.count==10;
        _isLoadingMoreUserGallery=false;
        _pageUserGallery++;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_GALLERY_FINISED_USER object:nil];
        
        _operationUserGallery=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopGallery class]])
    {
        _operationShopGallery=nil;
    }
    else if([operation isKindOfClass:[ASIOperationUserGallery class]])
    {
        _operationUserGallery=nil;
    }
}

-(bool)canLoadMoreShopGallery
{
    return _canLoadMoreShopGallery;
}

-(bool)canLoadMoreUserGallery
{
    return _canLoadMoreUserGallery;
}

-(bool)isLoadingMoreShopGallery
{
    return _isLoadingMoreShopGallery;
}

-(bool)isLoadingMoreUserGallery
{
    return _isLoadingMoreUserGallery;
}

- (void)dealloc
{
    _shop=nil;
    
    if(_operationUserGallery)
    {
        [_operationUserGallery clearDelegatesAndCancel];
        _operationUserGallery=nil;
    }
    
    if(_operationShopGallery)
    {
        [_operationShopGallery clearDelegatesAndCancel];
        _operationShopGallery=nil;
    }
}

@end
