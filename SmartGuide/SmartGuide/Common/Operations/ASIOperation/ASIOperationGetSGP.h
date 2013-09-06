//
//  ASIOperationGetSGP.h
//  SmartGuide
//
//  Created by XXX on 8/4/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

enum SGP_STATUS {
    SGP_ERROR =-1,
    SGP_INVAIL = 0,
    SGP_EXPIRED = 1,
    SGP_CODE_INVAIL = 2,
    SGP_VAIL =3,
    };

@interface ASIOperationGetSGP : ASIOperationPost
{
}

-(ASIOperationGetSGP*) initWithUserID:(int) idUser code:(NSString*) code idShop:(int) idShop lat:(double) lat lon:(double) lon;

@property (nonatomic, readonly) int status;
@property (nonatomic, readonly) NSString *content;
@property (nonatomic, readonly) int SGP;
@property (nonatomic, readonly) NSString *shopName;
@property (nonatomic, readonly) NSString *time;
@property (nonatomic, readonly) double totalSGP;
@property (nonatomic, readonly) NSString *code;

@end
