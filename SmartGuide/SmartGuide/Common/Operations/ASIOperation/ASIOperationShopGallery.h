//
//  ASIOperationShopGallery.h
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationShopGallery : ASIOperationPost

-(ASIOperationShopGallery*) initWithIDShop:(int) idShop;

@property (nonatomic, readonly) NSArray *shopGalleries;

@end
