//
//  PlacelistCreateCell.h
//  SmartGuide
//
//  Created by MacMini on 14/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextView.h"

enum PLACELIST_CREATE_CELL_MODE {
    PLACELIST_CREATE_CELL_SMALL = 0,
    PLACELIST_CREATE_CELL_DETAIL = 1
    };

@class PlacelistCreateCell;

@protocol PlacelistCreateCellDelegate <NSObject>

-(void) placelistCreateCellTouchedCreate:(PlacelistCreateCell*) cell name:(NSString*) name desc:(NSString*) desc;

@end

@interface PlacelistCreateCell : UITableViewCell
{
    __weak IBOutlet UITextField *txtName;
    __weak IBOutlet TextView *txtDesc;
    __weak IBOutlet UIButton *btnCreate;
    
}

-(void) loadWithMode:(enum PLACELIST_CREATE_CELL_MODE) mode;

-(void) focus;
-(void) clear;

+(NSString *)reuseIdentifier;
+(float) heightWithMode:(enum PLACELIST_CREATE_CELL_MODE) mode;

@property (nonatomic, weak) id<PlacelistCreateCellDelegate> delegate;

@end
