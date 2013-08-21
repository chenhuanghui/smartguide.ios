//
//  ASIOperationGetAds.h
//  SmartGuide
//
//  Created by XXX on 8/8/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationGetAds : ASIOperationPost

-(ASIOperationGetAds*) initAds;

@property (nonatomic, readonly) NSMutableArray *arrAds;

@end
