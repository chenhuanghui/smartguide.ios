//
//  ASIOperationGetFeedback.m
//  SmartGuide
//
//  Created by XXX on 8/26/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationGetFeedback.h"
#import "Feedback.h"

@implementation ASIOperationGetFeedback
@synthesize feedbacks;

-(ASIOperationGetFeedback *)initFeedback
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_GET_FEEDBACK)];
    
    self=[super initWithURL:_url];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    for(Feedback *fb in [Feedback allObjects])
        [[DataManager shareInstance].managedObjectContext deleteObject:fb];
    
    feedbacks=[NSMutableArray array];
    if([self isNullData:json])
        return;
    
    for(NSDictionary *dict in json)
    {
        Feedback *fb=[Feedback insert];
        fb.idFeedback=[NSNumber numberWithObject:[dict objectForKey:@"id"]];
        fb.idUser=[NSNumber numberWithObject:[dict objectForKey:@"user_id"]];
        fb.content=[NSString stringWithStringDefault:[dict objectForKey:@"feedback"]];
        fb.created_at=[NSString stringWithStringDefault:[dict objectForKey:@"created_at"]];
        
        [feedbacks addObject:fb];
    }
    
    [[DataManager shareInstance] save];
}

@end
