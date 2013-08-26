//
//  ASIOperationUserCollecition.h
//  SmartGuide
//
//  Created by XXX on 8/7/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationUserCollection : ASIOperationPost

-(ASIOperationUserCollection*) initWithUserID:(int) IDUser lat:(double) lat lon:(double) lon page:(int) page status:(bool) status;

@property (nonatomic, readonly) int totalSP;
@property (nonatomic, readonly) NSMutableArray *userCollection;

@end
