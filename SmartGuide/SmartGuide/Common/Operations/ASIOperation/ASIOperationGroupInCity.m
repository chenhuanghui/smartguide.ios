//
//  ASIOperationGroupInCity.m
//  SmartGuide
//
//  Created by XXX on 7/30/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationGroupInCity.h"

@implementation ASIOperationGroupInCity
@synthesize groups,groupContent,groupStatus,groupUrl;

-(ASIOperationGroupInCity *)initWithIDCity:(int)idCity
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_GROUP_IN_CITY)];
    self=[super initWithURL:_url];
    
    bool isRelease=1;
    
    self.values=@[@(idCity),@(isRelease)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"city",@"env"];
}

-(void)startAsynchronous1
{
    NSString *str=[[NSBundle mainBundle] pathForResource:@"groupInCity" ofType:@"txt"];
    NSData *data=[NSData dataWithContentsOfFile:str];
    
    [self onCompletedWithJSON:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:nil]];
    [self notifyCompleted];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    for(Group *group in [Group allObjects])
        [[DataManager shareInstance].managedObjectContext deleteObject:group];
    
    [[DataManager shareInstance] save];
    
    groups=[NSMutableArray array];
    groupUrl=@"";
    groupContent=@"";
    groupStatus=0;
    
    if([self isNullData:json])
        return;
    
    NSDictionary *dict=[json objectAtIndex:0];
    groupStatus=[[NSNumber numberWithObject:[dict objectForKey:@"status"]] integerValue];
    
    if(groupStatus==0)
    {
        groupContent=[NSString stringWithStringDefault:[dict objectForKey:@"content"]];
        groupUrl=[NSString stringWithStringDefault:[dict objectForKey:@"url"]];
    }
    else
    {
        NSArray *arr=[[json objectAtIndex:0] objectForKey:@"content"];
        
        int count=0;
        for(NSDictionary *dic in arr)
        {
            int idGroup=[dic integerForKey:@"id"];
            Group *group=[Group insert];
            
            group.idGroup=@(idGroup);
            group.name=[NSString stringWithStringDefault:[dic objectForKey:@"name"]];
            group.count=[dic objectForKey:@"count"];
            
            count+=group.count.integerValue;
        }
        
        Group *groupAll=[Group insert];
        groupAll.name=@"Tất cả";
        groupAll.idGroup=@(0);
        groupAll.count=@(count);
        
        [[DataManager shareInstance] save];
        
        groups=[[Group allObjects] mutableCopy];
    }
}

@end
