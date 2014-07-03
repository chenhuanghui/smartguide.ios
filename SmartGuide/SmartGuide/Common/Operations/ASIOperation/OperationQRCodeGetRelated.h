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

-(OperationQRCodeGetRelated*) initWithCode:(NSString*) code type:(enum QRCODE_RELATED_TYPE) type page:(int) page userLat:(double) userLat userLng:(double) userLng groupIndex:(int) groupIndex;

-(enum QRCODE_RELATED_TYPE) type;
-(int) groupIndex;

@property (nonatomic, strong) NSMutableArray *relaties;

@end