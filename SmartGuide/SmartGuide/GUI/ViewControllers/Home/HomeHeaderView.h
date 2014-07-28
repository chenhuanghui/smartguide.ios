//
//  HomeHeaderView.h
//  Infory
//
//  Created by XXX on 7/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeHeaderView : UIView
{
    __weak IBOutlet UIImageView *imgv;
    __weak IBOutlet UIView *imgvShadow;
}

+(float) height;

@property (nonatomic, assign) int section;
@property (nonatomic, assign) CGRect originalFrame;
@property (nonatomic, assign) CGRect sectionFrame;
@property (nonatomic, weak) UITableView *table;

@end
