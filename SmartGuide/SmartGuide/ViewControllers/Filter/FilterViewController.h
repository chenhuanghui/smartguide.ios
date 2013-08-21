//
//  FilterViewController.h
//  SmartGuide
//
//  Created by XXX on 7/26/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ViewController.h"
#import "Label.h"

@interface FilterButton : UIButton

@end

@protocol FilterDelegate <NSObject>

-(void) filterDone;

@end

@interface FilterViewController : ViewController<UIGestureRecognizerDelegate>
{
    __weak IBOutlet Label *lblAllField;
    __weak IBOutlet UIView *food;
    __weak IBOutlet UIView *drink;
    __weak IBOutlet UIView *health;
    __weak IBOutlet UIView *entertaiment;
    __weak IBOutlet UIView *fashion;
    __weak IBOutlet UIView *travel;
    __weak IBOutlet UIView *production;
    __weak IBOutlet UIView *education;
    
    __weak IBOutlet UIButton *btnAward;
    __weak IBOutlet UIButton *btnPoint;
    __weak IBOutlet UIButton *btnLike;
    __weak IBOutlet UIButton *btnView;
    __weak IBOutlet UIButton *btnDistance;
}

+(CGSize) size;
- (IBAction)btnCheckAllTouchUpInside:(id)sender;
- (IBAction)btnCheckNonTouchUpInside:(id)sender;
- (IBAction)btnGetAwardTouchUpInside:(id)sender;
- (IBAction)btnGetPointTouchUpInside:(id)sender;
- (IBAction)btnMostLikeTouchUpInside:(id)sender;
- (IBAction)btnMostViewTouchUpInside:(id)sender;
- (IBAction)btnDistanceTouchUpInside:(id)sender;
- (IBAction)btnDoneTouchUpInside:(id)sender;

-(void) loadFilter;

@property (nonatomic, assign) id<FilterDelegate> delegate;

@end

@interface FilterView : UIView

@end