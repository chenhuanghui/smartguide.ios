//
//  TabSearchTableCell.h
//  Infory
//
//  Created by XXX on 8/27/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchPlacelist, AutocompletePlacelist, AutocompleteShop;

@interface TabSearchTableCell : UITableViewCell
{
    __weak IBOutlet UIView *line;
    __weak IBOutlet UILabel *lbl;
    __weak IBOutlet UIImageView *imgvArrow;
    
    __weak id _obj;
}

-(void) loadWithPlacelist:(SearchPlacelist*) obj;
-(void) loadWithAutoCompletePlacelist:(AutocompletePlacelist*) obj;
-(void) loadWithAutoCompleteShop:(AutocompleteShop*) obj;

-(id) object;

+(NSString *)reuseIdentifier;
+(float) height;

@end

@interface UITableView(TabSearchTableCell)

-(void) registerTabSearchTableCell;
-(TabSearchTableCell*) tabSearchTableCell;

@end