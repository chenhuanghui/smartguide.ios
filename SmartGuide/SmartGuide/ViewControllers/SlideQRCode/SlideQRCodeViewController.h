//
//  SlideQRCodeViewController.h
//  SmartGuide
//
//  Created by XXX on 7/26/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ViewController.h"
#import "QRCodeViewController.h"
#import "TouchView.h"
#import "ASIOperationPost.h"
#import "Shop.h"
#import "ASIOperationCity.h"

enum SCAND_TYPE {
    SCAN_GET_SGP= 0,
    SCAN_GET_PROMOTION2 = 1,
    SCAN_GET_AWARD_PROMOTION_1 = 2
    };

@class QRCode;

@protocol SlideQRCodeDelegate <NSObject>

@optional
-(void)slideQRCodeUserScaned:(NSArray*) codes;

@end

@interface SlideQRCodeViewController : ViewController<QRCodeDelegate,TouchViewDelegate,ASIOperationPostDelegate>
{
    __weak IBOutlet UIButton *btnSlide;
    __weak IBOutlet UILabel *lblSlide;
    __weak IBOutlet UIView *qrView;
    __weak IBOutlet UIView *ray;
    __weak IBOutlet UIView *darkLayer;
    __weak IBOutlet UIView *rewardView;
    __weak IBOutlet UILabel *lblSGP;
    __weak IBOutlet UIImageView *imgvRewardIcon;
    __weak IBOutlet UILabel *lblError;
    __weak IBOutlet UILabel *lblChucMung;
    __weak IBOutlet UILabel *lblNhanDuoc;
    __weak IBOutlet UILabel *lblShop;
    __weak IBOutlet UIImageView *imgvScan;
    __weak IBOutlet UIButton *btnClose;
    
    bool _isUserScanded;
    bool _isLoadingShopDetail;
    bool _isUserClickClose;
    bool _isSuccessed;
}

-(UIButton*) btnSlide;

+(CGSize) size;
-(void) showCamera;
-(void) hideCamera;
-(void) scanGetPromotion2WithIDAward:(int) idAward;
-(void) scanGetAwardPromotion1WithIDAward:(int) idAward;

-(bool) isUserScanded;

@property (nonatomic, strong) NSMutableArray *qrCodes;
@property (nonatomic, strong) QRCode *qrCode;
@property (nonatomic, assign) id<SlideQRCodeDelegate> delegate;
@property (nonatomic, assign) enum SCAND_TYPE mode;
@property (nonatomic, assign) int idReward;

@end

@interface SlideQRView : UIView

@end

@interface QRCode : NSObject

+(QRCode*) qrCodeWithCode:(NSString*) code;

@property (nonatomic, assign) int type;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, assign) int idShop;
@property (nonatomic, assign) double totalSGP;
@property (nonatomic, strong) NSString *sourceCode;

@end