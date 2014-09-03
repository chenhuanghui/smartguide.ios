//
//  ListShopPlacelistTableCell.h
//  Infory
//
//  Created by XXX on 9/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Label, Place;

@interface ListShopPlacelistTableCell : UITableViewCell
{
    __weak IBOutlet Label *lblDesc;
    __weak IBOutlet Label *lblDanhSach;
    __weak IBOutlet Label *lblName;
    __weak IBOutlet UIView *line1;
    __weak IBOutlet UIView *line2;
    __weak IBOutlet UIImageView *imgvAvatar;
}

-(void) loadWithPlace:(Place*) place;
-(float) calculatorHeight:(Place*) place;

+(NSString *)reuseIdentifier;

@property (nonatomic, assign) bool isPrototypeCell;
@property (nonatomic, weak, readonly) Place *object;

@end

@interface UITableView(ListShopPlacelistTableCell)

-(void) registerListShopPlacelistTableCell;
-(ListShopPlacelistTableCell*) listShopPlacelistTableCell;
-(ListShopPlacelistTableCell*) listShopPlacelistTablePrototypeCell;

@end