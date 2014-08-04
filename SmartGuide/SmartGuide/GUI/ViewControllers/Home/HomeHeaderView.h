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
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UIImageView *imgvBlur;
}

-(void) loadWithHomeSection:(UserHomeSection*) homeSection;
+(float) height;

@property (nonatomic, assign) int section;
@property (nonatomic, weak) UITableView *table;
@property (nonatomic, assign) float alignY;

@end
