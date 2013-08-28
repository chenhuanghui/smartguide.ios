//
//  ASIOperationGetTotalSP.h
//  SmartGuide
//
//  Created by XXX on 8/29/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationGetTotalSP : ASIOperationPost

-(ASIOperationGetTotalSP*) initWithIDUser:(int) idUser;

@property (nonatomic, readonly) int totalSP;

@end
