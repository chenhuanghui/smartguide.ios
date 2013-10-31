//
//  DataManager.h
//  SmartGuide
//
//  Created by XXX on 7/12/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "City.h"
#import "ShopCatalog.h"
#import "Filter.h"

@interface DataManager : NSObject

+(DataManager*) shareInstance;

-(int) setUserCity:(NSString*) city;

-(bool) save;

-(void) loadDefaultFilter;
-(void) updateFilterWithSelectedGroup:(ShopCatalog*) group;

@property (nonatomic, strong) User *currentUser;
@property (nonatomic, strong) City *currentCity;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end
