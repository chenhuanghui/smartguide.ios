//
//  OperationQRCodeGetAllRelated.h
//  Infory
//
//  Created by XXX on 7/14/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface OperationQRCodeGetAllRelated : ASIOperationPost

-(OperationQRCodeGetAllRelated*) initWithCode:(NSString*) code userLat:(double) userLat userLng:(double) userLng;

@property (nonatomic, strong) NSMutableArray *relatedContains;

@end
