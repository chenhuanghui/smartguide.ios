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
@synthesize status,message,agreeStatus,numOfAgree,values;

-(ASIOperationAgreeComment *)initWithIDComment:(int)idCmt userLat:(double)userLat userLng:(double)userLng isAgree:(enum AGREE_STATUS)isAgree
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_AGREE_COMMENT)]];
    
    values=@[@(idCmt),@(userLat),@(userLng),@(isAgree)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"idComment",@"userLat",@"userLng",@"isAgree"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([self isNullData:json])
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
        
        int idCmt=[values[0] integerValue];
        ShopUserComment *cmt=[ShopUserComment commentWithIDComment:idCmt];
        
        if(cmt)
        {
            cmt.agreeStatus=@(as);
            cmt.numOfAgree=numOfAgree;
            
            [[DataManager shareInstance] save];
        }
    }
}

@end
