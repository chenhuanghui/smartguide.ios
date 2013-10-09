//
//  PointBar.h
//  SmartGuide
//
//  Created by XXX on 7/16/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTCoreTextView.h"
#import "PromotionRequire.h"

@interface PointBar : UIView
{
    __weak IBOutlet UILabel *lblReward;
    __weak IBOutlet FTCoreTextView *lblPoint;
    __weak PromotionRequire *_shopPoint;
    __weak IBOutlet UIView *bgPoint;
}

-(PointBar*) initWithPoint:(PromotionRequire*) point;
-(void) setPoint:(PromotionRequire*) point;
-(void) setHighlight:(bool) isHighlighed;

+(CGSize) size;

@end