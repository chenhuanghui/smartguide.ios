//
//  OperationShopInGroup.h
//  SmartGuide
//
//  Created by XXX on 7/19/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationURL.h"

@interface OperationShopInGroup : OperationURL

-(OperationShopInGroup*) initWithIDUser:(int) idUser idCity:(int) idCity idGroup:(int) idGroup pageIndex:(int) page userLatitude:(float) lat userLongtitude:(float) longtitude;

@property (nonatomic, readonly) NSArray *shops;

@end
