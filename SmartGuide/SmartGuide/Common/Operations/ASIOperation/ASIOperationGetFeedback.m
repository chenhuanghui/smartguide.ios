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
    
    [[DataManager shareInstance] save];
    
    feedbacks=[NSMutableArray array];
    if([self isNullData:json])
        return;
    
    int code=[[[json objectAtIndex:0] objectForKey:@"code"] integerValue];
    
    if(code==1)
    {
        for(NSDictionary *dict in [[json objectAtIndex:0] objectForKey:@"content"])
        {
            Feedback *fb=[Feedback insert];
            fb.content=[NSString stringWithStringDefault:[dict objectForKey:@"feedback"]];
            fb.user=[NSString stringWithStringDefault:[dict objectForKey:@"username"]];
            
            [feedbacks addObject:fb];
        }
        
        [[DataManager shareInstance] save];
    }
}

@end
