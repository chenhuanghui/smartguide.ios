//
//  CityManager.h
//  Infory
//
//  Created by XXX on 5/21/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityManager : NSObject

+(CityManager*) shareInstance;

-(void) load;
-(void) clean;

@property (nonatomic, strong) NSMutableArray *cities;
@property (nonatomic, readwrite) NSNumber *idCitySearch;

@end

@interface CityObject : NSObject

+(CityObject*) makeWithDictionary:(NSDictionary*) dict;

@property (nonatomic, strong) NSNumber *idCity;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *nameHeight;

@end