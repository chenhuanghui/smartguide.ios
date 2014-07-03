//
//  ScanResultViewController.h
//  Infory
//
//  Created by XXX on 7/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class ScanResultViewController, ScanResult, QRCodeDecode;

@protocol ScanResultControllerDelegate <SGViewControllerDelegate>

-(void) scanResultController:(ScanResultViewController*) controller touchedObject:(ScanResult*) object;
-(void) scanResultControllerTouchedBack:(ScanResultViewController*) controller;

@end

@interface ScanResultViewController : SGViewController
{
    __weak IBOutlet UITableView *table;
    __weak IBOutlet UIButton *btnBack;
    __weak IBOutlet UILabel *lblTitle;
    
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

enum SCAN_RESULT_CODE_TYPE
{
    SCAN_RESULT_CODE_TYPE_ERROR=0,
    SCAN_RESULT_CODE_TYPE_INFORY=1,
    SCAN_RESULT_CODE_TYPE_NON_INFORY=2,
};

@interface ScanQRCodeObject : NSObject

-(enum SCAN_RESULT_CODE_TYPE) enumType;

-(void) addRelatedShops:(NSArray*) shops;
-(void) addRelatedPromotions:(NSArray*) promotions;
-(void) addRelatedPlacelists:(NSArray*) plcelists;

@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSMutableArray *qrCodeDecodes;
@property (nonatomic, strong) NSMutableDictionary *relaties;

@end