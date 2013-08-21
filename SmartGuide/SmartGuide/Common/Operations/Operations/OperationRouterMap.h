//
//  OperationRouterMap.h
//  SmartGuide
//
//  Created by XXX on 8/11/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationURL.h"

@interface OperationRouterMap : OperationURL

-(OperationRouterMap*) initWithSource:(CLLocationCoordinate2D) source destination:(CLLocationCoordinate2D) destination localeIdentifier:(NSString*) localeIdentifier;

@property (nonatomic, readonly) NSMutableArray *steps;

@end
