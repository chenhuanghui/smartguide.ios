//
//  HomeHeaderView.m
//  Infory
//
//  Created by XXX on 7/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "HomeHeaderView.h"
#import "Utility.h"
#import "UserHomeSection.h"
#import "UserHome.h"
#import "ImageManager.h"

@implementation HomeHeaderView

- (instancetype)init
{
    self = [[NSBundle mainBundle] loadNibNamed:@"HomeHeaderView" owner:nil options:nil][0];
    if (self) {
        
    }
    return self;
}

-(void)loadWithHomeSection:(UserHomeSection *)homeSection
{
    lblTitle.text=homeSection.home9.title;
}

+(float)height
{
    return 51;
}

@end
