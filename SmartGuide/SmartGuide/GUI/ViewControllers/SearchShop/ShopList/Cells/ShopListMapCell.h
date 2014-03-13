//
//  ShopListMapCell.h
//  SmartGuide
//
//  Created by MacMini on 06/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapView.h"
#import "ShopListSortView.h"

@class ShopListMapCell;

@protocol ShopListMapDelegate <NSObject>

-(void) shopListMapTouchedLocation:(ShopListMapCell*) map;

@end

@interface ShopListMapCell : UITableViewCell
{
    CGRect _mapFrame;
    __weak IBOutlet UIButton *btnLocation;
}

-(void) tableDidScroll;

-(void) disabelMap;
-(void) enableMap;

+(NSString *)reuseIdentifier;

@property (weak, nonatomic) IBOutlet ShopListSortView *sortView;
@property (weak, nonatomic) IBOutlet MapView *map;
@property (nonatomic, weak) UITableView *table;
@property (nonatomic, weak) UIScrollView *scroll;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, weak) id<ShopListMapDelegate> delegate;

@end
