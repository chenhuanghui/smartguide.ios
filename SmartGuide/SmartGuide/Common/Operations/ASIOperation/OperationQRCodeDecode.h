//
//  OperationQRCodeDecode.h
//  Infory
//
//  Created by XXX on 7/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface OperationQRCodeDecode : ASIOperationPost

-(OperationQRCodeDecode*) initWithCode:(NSString*) code userLat:(double) userLat userLng:(double) userLng;

@property (nonatomic, strong) NSMutableArray *decodes;

@end