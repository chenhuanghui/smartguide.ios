//
//  DataManager.h
//  SmartGuide
//
//  Created by XXX on 7/12/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

double userLat();
double userLng();
NSString *userAvatar();
UIImage *userAvatarImage();
UIImage *userAvatarBlurImage();
int userIDCity();

User *currentUser();

@interface DataManager : NSObject
{
    __strong User *_currentUser;
}

+(DataManager*) shareInstance;
-(void) clean;

-(bool) save;

@property (nonatomic, strong) User* currentUser;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end