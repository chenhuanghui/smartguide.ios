//
//  ASIOperationUploadFBToken.m
//  SmartGuide
//
//  Created by MacMini on 9/23/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationUploadFBToken.h"

@implementation ASIOperationUploadFBToken
@synthesize values;

-(ASIOperationUploadFBToken *)initWithIDUser:(int)idUser fbToken:(NSString *)token
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_UPLOAD_FB_ACCESS_TOKEN)];
    
    self=[super initWithURL:_url];
    
    values=@[token,@(idUser)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"fb_access_token",@"user_id"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    
}

@end
