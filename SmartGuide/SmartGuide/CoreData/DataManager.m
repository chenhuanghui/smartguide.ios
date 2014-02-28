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
    return [DataManager shareInstance].currentUser.coordinate.latitude;
}

double userLng()
{
    return [DataManager shareInstance].currentUser.coordinate.longitude;
}

NSString *userAvatar()
{
    return [DataManager shareInstance].currentUser.avatar;
}

UIImage *userAvatarImage()
{
    return [[DataManager shareInstance].currentUser avatarImage];
}

UIImage *userAvatarBlurImage()
{
    return [[DataManager shareInstance].currentUser avatarBlurImage];
}

void setUserLocation(CLLocationCoordinate2D location)
{
    [DataManager shareInstance].currentUser.coordinate=location;
}

void setUserLat(double newLat)
{
    [DataManager shareInstance].currentUser.coordinate=CLLocationCoordinate2DMake(newLat, userLng());
}

void setUserLng(double newLng)
{
    [DataManager shareInstance].currentUser.coordinate=CLLocationCoordinate2DMake(userLat(), newLng);
}

User *currentUser()
{
    return [DataManager shareInstance].currentUser;
}

static DataManager *_dataManager=nil;
@implementation DataManager
@synthesize managedObjectContext,managedObjectModel,persistentStoreCoordinator;
@synthesize currentUser;

+(DataManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dataManager=[[DataManager alloc] init];
        [_dataManager loadDatabase];
    });
    
    return _dataManager;
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
@end