//
//  ASIOperationGetShopList.h
//  SmartGuide
//
//  Created by MacMini on 24/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationGetShopList : ASIOperationPost

-(ASIOperationGetShopList*) initWithIDShops:(NSString*) idShops userLat:(double) userLat userLng:(double) userLng page:(int) page sort:(enum SORT_LIST) sort idBranch:(int) idBranch;

@property (nonatomic, strong) NSMutableArray *shopLists;

@end
