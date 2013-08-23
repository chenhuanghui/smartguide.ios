//
//  CatalogueBlockViewController.h
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ViewController.h"
#import "ASIOperationCity.h"
#import "ASIOperationGroupInCity.h"
#import "LoadingScreenViewController.h"

@interface CatalogueBlockViewController : ViewController<ASIOperationPostDelegate>
{
    bool _isFinishedLoading;
    
    __weak IBOutlet UIView *groupAll;
    __weak IBOutlet UIView *groupFood;
    __weak IBOutlet UIView *groupDrink;
    __weak IBOutlet UIView *groupHealth;
    __weak IBOutlet UIView *groupEntertaiment;
    __weak IBOutlet UIView *groupFashion;
    __weak IBOutlet UIView *groupTravel;
    __weak IBOutlet UIView *groupProduction;
    __weak IBOutlet UIView *groupEducation;
    ASIOperationCity *operationCity;
}

-(bool) isFinishedLoading;

@property (nonatomic, assign) id<CatalogueBlockViewDelegate> delegate;

@end

@interface BlockView : UIView

@end