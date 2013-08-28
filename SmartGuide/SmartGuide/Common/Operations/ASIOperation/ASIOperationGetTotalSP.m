//
//  ASIOperationGetTotalSP.m
//  SmartGuide
//
//  Created by XXX on 8/29/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationGetTotalSP.h"

@implementation ASIOperationGetTotalSP
@synthesize totalSP,values;

-(ASIOperationGetTotalSP *)initWithIDUser:(int)idUser
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_GET_TOTAL_SP)];
    
    self=[super initWithURL:_url];
    
    values=@[@(idUser)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"user_id"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    totalSP=0;
    
    if([self isNullData:json])
        return;
    
    totalSP=[[[json objectAtIndex:0] objectForKey:@"score"] integerValue];
}

@end
