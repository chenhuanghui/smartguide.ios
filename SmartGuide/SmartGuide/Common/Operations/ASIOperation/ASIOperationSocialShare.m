//
//  ASIOperationSocialShare.m
//  SmartGuide
//
//  Created by MacMini on 21/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationSocialShare.h"

@implementation ASIOperationSocialShare
@synthesize status,message;

-(ASIOperationSocialShare *)initWithContent:(NSString *)content url:(NSString *)_url image:(UIImage *)image accessToken:(NSString *)accessToken socialType:(enum SOCIAL_TYPE)socialType
{
    self=[super initPOSTWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_SOCIAL_SHARE)]];

    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    
    [dict setObject:accessToken forKey:@"accessToken"];
    [dict setObject:@(socialType) forKey:@"socialType"];
    
    if(content.length>0)
        [dict setObject:content forKey:@"content"];
    
    if(_url.length>0)
        [dict setObject:_url forKey:@"url"];
    
    if(image)
        [dict setObject:image forKey:@"image"];
    
    self.keyValue=dict;
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    status=0;
    message=@"";
    
    if([json isNullData])
        return;
    
    status=[[NSNumber numberWithObject:json[0][@"status"]] integerValue];
}

@end
