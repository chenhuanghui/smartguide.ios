//
//  ASIOperationCity.m
//  SmartGuide
//
//  Created by XXX on 7/30/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationCity.h"
#import "ASIOperationVersion.h"
#import "Versions.h"

@implementation ASIOperationCity
@synthesize cities;

-(ASIOperationCity *)initOperationCity
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_CITY)];
    self=[super initWithURL:_url];
    
    return self;
}

-(void)startAsynchronous
{
//    NSString *str=[[NSBundle mainBundle] pathForResource:@"city" ofType:@"txt"];
//    NSData *data=[NSData dataWithContentsOfFile:str];
//    
//    [self onCompletedWithJSON:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:nil]];
//    [self notifyCompleted];
//    return;
    version=[[ASIOperationVersion alloc] initWithType:VERSION_CITY];
    version.delegatePost=self;
    [version startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    ASIOperationVersion *v=(ASIOperationVersion*)operation;
    
    NSString *cityVersionClient=[Versions versionWithType:VERSION_CITY];
    NSString *cityVersionServer=v.version;
    
    [Versions setVersion:VERSION_CITY version:cityVersionServer];
    
    [[DataManager shareInstance] save];
    
    if(![cityVersionClient isEqualToString:cityVersionServer])
        [super start];
    else
    {
        cities=[City allObjects];
        [self notifyCompleted];
    }

    version=nil;
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    version=nil;
    [super startAsynchronous];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    for(NSDictionary *dic in json)
    {
        int idCity=[dic integerForKey:@"id"];
        City *city = [City cityWithID:idCity];
        if(!city)
        {
            city=[City insert];
            city.idCity=[NSNumber numberWithInt:idCity];
        }
        
        city.name=[NSString stringWithStringDefault:[dic objectForKey:@"name"]];
    }
    
    [[DataManager shareInstance] save];
    
    cities=[City allObjects];
}

@end
