//
//  ASIOperationGroupInCity.h
//  SmartGuide
//
//  Created by XXX on 7/30/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "ShopCatalog.h"

@interface ASIOperationShopCatalog : ASIOperationPost

-(ASIOperationShopCatalog*) initWithIDCity:(NSNumber*) idCity;

@property (nonatomic, readonly) NSMutableArray *groups;
@property (nonatomic, readonly) int groupStatus;
@property (nonatomic, readonly) NSString *groupContent;
@property (nonatomic, readonly) NSString *groupUrl;

@end
