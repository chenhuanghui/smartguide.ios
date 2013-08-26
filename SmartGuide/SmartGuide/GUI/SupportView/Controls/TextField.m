//
//  TextField.m
//  SmartGuide
//
//  Created by XXX on 8/25/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "TextField.h"

@implementation TextField
@synthesize delegate;

-(void)deleteBackward
{
    bool allowDelete=true;
    if(delegate && [delegate respondsToSelector:@selector(textFieldDeleteBackward)])
        allowDelete=[delegate textFieldDeleteBackward];
    
    if(allowDelete)
        [super deleteBackward];
}

@end
