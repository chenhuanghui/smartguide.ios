//
//  OperationSearchAutocomplete.h
//  SmartGuide
//
//  Created by MacMini on 03/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationURL.h"

@interface OperationSearchAutocomplete : OperationURL

-(OperationSearchAutocomplete*) initWithKeyword:(NSString*) keyword;

@property (nonatomic, strong) NSString *keyword;
@property (nonatomic, readonly) NSMutableArray *placelists;
@property (nonatomic, readonly) NSMutableArray *shops;
@property (nonatomic, readonly) NSString *highlightTag;

@end

@interface AutocompletePlacelist : NSObject

@property (nonatomic, assign) int idPlacelist;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *highlight;

@end

@interface AutocompleteShop : NSObject

@property (nonatomic, assign) int idShop;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *highlight;

@end