//
//  DataManager.m
//  SmartGuide
//
//  Created by XXX on 7/12/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "DataManager.h"
#import "Utility.h"
#import "Constant.h"
#import "Flags.h"
#import "TokenManager.h"

double userLat()
{
    return [DataManager shareInstance].currentUser.location.latitude;
}

double userLng()
{
    return [DataManager shareInstance].currentUser.location.longitude;
}

void setUserLocation(CLLocationCoordinate2D location)
{
    [DataManager shareInstance].currentUser.location=location;
}

void setUserLat(double newLat)
{
    [DataManager shareInstance].currentUser.location=CLLocationCoordinate2DMake(newLat, userLng());
}

void setUserLng(double newLng)
{
    [DataManager shareInstance].currentUser.location=CLLocationCoordinate2DMake(userLat(), newLng);
}

static DataManager *_dataManager=nil;
@implementation DataManager
@synthesize managedObjectContext,managedObjectModel,persistentStoreCoordinator;
@synthesize currentUser,currentCity;

+(void)load
{
    [DataManager shareInstance].currentUser=[User userWithIDUser:[Flags lastIDUser]];
    
    if(![DataManager shareInstance].currentUser)
    {
        [[DataManager shareInstance] makeTryUser];
    }
}

+(DataManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dataManager=[[DataManager alloc] init];
        [_dataManager loadDatabase];
    });
    
    return _dataManager;
}

-(int)setUserCity:(NSString *)cityName
{
    int idCity=-1;
    
    self.currentCity=nil;
    NSArray *cities=[City allObjects];
    for(City *city in cities)
    {
        if([city.name isContainString:cityName])
        {
            idCity=city.idCity.integerValue;
            self.currentCity=city;
            break;
        }
    }
    
    if(idCity==-1)
        self.currentCity=[City HCMCity];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_DETECTED_USER_CITY object:self.currentCity.idCity];
    
    return self.currentCity.idCity.integerValue;
}

-(void) loadDatabase
{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SmartGuide" withExtension:@"mom"];
    if(!modelURL)
    {
        modelURL = [[NSBundle mainBundle] URLForResource:@"SmartGuide" withExtension:@"momd"];
    }
    
    self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
    						 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
    						 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    NSError *error=nil;
    [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[self storeURL] options:options error:&error];
    
    if(error)
    {
        NSLog(@"persistentStoreCoordinator error %@",error);
        [[NSFileManager defaultManager] removeItemAtURL:[self storeURL] error:nil];
        //xoa database->mat thong tin user da dang nhap->remove token->dang nhap lai
        [Flags removeLastIDUser];
        [Flags removeToken];
        [self loadDatabase];
        return;
    }
    
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
}

-(NSURL*) storeURL
{
    NSURL *url=[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    url=[url URLByAppendingPathComponent:@"SmartGuide.sqlite"];
    
    return url;
}

-(bool)save
{
    NSError *error=nil;
    [self.managedObjectContext save:&error];
    if(error)
    {
        NSLog(@"DataManager save error %@",error);
        return false;
    }
    
    return true;
}

-(void)loadDefaultFilter
{
    Filter *filter=[DataManager shareInstance].currentUser.filter;
    
    if(!filter)
    {
        filter=[Filter insert];
        
        filter.distance=@(true);
        filter.isShopKM=@(false);
        filter.food=@(true);
        filter.drink=@(true);
        filter.health=@(true);
        filter.entertaiment=@(true);
        filter.fashion=@(true);
        filter.travel=@(true);
        filter.production=@(true);
        filter.education=@(true);
        
        [DataManager shareInstance].currentUser.filter=filter;
        
        [[DataManager shareInstance] save];
    }
}

-(void)updateFilterWithSelectedGroup:(ShopCatalog *)group
{
    Filter *filter=[DataManager shareInstance].currentUser.filter;
    
    if(!filter)
    {
        [self loadDefaultFilter];
        [self updateFilterWithSelectedGroup:group];
        return;
    }
    
    filter.food=@(true);
    filter.drink=@(true);
    filter.health=@(true);
    filter.entertaiment=@(true);
    filter.fashion=@(true);
    filter.travel=@(true);
    filter.production=@(true);
    filter.education=@(true);
}

-(void)makeTryUser
{
    [Flags setLastIDUser:DEFAULT_USER_ID];
    
    User *user=[User userWithIDUser:DEFAULT_USER_ID];
    
    if(!user)
    {
        user=[User insert];
    }
    
    user.idUser=@(DEFAULT_USER_ID);
    user.isConnectedFacebook=@(true);
    
    [[DataManager shareInstance] save];
    
    [DataManager shareInstance].currentUser=user;
    
    [[TokenManager shareInstance] setPhone:DEFAULT_USER_PHONE];
    [[TokenManager shareInstance] setActiveCode:DEFAULT_USER_ACTIVE_CODE];
    [[TokenManager shareInstance] setAccessToken:DEFAULT_USER_ACCESS_TOKEN];
}

-(void)setCurrentUser:(User *)_currentUser
{
    currentUser=_currentUser;
    
    if(currentUser)
    {
        Filter *filter=currentUser.filter;
        
        if(!filter)
        {
            [self loadDefaultFilter];
        }
    }
}

@end
