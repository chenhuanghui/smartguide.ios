//
//  ASIOperationSearch.h
//  SmartGuide
//
//  Created by XXX on 8/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationSearchShop : ASIOperationPost

-(ASIOperationSearchShop*) initWithShopName:(NSString*) name idUser:(int) idUser lat:(double) lat lon:(double) lon page:(int) page;

@property (nonatomic, readonly) NSMutableArray *shops;
@property (nonatomic, readonly) NSString *name;

@end
