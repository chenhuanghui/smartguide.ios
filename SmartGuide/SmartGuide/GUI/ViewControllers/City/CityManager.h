//
//  CityManager.h
//  Infory
//
//  Created by XXX on 5/21/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CityObject;

@interface CityManager : NSObject

+(CityManager*) shareInstance;

-(NSArray*) filterCityWithCityName:(NSString*) cityName;

-(void) load;
-(void) loadCompletion:(void(^)()) onCompleted;
-(void) clean;
-(CityObject*) cityByID:(NSNumber*) idCity;

@property (nonatomic, strong) NSMutableArray *cities;
@property (nonatomic, readwrite) NSNumber *idCitySearch;
@property (nonatomic, readonly) bool isLoaded;

@end

@interface CityObject : NSObject

+(CityObject*) makeWithDictionary:(NSDictionary*) dict;

@property (nonatomic, strong) NSNumber *idCity;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *nameHeight;
@property (nonatomic, strong) NSString *nameACI;

@end