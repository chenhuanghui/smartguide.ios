//
//  TableTableCell.m
//  Infory
//
//  Created by XXX on 9/9/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TableTableCell.h"
#import "Utility.h"

@implementation TableTableCell

-(void)setTableParent:(UITableView *)tableParent
{
    if(_tableParent)
        [_tableParent removeObserver:self forKeyPath:@"contentOffset"];
    
    _tableParent=tableParent;
    
    if(_tableParent)
        [_tableParent addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSIndexPath *idx=[self.tableParent indexPathForCell:self];
    
    if(!idx)
        return;
    
    CGRect rect=[self.tableParent rectForRowAtIndexPath:idx];
    float height=[self.tableParent rectForHeaderInSection:idx.section].size.height;
    
    float y=self.tableParent.contentOffset.y+height-rect.origin.y;
    if(y>0)
    {
        self.table.OY=y;
        self.table.COY=y;
    }
    else
    {
        self.table.OY=0;
        self.table.COY=0;
    }
}

@end
