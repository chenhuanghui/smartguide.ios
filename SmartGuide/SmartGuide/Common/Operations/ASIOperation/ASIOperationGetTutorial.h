//
//  ASIOperationGetTutorial.h
//  SmartGuide
//
//  Created by MacMini on 26/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "Tutorial.h"

@interface ASIOperationGetTutorial : ASIOperationPost

-(ASIOperationGetTutorial*) initWithIDTutorial:(int) idTutorial userLat:(double) userLat userLng:(double) userLng;

@property (nonatomic, weak) NSMutableArray *tutorials;

@end
