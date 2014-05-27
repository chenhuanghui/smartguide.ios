//
//  EmptyDataCell.m
//  SmartGuide
//
//  Created by MacMini on 20/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "EmptyDataCell.h"

@implementation EmptyDataCell

+(NSString *)reuseIdentifier
{
    return @"EmptyDataCell";
}

@end

@implementation UITableView(EmptyData)

-(void)registerEmptyDataCell
{
    [self registerNib:[UINib nibWithNibName:[EmptyDataCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[EmptyDataCell reuseIdentifier]];
}

-(EmptyDataCell *)emptyDataCell
{
    return [self dequeueReusableCellWithIdentifier:[EmptyDataCell reuseIdentifier]];
}

-(EmptyDataCell *)emptyDataCellWithDesc:(NSString *)desc
{
    EmptyDataCell *cell=[self emptyDataCell];
    cell.lblDesc.text=desc;
    
    return cell;
}

@end