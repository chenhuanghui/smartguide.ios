//
//  OperationSearchAutocomplete.h
//  SmartGuide
//
//  Created by MacMini on 03/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationURL.h"

@interface OperationSearchAutocomplete : OperationURL

-(OperationSearchAutocomplete*) initWithKeyword:(NSString*) keyword idCity:(int) idCity;

@property (nonatomic, strong) NSString *keyword;
@property (nonatomic, strong) NSMutableArray *placelists;
@property (nonatomic, strong) NSMutableArray *shops;
@property (nonatomic, strong) NSString *highlightTag;

@end

@interface AutocompletePlacelist : NSObject

@property (nonatomic, strong) NSNumber *idPlacelist;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *highlight;

@end

@interface AutocompleteShop : NSObject

@property (nonatomic, strong) NSNumber *idShop;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *highlight;
@property (nonatomic, strong) NSNumber *hasPromotion;

@end