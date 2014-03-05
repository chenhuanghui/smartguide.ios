//
//  ASIOperationShopGallery.m
//  SmartGuide
//
//  Created by MacMini on 05/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationShopGallery.h"

@implementation ASIOperationShopGallery

-(ASIOperationShopGallery *)initWithWithIDShop:(int)idShop userLat:(double)userLat userLng:(double)userLng page:(int)page
{
    self=[super initWithURL:SERVER_API_URL_MAKE(API_GET_SHOP_GALLERY)];
    
    [self.keyValue setObject:@(idShop) forKey:IDSHOP];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    [self.keyValue setObject:@(page) forKey:PAGE];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    self.galleries=[NSMutableArray new];
    if([self isNullData:json])
        return;
    
    Shop *shop=[Shop shopWithIDShop:[self.keyValue[IDSHOP] integerValue]];
    
    int count=0;
    
    if(shop.shopGalleriesObjects.count>0)
        count=[[shop.shopGalleriesObjects valueForKeyPath:[NSString stringWithFormat:@"@max.%@",ShopGallery_SortOrder]] integerValue]+1;
    
    for(NSDictionary *dict in json)
    {
        ShopGallery *gallery=[ShopGallery makeWithJSON:dict];
        gallery.sortOrder=@(count++);
        
        [shop addShopGalleriesObject:gallery];
        [self.galleries addObject:gallery];
    }
    
    [[DataManager shareInstance] save];
}

@end
