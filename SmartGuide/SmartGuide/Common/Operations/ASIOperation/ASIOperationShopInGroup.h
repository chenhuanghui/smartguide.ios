//
//  ASIOperaionShopInGroup.h
//  SmartGuide
//
//  Created by XXX on 7/28/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@class Group;

@interface ASIOperationShopInGroup : ASIOperationPost
{
    NSArray* _values;
}

-(ASIOperationShopInGroup*) initWithIDCity:(int)idCity idUser:(int) idUser lat:(double) latitude lon:(double) longtitude page:(int) page sort:(enum SORT_BY) sort group:(NSString*) ids;

@property (nonatomic, readonly) NSMutableArray *shops;

@end