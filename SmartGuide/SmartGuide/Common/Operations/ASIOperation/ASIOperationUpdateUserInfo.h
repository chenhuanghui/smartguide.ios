//
//  ASIOperationUpdateUserInfo.h
//  SmartGuide
//
//  Created by XXX on 9/5/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationUpdateUserInfo : ASIOperationPost

-(ASIOperationUpdateUserInfo*) initWithIDUser:(int) idUser name:(NSString*) name avatar:(NSString*) avatar;

@property (nonatomic, readonly) bool isSuccess;
@property (nonatomic, readonly) NSString *messsage;
@property (nonatomic, readonly) NSString *data;

@end
