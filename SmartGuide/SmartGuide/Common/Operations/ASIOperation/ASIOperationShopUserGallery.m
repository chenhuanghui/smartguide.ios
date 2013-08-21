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
    if([self isNullData:json])
    {
//        Shop *shop=[Shop shopWithIDShop:[[self.values objectAtIndex:0] integerValue]];
//        if([[values objectAtIndex:1] integerValue]==0)
//            [shop removeUserGallery:shop.userGallery];
//        
//        NSMutableArray *array=[NSMutableArray array];
//        for(int i=0;i<10;i++)
//        {
//            ShopUserGallery *gallery=[ShopUserGallery insert];
//            gallery.shop=shop;
//            gallery.idShop=shop.idShop;
//            gallery.desc=[NSString stringWithFormat:@"description %i",i+1];
//            gallery.image=@"https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQHyRIKmTyxn5o58IPnH6yJXJq5_6YltzZLS8IcBW6mHaC8BE91";
//            
//            [array addObject:gallery];
//        }
        
        userGallerys=[NSArray array];
        return;
    }
    
    Shop *shop=[Shop shopWithIDShop:[[self.values objectAtIndex:0] integerValue]];
    
    NSMutableArray *array=[NSMutableArray array];
    for(NSDictionary *dict in json)
    {
        ShopUserGallery *gallery=[ShopUserGallery insert];
        gallery.shop=shop;
        gallery.idShop=shop.idShop;
        gallery.desc=[NSString stringWithStringDefault:[dict objectForKey:@"description"]];
        gallery.image=[NSString stringWithStringDefault:[dict objectForKey:@"image"]];
        
        [array addObject:gallery];
    }
    
    [[DataManager shareInstance] save];
    
    userGallerys=[NSArray arrayWithArray:array];
}

@end
