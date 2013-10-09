//
//  UserPin.m
//  SmartGuide
//
//  Created by XXX on 7/12/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "UserPin.h"

@implementation UserPin

-(UserPin *)initWithUser:(NSString *)user
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"UserPin" owner:nil options:nil] objectAtIndex:0];
    
    return self;
}

@end
