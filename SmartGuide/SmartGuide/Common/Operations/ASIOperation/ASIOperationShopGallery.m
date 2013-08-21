//
//  ASIOperationShopGallery.m
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationShopGallery.h"
#import "Shop.h"
#import "ShopGallery.h"

@implementation ASIOperationShopGallery
@synthesize values,shopGalleries;

-(ASIOperationShopGallery*) initWithIDShop:(int) idShop
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_SHOP_GALLERY)];
    self=[super initWithURL:_url];
    
    values=@[@(idShop)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"shop_id"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([self isNullData:json])
    {
//        Shop *shop=[Shop shopWithIDShop:[[self.values objectAtIndex:0] integerValue]];
//        if([[values objectAtIndex:0] integerValue]==0)
//            [shop removeShopGallery:shop.shopGallery];
//        
//        NSMutableArray *array=[NSMutableArray array];
//        for(int i=0;i<30;i++)
//        {
//            ShopGallery *gallery=[ShopGallery insert];
//            gallery.shop=shop;
//            gallery.idShop=shop.idShop;
//            gallery.image=@"https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQHyRIKmTyxn5o58IPnH6yJXJq5_6YltzZLS8IcBW6mHaC8BE91";
//            
//            [array addObject:gallery];
//        }
        
        shopGalleries=[NSArray array];
        return;
    }
    
    Shop *shop=[Shop shopWithIDShop:[[values objectAtIndex:0] integerValue]];

    NSMutableArray *array=[NSMutableArray array];
    
    if(json.count>0)
    {
        NSDictionary *dict=[json objectAtIndex:0];
        
        if([dict objectForKey:@"content"]!=[NSNull null])
        {
            for(NSString* str in [dict objectForKey:@"content"])
            {
                ShopGallery *shopG=[ShopGallery insert];
                shopG.shop=shop;
                shopG.idShop=shop.idShop;
                shopG.image=[NSString stringWithStringDefault:str];
                
                [array addObject:shopG];
            }
            
            [[DataManager shareInstance] save];
            
            shopGalleries=[NSArray arrayWithArray:array];
        }
    }
}

@end