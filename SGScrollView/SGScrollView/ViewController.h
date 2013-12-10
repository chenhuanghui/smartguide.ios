//
//  ViewController.h
//  SGScrollView
//
//  Created by MacMini on 10/12/2013.
//  Copyright (c) 2013 MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGScrollView.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet SGScrollView *scroll;
    __weak IBOutlet UIView *v1;    
    __weak IBOutlet UITableView *table;
}

@end
