//
//  SUInfoCell.h
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop.h"

@class SUInfoCell;

@protocol InfoCelLDelegate <NSObject>

-(void) infoCellTouchedMap:(SUInfoCell*) cell;

@end

@interface SUInfoCell : UITableViewCell
{
    __weak IBOutlet UILabel *lblAddress;
    __weak IBOutlet UILabel *lblCity;
    __weak IBOutlet UIButton *btnTel;
    
    __weak Shop *_shop;
}

-(void) loadWithShop:(Shop*) shop;

+(float) height;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak) id<InfoCelLDelegate> delegate;

@end
