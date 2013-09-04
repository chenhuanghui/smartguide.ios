//
//  ASIShopUserGallery.m
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationShopUserGallery.h"
#import "Shop.h"
#import "ShopUserGallery.h"

@implementation ASIOperationShopUserGallery
@synthesize values,userGallerys;

-(ASIOperationShopUserGallery *)initWithIDShop:(int)idShop page:(int)page
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_SHOP_USER_GALLERY)];
    self=[super initWithURL:_url];
    
    values=@[@(idShop),@(page)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"shop_id",@"page"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    userGallerys=[[NSMutableArray alloc] init];
    if([self isNullData:json])
        return;
    
    Shop *shop=[Shop shopWithIDShop:[[self.values objectAtIndex:0] integerValue]];
    
    for(NSDictionary *dict in json)
    {
        ShopUserGallery *gallery=[ShopUserGallery insert];
        gallery.shop=shop;
        gallery.idShop=shop.idShop;
        gallery.desc=[NSString stringWithStringDefault:[dict objectForKey:@"description"]];
        gallery.image=[NSString stringWithStringDefault:[dict objectForKey:@"image"]];
        gallery.thumbnail=[NSString stringWithStringDefault:[dict objectForKey:@"thumbnail"]];
        
        [userGallerys addObject:gallery];
    }
    
    [[DataManager shareInstance] save];
}

@end
