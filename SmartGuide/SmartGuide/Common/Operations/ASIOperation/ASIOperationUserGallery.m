//
//  ASIOperationUserGallery.m
//  SmartGuide
//
//  Created by MacMini on 05/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationUserGallery.h"

@implementation ASIOperationUserGallery

-(ASIOperationUserGallery *)initWithIDShop:(int)idShop userLat:(double)userLat userLng:(double)userLng page:(int)page
{
    self=[super initWithURL:SERVER_API_URL_MAKE(API_GET_USER_GALLERY)];
    
    [self.keyValue setObject:@(idShop) forKey:IDSHOP];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    [self.keyValue setObject:@(page) forKey:PAGE];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    self.galleries=[NSMutableArray new];
    if([json isNullData])
        return;
    
    Shop *shop=[Shop shopWithIDShop:[self.keyValue[IDSHOP] integerValue]];
    
    int count=0;
    if(shop.userGalleriesObjects.count>0)
        count=[[shop.userGalleriesObjects valueForKeyPath:[NSString stringWithFormat:@"@max.%@",ShopUserGallery_SortOrder]] integerValue]+1;
    
    for(NSDictionary *dict in json)
    {
        ShopUserGallery *obj=[ShopUserGallery makeWithJSON:dict];
        obj.sortOrder=@(count++);
        
        [shop addUserGalleriesObject:obj];
        [self.galleries addObject:obj];
    }
    
    [[DataManager shareInstance] save];
}

@end
