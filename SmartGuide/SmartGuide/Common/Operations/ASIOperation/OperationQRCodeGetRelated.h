//
//  OperationQRCodeGetRelated.h
//  Infory
//
//  Created by XXX on 7/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

enum QRCODE_RELATED_TYPE
{
    QRCODE_RELATED_TYPE_ALL=0,
    QRCODE_RELATED_TYPE_SHOPS=1,
    QRCODE_RELATED_TYPE_PROMOTIONS=2,
    QRCODE_RELATED_TYPE_PLACELISTS=3,
};

@interface OperationQRCodeGetRelated : ASIOperationPost

-(OperationQRCodeGetRelated*) initWithCode:(NSString*) code type:(enum QRCODE_RELATED_TYPE) type page:(int) page userLat:(double) userLat userLng:(double) userLng;

@property (nonatomic, strong) NSMutableArray *shops;
@property (nonatomic, strong) NSMutableArray *promotions;
@property (nonatomic, strong) NSMutableArray *placelists;

@end

@interface RelatedShop : NSObject

+(RelatedShop*) makeWithDictionary:(NSDictionary*) dict;

@property (nonatomic, strong) NSNumber *idShop;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSNumber *shopNameHeight;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSNumber *descHeight;

@end

@interface RelatedPromotion : NSObject

+(RelatedPromotion*) makeWithDictionary:(NSDictionary*) dict;

@property (nonatomic, strong) NSArray *idShops;
@property (nonatomic, strong) NSString *promotionName;
@property (nonatomic, strong) NSNumber *promotionNameHeight;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSNumber *descHeight;

@end

@interface RelatedPlacelist : NSObject

+(RelatedPlacelist*) makeWithDictionary:(NSDictionary*) dict;

@property (nonatomic, strong) NSNumber *placelistID;
@property (nonatomic, strong) NSString *placelistName;
@property (nonatomic, strong) NSNumber *placelistNameHeight;
@property (nonatomic, strong) NSString *authorAvatar;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSNumber *descHeight;

@end