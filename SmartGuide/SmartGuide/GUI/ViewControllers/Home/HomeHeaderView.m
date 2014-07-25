//
//  HomeHeaderView.m
//  Infory
//
//  Created by XXX on 7/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "HomeHeaderView.h"

@implementation HomeHeaderView

- (instancetype)init
{
    self = [[NSBundle mainBundle] loadNibNamed:@"HomeHeaderView" owner:nil options:nil][0];
    if (self) {
        
    }
    return self;
}

+(float)height
{
    return 95;
}

@end
