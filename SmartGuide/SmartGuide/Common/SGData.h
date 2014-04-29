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

@property (nonatomic, strong) NSString *fScreen;
@property (nonatomic, strong) NSMutableDictionary *fData;
@property (nonatomic, strong) NSString *numOfNotification;
@property (nonatomic, strong) NSNumber *totalNotification;
@property (nonatomic, strong) NSNumber *isShowedNotice;
@property (nonatomic, strong) NSString *userNotice;

@end
