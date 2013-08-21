//
//  ASIOperationPromotionDetail.h
//  SmartGuide
//
//  Created by XXX on 8/7/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@class Shop;

@interface ASIOperationPromotionDetail : ASIOperationPost

-(ASIOperationPromotionDetail*) initWithIDShop:(int) idShop idUser:(int) idUser;

@property (nonatomic, readonly) Shop *shop;

@end
