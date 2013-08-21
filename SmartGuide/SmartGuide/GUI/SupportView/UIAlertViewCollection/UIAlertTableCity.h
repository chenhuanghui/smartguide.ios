//
//  UIAlertTableCity.h
//  SmartGuide
//
//  Created by XXX on 8/6/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "UIAlertTableView.h"

@class City;

@interface UIAlertTableCity : UIAlertTableView<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_citys;
}

@property (nonatomic, assign) City *selectedCity;

@end
