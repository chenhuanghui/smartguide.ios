//
//  DataManager.m
//  SmartGuide
//
//  Created by XXX on 7/12/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "DataManager.h"
#import "LocationManager.h"
#import "Utility.h"
#import "Constant.h"
#import "Flags.h"
#import "TokenManager.h"
#import "UserHome.h"
#import "UserPromotion.h"
#import "UserNotification.h"

double userLat()
{
    return [[LocationManager shareInstance] userlocation].latitude;
}

double userLng()
{
    return [[LocationManager shareInstance] userlocation].longitude;
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

User *currentUser()
{
    return [DataManager shareInstance].currentUser;
}

int userIDCity()
{
    return [currentUser().idCity integerValue];
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

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)clean
{
    [UserHome markDeleteAllObjects];
    [UserPromotion markDeleteAllObjects];
    [UserNotification markDeleteAllObjects];
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
        DLOG_ERROR(@"persistentStoreCoordinator error %@",error);
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
        DLOG_ERROR(@"DataManager save error %@",error);
        return false;
    }
    
    return true;
}
@end