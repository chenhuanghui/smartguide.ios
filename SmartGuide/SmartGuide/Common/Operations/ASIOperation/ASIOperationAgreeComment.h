//
//  ASIOperationAgreeComment.h
//  SmartGuide
//
//  Created by MacMini on 20/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationAgreeComment : ASIOperationPost

-(ASIOperationAgreeComment*) initWithIDComment:(int) idCmt userLat:(double) userLat userLng:(double) userLng isAgree:(enum AGREE_STATUS) isAgree;

@property (nonatomic, readonly) int status;
@property (nonatomic, readonly) NSString *message;
@property (nonatomic, readonly) enum AGREE_STATUS agreeStatus;
@property (nonatomic, readonly) NSString *numOfAgree;

@end
