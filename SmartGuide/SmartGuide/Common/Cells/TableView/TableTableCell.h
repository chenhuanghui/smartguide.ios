//
//  TableTableCell.h
//  Infory
//
//  Created by XXX on 9/9/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, weak) UITableView *tableParent;

@end
