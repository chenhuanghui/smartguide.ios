//
//  ASIOperationGetSG.h
//  SmartGuide
//
//  Created by XXX on 8/27/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationGetSG : ASIOperationPost

-(ASIOperationGetSG*) initWithIDUser:(int) idUser;

@property (nonatomic, readonly) NSNumber *sg;

@end
