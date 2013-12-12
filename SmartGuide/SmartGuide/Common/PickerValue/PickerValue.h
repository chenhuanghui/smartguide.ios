//
//  PickerValue.h
//  PickerNumber
//
//  Created by MacMini on 11/12/2013.
//  Copyright (c) 2013 MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerValue : UIView<UITableViewDataSource,UITableViewDelegate>
{
}

@end

@interface PickerView : UIView

@property (nonatomic, weak) UITableView *table;

@end