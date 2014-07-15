//
//  ScanResultInforyShareCell.m
//  Infory
//
//  Created by XXX on 7/15/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultInforyShareCell.h"
#import "FacebookManager.h"
#import "GooglePlusManager.h"

@implementation ScanResultInforyShareCell

-(void)loadWithLink:(NSString *)url
{
    _url=[NSURL URLWithString:url];
}

-(IBAction) btnFBTouchUpInside:(id)sender
{
    [[FacebookManager shareInstance] shareLink:_url];
}

-(IBAction) btnGPTouchUpInside:(id)sender
{
    [[GooglePlusManager shareInstance] shareLink:_url];
}

+(float)height
{
    return 44;
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultInforyShareCell";
}

@end

@implementation UITableView(ScanResultInforyShareCell)

-(void)registerScanResultInforyShareCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultInforyShareCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultInforyShareCell reuseIdentifier]];
}

-(ScanResultInforyShareCell *)scanResultInforyShareCell
{
    return [self dequeueReusableCellWithIdentifier:[ScanResultInforyShareCell reuseIdentifier]];
}

@end