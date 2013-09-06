//
//  UpdateVersion.m
//  SmartGuide
//
//  Created by XXX on 9/5/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "UpdateVersion.h"

@implementation UpdateVersion
@synthesize delegate;

- (id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"UpdateVersion" owner:nil options:nil] objectAtIndex:0];
    
    self.center=CGPointMake(self.center.x, self.center.y+20);
    
    return self;
}

- (IBAction)btnDGTouchUpInside:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://smartguide.vn"]];
}

- (IBAction)btnCloseTouchUpInside:(id)sender {
    [delegate updateVersionClose:self];
}

@end
