//
//  ASIOperationGroupInCity.m
//  SmartGuide
//
//  Created by XXX on 7/30/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationGroupInCity.h"

@implementation ASIOperationGroupInCity
@synthesize groups,values;

-(ASIOperationGroupInCity *)initWithIDCity:(int)idCity
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_GROUP_IN_CITY)];
    self=[super initWithURL:_url];
    
    bool isRelease=1;
    
    values=@[@(idCity),@(isRelease)];
    
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
    NSArray *arr=[[json objectAtIndex:0] objectForKey:@"content"];
    
    for(Group *group in [Group allObjects])
        [[DataManager shareInstance].managedObjectContext deleteObject:group];
    
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
    
    groups=[Group allObjects];
}

@end
