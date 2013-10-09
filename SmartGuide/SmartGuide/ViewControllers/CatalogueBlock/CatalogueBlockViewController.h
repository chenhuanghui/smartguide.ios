//
//  CatalogueBlockViewController.h
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ViewController.h"
#import "ASIOperationGroupInCity.h"
#import "LoadingScreenViewController.h"
#import "TutorialView.h"

@interface CatalogueBlockViewController : ViewController<ASIOperationPostDelegate,TutorialViewDelegate>
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
    
    City *_city;
    bool _isNeedLoad;
    
    UIView *_launchingView;
    
    ASIOperationGroupInCity *_operationGroupInCity;
}

-(bool) isFinishedLoading;

-(void) loadWithCity:(City*) city;

-(void) setIsNeedLoad;
-(void) catalogueShowed;

@property (nonatomic, assign) id<CatalogueBlockViewDelegate> delegate;

@end

@interface BlockView : UIView

@end