//
//  ASIOperationShopDetailInfo.h
//  SmartGuide
//
//  Created by MacMini on 22/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

enum DETAIL_INFO_TYPE {
    DETAIL_INFO_TYPE_UNKNOW = 0,
    DETAIL_INFO_TYPE_1 = 1,
    DETAIL_INFO_TYPE_2 = 2,
    DETAIL_INFO_TYPE_3 = 3,
    DETAIL_INFO_TYPE_4 = 4
    };

enum DETAIL_INFO_IS_TICKED {
    DETAIL_INFO_TICKED_NONE = 0,
    DETAIL_INFO_TICKED = 1
    };

@interface ASIOperationShopDetailInfo : ASIOperationPost

-(ASIOperationShopDetailInfo*) initWithIDShop:(int) idShop userLat:(double) userLat userLng:(double) userLng;

@property (nonatomic, readonly) NSMutableArray *infos;

@end

@interface InfoTypeObject : NSObject

+(InfoTypeObject*) infoWithDictionary:(NSDictionary*) dict;

@property (nonatomic, assign) enum DETAIL_INFO_TYPE type;
@property (nonatomic, strong) NSString *header;
@property (nonatomic, strong) NSMutableArray *items;

@end

@interface Info1 : NSObject

+(Info1*) infoWithDictionary:(NSDictionary*) dict;

@property (nonatomic, assign) enum DETAIL_INFO_IS_TICKED isTicked;
@property (nonatomic, strong) NSString *content;

@end

@interface Info2 : NSObject

+(Info2*) infoWithDictionary:(NSDictionary*) dict;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;

@end

@interface Info3 : NSObject

+(Info3*) infoWithDictionary:(NSDictionary*) dict;

@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) int idShop;
@property (nonatomic, strong) NSNumber *titleHeight;
@property (nonatomic, strong) NSNumber *contentHeight;

@end

@interface Info4 : NSObject

+(Info4*) infoWithDictionary:(NSDictionary*) dict;

@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;

@end