//
//  RefreshTableView.h
//  Infory
//
//  Created by XXX on 8/26/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefreshTableView : UIView

@property (nonatomic, weak, readonly) UIImageView *imgvRefresh;
@property (nonatomic, weak) UITableView *table;

@end

@interface UITableView(RefreshTableView)

@property (nonatomic, weak, readwrite) RefreshTableView *refreshView;

-(void) showRefresh;
-(void) removeRefresh;

@end