//
//  ASIOperationSGPToReward.h
//  SmartGuide
//
//  Created by XXX on 8/5/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationSGPToReward : ASIOperationPost
{
    int _idShop;
}

-(ASIOperationSGPToReward*) initWithIDUser:(int) idUser idRewward:(int) idReward code:(NSString*) code idShop:(int) idShop;

@property (nonatomic, readonly) int status;
@property (nonatomic, readonly) NSString *content;
@property (nonatomic, readonly) double sgp;
@property (nonatomic, readonly) NSString *award;
@property (nonatomic, readonly) NSString *time;
@property (nonatomic, readonly) NSString *shopName;
@property (nonatomic, readonly) double totalSGP;
@property (nonatomic, readonly) NSString *code;

@end
