//
//  TabSearchPlacelistTableCell.h
//  Infory
//
//  Created by XXX on 8/27/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Label, SearchPlacelist;

@interface TabSearchPlacelistTableCell : UITableViewCell
{
    __weak IBOutlet UIImageView *imgvImage;
    __weak IBOutlet UIImageView *imgvLine;
    __weak IBOutlet Label *lblTitle;
    __weak IBOutlet Label *lblContent;
    
    __weak SearchPlacelist *_obj;
}

-(void) loadWithPlacelist:(SearchPlacelist*) obj;
-(float) calculatorHeight:(SearchPlacelist*) obj;

+(NSString *)reuseIdentifier;

@property (nonatomic, assign) bool isPrototypeCell;

@end

@interface UITableView(TabSearchPlacelistTableCell)

-(void) registerTabSearchPlacelistTableCell;
-(TabSearchPlacelistTableCell*) tabSearchPlacelistTableCell;
-(TabSearchPlacelistTableCell*) tabSearchPlacelistTablePrototypeCell;

@end