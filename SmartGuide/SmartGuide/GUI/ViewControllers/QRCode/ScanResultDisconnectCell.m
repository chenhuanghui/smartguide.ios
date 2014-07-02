//
//  ScanResultDisconnectCell.m
//  Infory
//
//  Created by XXX on 7/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultDisconnectCell.h"

@implementation ScanResultDisconnectCell

+(NSString *)reuseIdentifier
{
    return @"ScanResultDisconnectCell";
}

+(float)height
{
    return 200;
}

- (IBAction)btnTouchUpInside:(id)sender {
    [self.delegate scanResultDisconnectCellTouchedTry:self];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    UIImage *img=[[UIImage imageNamed:@"bg_viewer_button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(23, 23, 23, 23)];
    
    [btn setBackgroundImage:img forState:UIControlStateNormal];
}

@end

@implementation UITableView(ScanResultDisconnectCell)

-(void)registerScanResultDisconnectCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultDisconnectCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultDisconnectCell reuseIdentifier]];
}

-(ScanResultDisconnectCell *)scanResultDisconnectCell
{
    return [self dequeueReusableCellWithIdentifier:[ScanResultDisconnectCell reuseIdentifier]];
}

@end