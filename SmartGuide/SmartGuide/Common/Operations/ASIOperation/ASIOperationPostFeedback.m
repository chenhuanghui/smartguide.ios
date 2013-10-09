//
//  ASIOperationPostFeedback.m
//  SmartGuide
//
//  Created by XXX on 8/28/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPostFeedback.h"

@implementation ASIOperationPostFeedback
@synthesize values,isSuccess;

-(ASIOperationPostFeedback *)initWithIDUser:(int)idUser content:(NSString *)content
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_POST_FEEDBACK)];
    
    self=[super initWithURL:_url];
    
    values=@[@(idUser),content];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"user_id",@"feedback"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    isSuccess=false;
    
    if([self isNullData:json])
        return;
    
    isSuccess=[[json objectAtIndex:0] integerValue]==1;
}

@end
