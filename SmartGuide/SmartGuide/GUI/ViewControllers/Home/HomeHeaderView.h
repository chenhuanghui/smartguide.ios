//
//  HomeHeaderView.h
//  Infory
//
//  Created by XXX on 7/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserHomeSection;

@interface HomeHeaderView : UIView
{
    __weak IBOutlet UIImageView *imgv;
    __weak IBOutlet UIView *imgvShadow;
    __weak IBOutlet UILabel *lblTitle;
}

-(void) loadWithHomeSection:(UserHomeSection*) homeSection;
+(float) height;

@property (nonatomic, assign) int section;
@property (nonatomic, assign) CGRect originalFrame;
@property (nonatomic, assign) CGRect sectionFrame;
@property (nonatomic, weak) UITableView *table;

@end
