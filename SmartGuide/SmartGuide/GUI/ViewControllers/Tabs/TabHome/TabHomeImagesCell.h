//
//  TabHomeImagesCell.h
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagesTableCell.h"

@class HomeImages, HomeImage, TabHomeImagesCell;

@protocol TabHomeImagesCellDelegate <NSObject>

-(void) tabHomeImagesCell:(TabHomeImagesCell*) cell selectedImage:(HomeImage*) obj;

@end

@interface TabHomeImagesCell : ImagesTableCell
{
    __weak HomeImages *_obj;
}

-(void) loadWithHomeImages:(HomeImages*) obj;

+(NSString *)reuseIdentifier;
+(float) heightWithHomeImages:(HomeImages*) obj width:(float) width;

@property (nonatomic, weak) id<TabHomeImagesCellDelegate> delegate;

@end

@interface UITableView(TabHomeImagesCell)

-(void) registerTabHomeImagesCell;
-(TabHomeImagesCell*) tabHomeImagesCell;

@end