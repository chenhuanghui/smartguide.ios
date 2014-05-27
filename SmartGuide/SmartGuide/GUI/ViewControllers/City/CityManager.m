//
//  CityManager.m
//  Infory
//
//  Created by XXX on 5/21/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "CityManager.h"
#import "Utility.h"
#import "Flags.h"

static CityManager *_cityManager=nil;
@implementation CityManager

+(CityManager*) shareInstance
{
    if(!_cityManager)
        _cityManager=[CityManager new];
    
    return _cityManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)load
{
    NSArray *cityList=CITY_LIST();
    self.cities=[NSMutableArray new];
    
    for(NSDictionary *dict in cityList)
    {
        [self.cities addObject:[CityObject makeWithDictionary:dict]];
    }
    
    if(self.cities.count>0)
    {
        [self.cities sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [[obj1 name] localizedStandardCompare:[obj2 name]];
        }];
        
        CityObject *obj=[self.cities filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"idCity==140"]][0];
        
        [self.cities removeObject:obj];
        [self.cities insertObject:obj atIndex:0];
        
        obj=[self.cities filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"idCity==1"]][0];
        [self.cities removeObject:obj];
        [self.cities insertObject:obj atIndex:0];
    }
}

-(void)clean
{
    _cityManager=nil;
    [self.cities removeAllObjects];
    self.cities=nil;
}

-(void)setIdCitySearch:(NSNumber *)idCitySearch_
{
    if(![Flags idCitySearch] || [[Flags idCitySearch] integerValue]!=idCitySearch_.integerValue)
    {
        [Flags setIDCitySearch:idCitySearch_.integerValue];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_CHANGED_CITY_SEARCH object:idCitySearch_];
    }
}

-(NSNumber *)idCitySearch
{
    return [Flags idCitySearch];
}

@end

@implementation CityObject

+(CityObject *)makeWithDictionary:(NSDictionary *)dict
{
    CityObject *obj=[CityObject new];
    
    obj.idCity=[NSNumber numberWithObject:dict[@"id"]];
    obj.name=[NSString stringWithStringDefault:dict[@"name"]];
    obj.nameHeight=@(-1);
    
    return obj;
}

@end