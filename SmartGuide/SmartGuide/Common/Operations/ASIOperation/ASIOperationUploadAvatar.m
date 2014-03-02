//
//  ASIOperationUploadAvatar.m
//  SmartGuide
//
//  Created by MacMini on 02/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationUploadAvatar.h"

@implementation ASIOperationUploadAvatar
@synthesize status,avatar;

-(ASIOperationUploadAvatar *)initWithAvatar:(NSData *)avatarBinary userLat:(double)userLat userLng:(double)userLng
{
    self=[super initWithURL:SERVER_API_URL_MAKE(API_USER_UPLOAD_AVATAR)];
    
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    [self addData:avatarBinary withFileName:@"avatar" andContentType:@"image/jpeg" forKey:@"avatar"];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([self isNullData:json])
        return;
    
    NSDictionary *dict=json[0];
    status=[[NSNumber numberWithObject:dict[STATUS]] integerValue];
    
    if(status==1)
    {
        self.avatar=[NSString stringWithStringDefault:dict[@"avatar"]];
    }
}

-(double)userLat
{
    return [self.keyValue[USER_LATITUDE] doubleValue];
}

-(double)userLng
{
    return [self.keyValue[USER_LONGITUDE] doubleValue];
}

@end
