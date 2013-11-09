//
//  SGAdsViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIOperationGetAds.h"
#import "SGViewController.h"

@interface SGAdsViewController : SGViewController<ASIOperationPostDelegate>
{
    __weak IBOutlet UIButton *btnLeft;
    __weak IBOutlet UIButton *btnRight;
    __weak IBOutlet UITableView *tableAds;
    
    ASIOperationGetAds *_operationAds;
}

-(void) loadAds;

@end
