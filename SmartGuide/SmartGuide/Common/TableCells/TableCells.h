//
//  TableCells.h
//  Infory
//
//  Created by XXX on 8/22/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableCellDynamicHeight <NSObject>

-(float) calculateHeight:(id) obj;
-(void) loadImages;

@end