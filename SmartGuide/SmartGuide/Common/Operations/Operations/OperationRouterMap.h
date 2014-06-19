//
//  OperationRouterMap.h
//  SmartGuide
//
//  Created by XXX on 8/11/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface OperationRouterMap : ASIOperationPost

-(OperationRouterMap*) initWithSource:(CLLocationCoordinate2D) source destination:(CLLocationCoordinate2D) destination localeIdentifier:(NSString*) localeIdentifier;

@property (nonatomic, strong) NSMutableArray *steps;

@end
