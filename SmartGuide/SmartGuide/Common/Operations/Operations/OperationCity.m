//
//  OperationCity.m
//  SmartGuide
//
//  Created by XXX on 7/18/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationCity.h"
#import "City.h"
#import "Versions.h"

@implementation OperationCity
@synthesize cities;

-(OperationCity *)initOperationCity
{
    NSURL *url=[NSURL URLWithString:SERVER_API_MAKE(API_CITY)];
    self=[super initWithURL:url];
    
    
    return self;
}

-(void)start
{
    OperationVersion *version=[[OperationVersion alloc] initWithType:VERSION_CITY];
    version.delegate=self;
    [version start];
}

-(void)operationURLFinished:(OperationURL *)operation
{
    OperationVersion *v=(OperationVersion*)operation;
    
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
}

-(void)operationURLFailed:(OperationURL *)operation
{
    [super start];
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
        
        city.name=[dic objectForKey:@"name"];
    }
    
    [[DataManager shareInstance] save];
    
    cities=[City allObjects];
}

@end
