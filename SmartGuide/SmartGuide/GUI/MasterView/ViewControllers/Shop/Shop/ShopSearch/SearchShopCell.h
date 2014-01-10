//
//  SearchShopCell.h
//  SmartGuide
//
//  Created by MacMini on 02/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTCoreTextView.h"
#import "Placelist.h"
#import "OperationSearchAutocomplete.h"

enum SEARCH_SHOP_CELL_TYPE {
    SEARCH_SHOP_CELL_MID = 0,
    SEARCH_SHOP_CELL_FIRST = 1,
    SEARCH_SHOP_CELL_LAST = 2
    };

@interface SearchShopCell : UITableViewCell
{
    __weak IBOutlet FTCoreTextView *lbl;
    __weak IBOutlet UIImageView *icon;
    __weak IBOutlet UIImageView *lineTop;
    __weak IBOutlet UIImageView *lineBottom;
    
    __weak AutocompleteShop* _shop;
    __weak AutocompletePlacelist *_placeauto;
    __weak Placelist *_place;
}

-(void) loadWithDataAutocompleteShop:(AutocompleteShop*) shop;
-(void) loadWithDataAutocompletePlace:(AutocompletePlacelist*) place;
-(void) loadWithPlace:(Placelist*) place;

-(void) setCellType:(enum SEARCH_SHOP_CELL_TYPE) cellType;

-(id) value;

+(NSString *)reuseIdentifier;
+(float) height;

@end
