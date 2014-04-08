//
//  ASIOperationRemoveShopPlacelist.h
//  Infory
//
//  Created by XXX on 4/8/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "ShopList.h"
#import "Placelist.h"

@interface ASIOperationRemoveShopPlacelist : ASIOperationPost

-(ASIOperationRemoveShopPlacelist*) initWithIDPlacelist:(int) idPlace idShops:(NSString*) idShops userLat:(double) userLat userLng:(double) userLng;

-(NSNumber*) idShop;
-(ShopList*) shopList;

@property (nonatomic, assign) int status;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *numOfShop;
@property (nonatomic, strong) NSString *idShops;
@property (nonatomic, strong) NSNumber *idPlace;

@end
