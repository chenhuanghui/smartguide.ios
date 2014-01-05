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

+(void)load
{
    NSArray *users=[User allObjects];
    
    if(users.count>0)
        [DataManager shareInstance].currentUser=users[0];
    else
        [[DataManager shareInstance] makeTryUser];
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

-(void)makeTryUser
{
    [User markDeleteAllObjects];
    [[DataManager shareInstance] save];
    
    [Flags setLastIDUser:DEFAULT_USER_ID];
    
    User *user=[User insert];
    
    user.socialType=@(SOCIAL_NONE);
    
    [[DataManager shareInstance] save];
    
    [DataManager shareInstance].currentUser=user;
    
    [[TokenManager shareInstance] setPhone:DEFAULT_USER_PHONE];
    [[TokenManager shareInstance] setActiveCode:DEFAULT_USER_ACTIVE_CODE];
    [[TokenManager shareInstance] setAccessToken:DEFAULT_USER_ACCESS_TOKEN];
}

@end

@implementation CurrentUser

+(void)load
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser_idUser"])
        [[NSUserDefaults standardUserDefaults] setInteger:-1 forKey:@"currentUser_idUser"];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser_name"])
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"currentUser_name"];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser_gender"])
        [[NSUserDefaults standardUserDefaults] setInteger:GENDER_NONE forKey:@"currentUser_gender"];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser_avatar"])
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"currentUser_avatar"];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser_cover"])
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"currentUser_cover"];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser_phone"])
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"currentUser_phone"];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser_socialType"])
        [[NSUserDefaults standardUserDefaults] setInteger:SOCIAL_NONE forKey:@"currentUser_socialType"];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser_facebookToken"])
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"currentUser_facebookToken"];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser_googlePlusToken"])
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"currentUser_googlePlusToken"];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser_accessToken"])
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"currentUser_accessToken"];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser_refreshToken"])
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"currentUser_refreshToken"];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser_activationCode"])
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"currentUser_activtionCode"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(int)idUser
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"currentUser_idUser"];
}

-(void)setIdUser:(int)idUser
{
    [[NSUserDefaults standardUserDefaults] setInteger:idUser forKey:@"currentUser_idUser"];
}

-(NSString *)name
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"currentUser_name"];
}

-(void)setName:(NSString *)name
{
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"currentUser_name"];
}

-(int)gender
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"currentUser_gender"];
}

-(void)setGender:(int)gender
{
    [[NSUserDefaults standardUserDefaults] setInteger:gender forKey:@"currentUser_gender"];
}

-(NSString *)avatar
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"currentUser_avatar"];
}

-(void)setAvatar:(NSString *)avatar
{
    [[NSUserDefaults standardUserDefaults] setObject:avatar forKey:@"currentUser_avatar"];
}

-(NSString *)cover
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"currentUser_cover"];
}

-(void)setCover:(NSString *)cover
{
    [[NSUserDefaults standardUserDefaults] setObject:cover forKey:@"currentUser_cover"];
}

-(NSString *)phone
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"currentUser_phone"];
}

-(void)setPhone:(NSString *)phone
{
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"currentUser_phone"];
}

-(int)socialType
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"currentUser_socialType"];
}

-(void)setSocialType:(int)socialType
{
    [[NSUserDefaults standardUserDefaults] setInteger:socialType forKey:@"currentUser_socialType"];
}

-(NSString *)activationCode
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"currentUser_activationCode"];
}

-(void)setActivationCode:(NSString *)activationCode
{
    [[NSUserDefaults standardUserDefaults] setObject:activationCode forKey:@"currentUser_activationCode"];
}

-(NSString *)accessToken
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"currentUser_accessToken"];
}

-(void)setAccessToken:(NSString *)accessToken
{
    [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:@"currentUser_accessToken"];
}

-(NSString *)refreshToken
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"currentUser_refreshToken"];
}

-(void)setRefreshToken:(NSString *)refreshToken
{
    [[NSUserDefaults standardUserDefaults] setObject:refreshToken forKey:@"currentUser_refreshToken"];
}

-(NSString *)facebookToken
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"currentUser_facebookToken"];
}

-(void)setFacebookToken:(NSString *)facebookToken
{
    [[NSUserDefaults standardUserDefaults] setObject:facebookToken forKey:@"currentUser_facebookToken"];
}

-(NSString *)googlePlusToken
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"currentUser_googlePlusToken"];
}

-(void)setGooglePlusToken:(NSString *)googlePlusToken
{
    [[NSUserDefaults standardUserDefaults] setObject:googlePlusToken forKey:@"currentUser_googlePlusToken"];
}

-(bool)save
{
    return [[NSUserDefaults standardUserDefaults] synchronize];
}

-(enum GENDER_TYPE)enumGender
{
    switch (self.gender) {
        case 0:
            return GENDER_FEMALE;
            
        case 1:
            return GENDER_MALE;
            
        default:
            return GENDER_NONE;
    }
}

@end