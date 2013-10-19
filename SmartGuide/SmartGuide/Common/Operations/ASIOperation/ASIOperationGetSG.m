//
//  ASIOperationGetSG.m
//  SmartGuide
//
//  Created by XXX on 8/27/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationGetSG.h"

@implementation ASIOperationGetSG
@synthesize values,sg;

-(ASIOperationGetSG *)initWithIDUser:(int)idUser
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_GET_SG)];
    
    self=[super initWithURL:_url];
    
    values=@[@(idUser)];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    NSDictionary *dict=[json objectAtIndex:0];
    sg=[NSNumber numberWithObject:dict[@"@score"]];
}

-(NSArray *)keys
{
    return @[@"user_id"];
}

@end
