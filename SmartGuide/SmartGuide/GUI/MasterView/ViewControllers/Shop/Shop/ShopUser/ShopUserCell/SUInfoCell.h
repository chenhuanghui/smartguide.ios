//
//  SUInfoCell.h
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop.h"
#import "LabelTopText.h"

@class SUInfoCell;

@protocol InfoCelLDelegate <NSObject>

-(void) infoCellTouchedMap:(SUInfoCell*) cell;

@end

@interface SUInfoCell : UITableViewCell
{
    __weak IBOutlet LabelTopText *lblAddress;
    __weak IBOutlet UIButton *btnTel;
    __weak IBOutlet UIImageView *line;
    
    __weak Shop *_shop;
}

-(void) loadWithShop:(Shop*) shop;

+(float) heightWithAddress:(NSString*) address;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak) id<InfoCelLDelegate> delegate;

@end

@interface SUInfoBG : UIView

@end