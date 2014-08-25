//
//  TabHomeImagesCell.h
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagesTableCell.h"

@class HomeImages;

@interface TabHomeImagesCell : ImagesTableCell
{
    __weak HomeImages *_obj;
}

-(void) loadWithHomeImages:(HomeImages*) obj;

+(NSString *)reuseIdentifier;

@end

@interface UITableView(TabHomeImagesCell)

-(void) registerTabHomeImagesCell;
-(TabHomeImagesCell*) tabHomeImagesCell;

@end