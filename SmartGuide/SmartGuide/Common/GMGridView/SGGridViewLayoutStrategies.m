//
//  SGGridViewLayoutStrategies.m
//  SmartGuide
//
//  Created by MacMini on 22/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGGridViewLayoutStrategies.h"

@implementation SGGridViewLayoutHorizontalPagedLTRStrategy

- (NSRange)rangeOfPositionsInBoundsFromOffset:(CGPoint)offset
{
    CGPoint contentOffset = CGPointMake(MAX(0, offset.x),
                                        MAX(0, offset.y));
    
    NSInteger page = floor(contentOffset.x / self.gridBounds.size.width);
    
    NSInteger firstPosition = MAX(0, (page) * self.numberOfItemsPerPage);
    NSInteger lastPosition  = MIN(firstPosition + 3 * self.numberOfItemsPerPage+1, self.itemCount);
    
    return NSMakeRange(firstPosition, (lastPosition - firstPosition));
}

@end
