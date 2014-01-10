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

@interface SearchShopCell : UITableViewCell
{
    __weak IBOutlet FTCoreTextView *lbl;
    __weak IBOutlet UIImageView *icon;
    __weak IBOutlet UIImageView *line;
    
    __weak AutocompleteShop* _shop;
    __weak AutocompletePlacelist *_placeauto;
    __weak Placelist *_place;
}

-(void) loadWithDataAutocompleteShop:(AutocompleteShop*) shop;
-(void) loadWithDataAutocompletePlace:(AutocompletePlacelist*) place;
-(void) loadWithPlace:(Placelist*) place;

-(void) setIsLastCell:(bool) isLastCell;

-(id) value;

+(NSString *)reuseIdentifier;
+(float) height;

@end
