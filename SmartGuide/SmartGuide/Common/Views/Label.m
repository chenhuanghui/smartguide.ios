//
//  Label.m
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "Label.h"

@implementation Label

-(void)defautSizeToFit
{
    CGRect rect=self.frame;
    [super sizeToFit];
    
    if(self.numberOfLines==1)
    {
        if(self.frame.size.width>rect.size.width)
        {
            rect.origin=self.frame.origin;
            rect.size.height=self.frame.size.height;
            self.frame=rect;
        }
    }
}

@end
