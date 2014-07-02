//
//  ScanResultViewController.h
//  Infory
//
//  Created by XXX on 7/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class ScanResultViewController, ScanResult;

@protocol ScanResultControllerDelegate <SGViewControllerDelegate>

-(void) scanResultController:(ScanResultViewController*) controller touchedObject:(ScanResult*) object;

@end

@interface ScanResultViewController : SGViewController
{
    NSString *_code;
}

-(ScanResultViewController*) initWithCode:(NSString*) code;

@property (nonatomic, weak) id<ScanResultControllerDelegate> delegate;

@end

enum SCAN_RESULT_TYPE
{
    SCAN_RESULT_TYPE_UNKNOW=0,
    SCAN_RESULT_TYPE_SHOP=1,
    SCAN_RESULT_TYPE_PROMOTION=2,
    SCAN_RESULT_TYPE_PLACELIST=3,
};

@interface ScanResult : NSObject

-(enum SCAN_RESULT_TYPE) enumType;

@property (nonatomic, strong) NSNumber* type;
@property (nonatomic, strong) NSNumber* idShop;
@property (nonatomic, strong) NSNumber* idPlacelist;

@end