//
//  OperationSearchAutocomplete.h
//  SmartGuide
//
//  Created by MacMini on 03/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface OperationSearchAutocomplete : ASIOperationPost

-(OperationSearchAutocomplete*) initWithKeyword:(NSString*) keyword idCity:(int) idCity;

-(NSString*) keyword;
@property (nonatomic, strong) NSMutableArray *placelists;
@property (nonatomic, strong) NSMutableArray *shops;
@property (nonatomic, strong) NSString *highlightTag;

@end

@interface AutoCompleteObject : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *highlight;

@end

@interface AutocompletePlacelist : AutoCompleteObject

@property (nonatomic, strong) NSNumber *idPlacelist;

@end

@interface AutocompleteShop : AutoCompleteObject

@property (nonatomic, strong) NSNumber *idShop;
@property (nonatomic, strong) NSNumber *hasPromotion;

@end