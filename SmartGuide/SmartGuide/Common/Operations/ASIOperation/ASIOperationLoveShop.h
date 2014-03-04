//
//  ASIOperationLoveShop.h
//  SmartGuide
//
//  Created by MacMini on 19/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "Constant.h"
#import "Shop.h"
#import "ShopList.h"

@interface ASIOperationLoveShop : ASIOperationPost

-(ASIOperationLoveShop*) initWithIDShop:(int) idShop userLat:(double) userLat userLng:(double) userLng loveStatus:(enum LOVE_STATUS) loveStatus;

@property (nonatomic, readonly) int status;
@property (nonatomic, readonly) NSString *message;
@property (nonatomic, readonly) enum LOVE_STATUS loveStatus;
@property (nonatomic, readonly) NSString *numOfLove;
@property (nonatomic, readonly) Shop *shop;

@end
