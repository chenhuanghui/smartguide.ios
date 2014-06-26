//
//  SGData.h
//  SmartGuide
//
//  Created by MacMini on 24/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGData : NSObject

+(SGData*) shareInstance;

-(NSString*) serverAPI;
-(NSString*) serverIP;
-(NSString*) clientID;
-(NSString*) secrectID;
-(NSString*) elasticAPI;

@property (nonatomic, strong) NSString *fScreen;
@property (nonatomic, strong) NSMutableDictionary *fData;
@property (nonatomic, strong) NSString *numOfNotification;
@property (nonatomic, strong) NSNumber *totalNotification;
@property (nonatomic, strong) NSNumber *isShowedNotice;
@property (nonatomic, strong) NSString *userNotice;
@property (nonatomic, strong) NSNumber *buildMode;
@property (nonatomic, strong) NSString *remoteToken;
@property (nonatomic, strong) NSURL *openURL;

@end
