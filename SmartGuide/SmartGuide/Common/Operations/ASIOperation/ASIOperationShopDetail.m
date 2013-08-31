//
//  ASIOperationShopDetail.m
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationShopDetail.h"
#import "ShopProduct.h"
#import "ShopUserComment.h"
#import "ShopUserGallery.h"
#import "ShopGallery.h"

@implementation ASIOperationShopDetail
@synthesize values,shop,comments,userGalleries,shopGalleries,products;

-(ASIOperationShopDetail *)initWithIDUser:(int)idUser idShop:(int)idShop latitude:(double)lat longtitude:(double)lon
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_SHOP_DETAIL)];
    self=[super initWithURL:_url];
    
    values=@[@(idUser),@(idShop),@(lat),@(lon)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"user_id",@"shop_id",@"user_lat",@"user_lng"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    comments=[NSMutableArray array];
    shopGalleries=[NSMutableArray array];
    userGalleries=[NSMutableArray array];
    products=[NSMutableArray array];
    
    if([self isNullData:json])
        return;
    
    NSDictionary *dictJson=[json objectAtIndex:0];
    
    int idShop=[dictJson integerForKey:@"id"];
    shop=[Shop shopWithIDShop:idShop];
    if(!shop)
        shop=[Shop makeShopWithDictionaryShopInGroup:dictJson];
    
    [shop removeProducts:shop.products];
    [shop removeShopGallery:shop.shopGallery];
    [shop removeShopUserComments:shop.shopUserComments];
    [shop removeUserGallery:shop.userGallery];
    
    shop.isNeedReloadData=false;
    shop.address=[NSString stringWithStringDefault:[dictJson objectForKey:@"address"]];
    shop.desc=[NSString stringWithStringDefault:[dictJson objectForKey:@"description"]];
    shop.numOfLike=[dictJson objectForKey:@"like"];
    shop.numOfDislike=[dictJson objectForKey:@"dislike"];
    shop.like_status=[dictJson objectForKey:@"like_status"];
    shop.logo=[NSString stringWithStringDefault:[dictJson objectForKey:@"logo"]];
    shop.cover=[NSString stringWithStringDefault:[dictJson objectForKey:@"cover"]];
    shop.name=[NSString stringWithStringDefault:[dictJson objectForKey:@"name"]];
    shop.promotionStatus=[dictJson objectForKey:@"promotion_status"];
    shop.shop_lat=[dictJson objectForKey:@"shop_lat"];
    shop.shop_lng=[dictJson objectForKey:@"shop_lng"];
    shop.contact=[NSString stringWithStringDefault:[dictJson objectForKey:@"tel"]];
    shop.website=[NSString stringWithStringDefault:[dictJson objectForKey:@"website"]];
    
    NSArray *array=[dictJson objectForKey:@"shop_comments"];
    
    if(![self isNullData:array])
    {
        for(NSDictionary *dict in array)
        {
            ShopUserComment *comment=[ShopUserComment insert];
            comment.shop=shop;
            comment.idShop=shop.idShop;
            comment.user=[NSString stringWithStringDefault:[dict objectForKey:@"user"]];
            comment.comment=[NSString stringWithStringDefault:[dict objectForKey:@"comment"]];
            comment.avatar=[NSString stringWithStringDefault:[dict objectForKey:@"avatar"]];
            comment.time=[NSString stringWithStringDefault:[dict objectForKey:@"time"]];
            
            [comments addObject:comment];
            
            [shop addShopUserCommentsObject:comment];
        }
    }
    
    array=[dictJson objectForKey:@"shop_items"];
    
    if(![self isNullData:array])
    {
        for(NSDictionary *dict in array)
        {
            NSArray *items=[dict objectForKey:@"items"];
            for(NSDictionary *dictItem in items)
            {
                ShopProduct *product=[ShopProduct insert];
                
                product.shop=shop;
                product.cat_name=[NSString stringWithStringDefault:[dict objectForKey:@"cat_name"]];
                
                product.name=[NSString stringWithStringDefault:[dictItem objectForKey:@"name"]];
                product.price=[NSString stringWithStringDefault:[dictItem objectForKey:@"price"]];
                product.desc=[NSString stringWithStringDefault:[dictItem objectForKey:@"description"]];
                product.images=[NSString stringWithStringDefault:[dictItem objectForKey:@"images"]];
                
                [products addObject:product];
                
                [shop addProductsObject:product];
            }
        }
    }
    
    array=[dictJson objectForKey:@"user_gallery"];
    
    if(![self isNullData:array])
    {
        for(NSDictionary *dict in array)
        {
            ShopUserGallery *gallery=[ShopUserGallery insert];
            gallery.shop=shop;
            gallery.idShop=shop.idShop;
            gallery.desc=[NSString stringWithStringDefault:[dict objectForKey:@"description"]];
            gallery.image=[NSString stringWithStringDefault:[dict objectForKey:@"image"]];
            
            [userGalleries addObject:gallery];
            
            [shop addUserGalleryObject:gallery];
        }
    }
    
    array=[dictJson objectForKey:@"shop_gallery"];
    
    if(![self isNullData:array])
    {
        for(NSString* image in array)
        {
            ShopGallery *shopG=[ShopGallery insert];
            shopG.shop=shop;
            shopG.idShop=shop.idShop;
            shopG.image=[NSString stringWithStringDefault:image];
            
            [shopGalleries addObject:shopG];;
            
            [shop addShopGalleryObject:shopG];
        }
    }
    
    shop.isShopDetail=true;
    
    [[DataManager shareInstance] save];
}

@end
