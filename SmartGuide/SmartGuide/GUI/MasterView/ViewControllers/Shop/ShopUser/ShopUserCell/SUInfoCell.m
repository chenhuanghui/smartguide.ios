//
//  SUInfoCell.m
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SUInfoCell.h"
#import "Utility.h"

@implementation SUInfoCell
@synthesize delegate;

+(NSString *)reuseIdentifier
{
    return @"SUInfoCell";
}

+(float)height
{
    return 212;
}

-(IBAction) btnMapTouchUpInside:(id)sender
{
    [self.delegate infoCellTouchedMap:self];
}

-(IBAction) btnMakeCallTouchUpInside:(id)sender
{
    makePhoneCall(@"01225372227");
}

@end
