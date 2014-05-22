//
//  CityViewController.h
//  Infory
//
//  Created by XXX on 5/21/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "TextField.h"

@class CityViewController;

@protocol CityControllerDelegate <SGViewControllerDelegate>

-(void) cityControllerDidTouchedCity:(CityViewController*) controller idCity:(int) idCity name:(NSString*) name;

@end

@interface CityViewController : SGViewController
{
    __weak IBOutlet SearchTextField *txtSearch;
    __weak IBOutlet UITableView *table;
    __weak IBOutlet UILabel *lblCity;
    
    NSArray *_filterCities;
    CGRect _tableFrame;
    int _selectedIDCity;
}

-(CityViewController*) initWithSelectedIDCity:(int) idCity;

@property (nonatomic, weak) id<CityControllerDelegate> delegate;

@end
