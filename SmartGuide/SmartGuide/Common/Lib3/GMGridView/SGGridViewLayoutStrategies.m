//
//  SGGridViewLayoutStrategies.m
//  SmartGuide
//
//  Created by MacMini on 22/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGGridViewLayoutStrategies.h"

@implementation SGGridViewLayoutHorizontalPagedLTRStrategy

- (id)init
{
    self = [super init];
    if (self) {
        _type=SGGridViewLayoutHorizontalPagedLTR;
    }
    return self;
}

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

@implementation SGGridViewLayoutHorizontalPagedLTRStrategyImage
@synthesize numberOfNext;

- (id)init
{
    self = [super init];
    if (self) {
        _type=SGGridViewLayoutHorizontalPagedLTRImage;
        numberOfNext=0;
    }
    return self;
}

- (NSRange)rangeOfPositionsInBoundsFromOffset:(CGPoint)offset
{
    CGPoint contentOffset = CGPointMake(MAX(0, offset.x),
                                        MAX(0, offset.y));
    
    NSInteger page = floor(contentOffset.x / self.gridBounds.size.width);
    
    NSInteger firstPosition = MAX(0, (page - 1) * self.numberOfItemsPerPage);
    NSInteger lastPosition  = MIN(firstPosition + 3 * self.numberOfItemsPerPage+numberOfNext, self.itemCount);
    
    return NSMakeRange(firstPosition, (lastPosition - firstPosition));
}

@end