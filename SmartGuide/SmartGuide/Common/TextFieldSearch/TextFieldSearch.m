//
//  TextFieldSearch.m
//  SmartGuide
//
//  Created by MacMini on 10/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TextFieldSearch.h"

@implementation TextFieldSearch

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    
    [self commonInit];
    
    return self;
}

-(void) commonInit
{
    self.background=[UIImage imageNamed:@"button_search_home.png"];
}

-(void)drawPlaceholderInRect:(CGRect)rect
{
    rect.origin.y=10;
    
    [[UIColor colorWithRed:91.f/225 green:91.f/255 blue:91.f/255 alpha:1] set];
    [self.placeholder drawInRect:rect withFont:self.font lineBreakMode:NSLineBreakByTruncatingTail alignment:NSTextAlignmentCenter];
}

@end
