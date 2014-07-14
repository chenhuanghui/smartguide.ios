//
//  OperationQRCodeGetRelated.h
//  Infory
//
//  Created by XXX on 7/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface OperationQRCodeGetRelated : ASIOperationPost

-(OperationQRCodeGetRelated*) initWithCode:(NSString*) code type:(enum QRCODE_RELATED_TYPE) type page:(int) page userLat:(double) userLat userLng:(double) userLng groupIndex:(int) groupIndex;

-(enum QRCODE_RELATED_TYPE) type;
-(int) groupIndex;

@property (nonatomic, strong) NSMutableArray *relaties;

@end