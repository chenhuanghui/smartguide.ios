//
//  ASIOperationAgreeComment.m
//  SmartGuide
//
//  Created by MacMini on 20/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationAgreeComment.h"
#import "ShopUserComment.h"

@implementation ASIOperationAgreeComment
@synthesize status,message,agreeStatus,numOfAgree;

-(ASIOperationAgreeComment *)initWithIDComment:(int)idCmt userLat:(double)userLat userLng:(double)userLng isAgree:(enum AGREE_STATUS)isAgree
{
    self=[super initPOSTWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_AGREE_COMMENT)]];
    
    [self.keyValue setObject:@(idCmt) forKey:@"idComment"];
    [self.keyValue setObject:@(userLat) forKey:@"userLat"];
    [self.keyValue setObject:@(userLng) forKey:@"userLng"];
    [self.keyValue setObject:@(isAgree) forKey:@"isAgree"];

    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([json isNullData])
        return;
    
    NSDictionary *dict=json[0];
    status=[[NSNumber numberWithObject:dict[@"status"]] integerValue];
    message=[NSString stringWithStringDefault:dict[@"message"]];
    
    if(status==1)
    {
        int as=[[NSNumber numberWithObject:dict[@"agreeStatus"]] integerValue];
        
        switch (as) {
            case 0:
                agreeStatus=AGREE_STATUS_NONE;
                break;
                
            case 1:
                agreeStatus=AGREE_STATUS_AGREED;
                
            default:
                agreeStatus=AGREE_STATUS_NONE;
                break;
        }
        
        numOfAgree=[NSString stringWithStringDefault:dict[@"numOfAgree"]];
        
        int idCmt=[self.keyValue[@"idComment"] integerValue];
        ShopUserComment *cmt=[ShopUserComment commentWithIDComment:idCmt];
        
        if(cmt)
        {
            cmt.agreeStatus=@(as);
            cmt.numOfAgree=numOfAgree;
            cmt.totalAgree=[NSNumber numberWithObject:dict[@"totalAgree"]];
            
            [[DataManager shareInstance] save];
        }
    }
}

@end
