//
//  TabHomeShopCell.h
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Label, HomeShop, Event, TabHomeShopCell, ShopInfoList;

@protocol TabHomeShopCellDelegate <NSObject>

-(void) tabHomeShopCellTouchedCover:(TabHomeShopCell*) cell;

@end

@interface TabHomeShopCell : UITableViewCell
{
}

-(void) loadWithHomeShop:(HomeShop*) obj;
-(void) loadWithEvent:(Event*) obj;
-(void) loadWithShopInfoList:(ShopInfoList*) obj;
-(float) calculateHeight:(id) obj;

+(NSString *)reuseIdentifier;

@property (nonatomic, weak) IBOutlet UIView *displayView;
@property (nonatomic, weak) IBOutlet UIImageView *imgvCover;
@property (nonatomic, weak) IBOutlet Label *lblTitle;
@property (nonatomic, weak) IBOutlet Label *lblContent;
@property (nonatomic, weak) IBOutlet UIImageView *imgvLine;
@property (nonatomic, weak) IBOutlet UIImageView *imgvAvatar;
@property (nonatomic, weak) IBOutlet Label *lblName;
@property (nonatomic, weak) IBOutlet Label *lblDesc;
@property (nonatomic, weak) IBOutlet UIImageView *imgvArrow;
@property (nonatomic, weak) IBOutlet UIImageView *imgvBG;
@property (nonatomic, assign) bool isPrototypeCell;
@property (nonatomic, weak) id<TabHomeShopCellDelegate> delegate;
@property (nonatomic, weak) id object;

@end

@interface UITableView(TabHomeShopCell)

-(void) registerTabHomeShopCell;
-(TabHomeShopCell*) tabHomeShopCell;
-(TabHomeShopCell*) tabHomeShopPrototypeCell;

@end