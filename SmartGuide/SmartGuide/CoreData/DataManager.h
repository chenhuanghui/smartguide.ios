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

double userLat();
double userLng();
void setUserLocation(CLLocationCoordinate2D location);
void setUserLat(double newLat);
void setUserLng(double newLng);

User *currentUser();

@interface DataManager : NSObject
{
    __strong User *_currentUser;
}

+(DataManager*) shareInstance;

-(bool) save;

-(void) makeTryUser;

@property (nonatomic, strong) User* currentUser;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@interface CurrentUser : NSObject

+(CurrentUser*) currentUser;

-(enum GENDER_TYPE) enumGender;

-(bool) save;

@property (nonatomic, readwrite) int idUser;
@property (nonatomic, readwrite, strong) NSString *name;
@property (nonatomic, readwrite) int gender;
@property (nonatomic, readwrite, strong) NSString *avatar;
@property (nonatomic, readwrite, strong) NSString *cover;
@property (nonatomic, readwrite, strong) NSString *phone;
@property (nonatomic, readwrite) int socialType;
@property (nonatomic, readwrite, strong) NSString *activationCode;
@property (nonatomic, readwrite, strong) NSString *accessToken;
@property (nonatomic, readwrite, strong) NSString *refreshToken;
@property (nonatomic, readwrite, strong) NSString *facebookToken;
@property (nonatomic, readwrite, strong) NSString *googlePlusToken;

@end