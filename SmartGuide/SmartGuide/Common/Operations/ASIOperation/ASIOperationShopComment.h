//
//  ASIShopComment.h
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationShopComment : ASIOperationPost

-(ASIOperationShopComment*) initWithIDShop:(int) idShop page:(int) page;

@property (nonatomic, readonly) NSMutableArray *comments;

@end
