//
//  ASIOperationSearchAutocomplete.h
//  SmartGuide
//
//  Created by MacMini on 02/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

#define AUTOCOMPLETE_IDSHOP @"idShop"
#define AUTOCOMPLETE_IMAGE @"image"
#define AUTOCOMPLETE_PAIRS @"pairs"
#define AUTOCOMPLETE_KEY @"key"
#define AUTOCOMPLETE_IDPLACELIST @"idPlacelist"
#define AUTOCOMPLETE_COVER @"cover"

@interface ASIOperationSearchAutocomplete : ASIOperationPost

-(ASIOperationSearchAutocomplete*) initWithKeyword:(NSString*) keyword userLat:(double) userLat userLng:(double) userLng;

@property (nonatomic, readonly) NSString *keyword;
@property (nonatomic, readonly) NSMutableArray *shops;
@property (nonatomic, readonly) NSMutableArray *placelists;

@end