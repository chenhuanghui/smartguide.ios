//
//  OperationGroup.m
//  SmartGuide
//
//  Created by XXX on 7/18/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationGroupInCity.h"
#import "Group.h"

@implementation OperationGroupInCity
@synthesize groups;

-(OperationGroupInCity *)initWithIDCity:(int)idCity
{
    NSURL *url=[NSURL URLWithString:SERVER_API_MAKE(API_GROUP_IN_CITY(idCity))];
    self=[super initWithURL:url];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    for(NSDictionary *dic in json)
    {
        int idGroup=[dic integerForKey:@"id"];
        Group *group=[Group groupWithIDGroup:idGroup];
        
        if(!group)
        {
            group=[Group insert];
            group.idGroup=[NSNumber numberWithInt:idGroup];
        }
        
        group.name=[dic objectForKey:@"name"];
        group.count=[dic objectForKey:@"count"];
    }
    
    [[DataManager shareInstance] save];
    
    groups=[Group allObjects];
}

@end
