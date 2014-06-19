//
//  ASIOperationPostPicture.m
//  SmartGuide
//
//  Created by MacMini on 01/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPostPicture.h"

@implementation ASIOperationPostPicture
@synthesize status;

-(ASIOperationPostPicture *)initWithIDUserGallery:(int)idUserGallery userLat:(double)userLat userLng:(double)userLng description:(NSString *)desc
{
    self=[super initPOSTWithURL:SERVER_API_URL_MAKE(API_USER_POST_PICTURE)];
    
    [self.keyValue setObject:@(idUserGallery) forKey:@"idUserGallery"];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    [self.keyValue setObject:desc forKey:DESCRIPTION];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([json isNullData])
        return;
    
    NSDictionary *dict=json[0];
    status=[[NSNumber numberWithObject:dict[STATUS]] integerValue];
    self.message=[NSString stringWithStringDefault:dict[MESSAGE]];
    self.desc=[self.keyValue[DESCRIPTION] copy];
}

@end
