//
//  SGQRCodeResultViewController.h
//  SmartGuide
//
//  Created by MacMini on 04/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "ASIOperationScanQRCode.h"
#import "FTCoreTextView.h"

@interface QRCodeResultViewController : SGViewController
{
    __strong id _result;
    __weak IBOutlet UIView *result1View;
    __weak IBOutlet UIView *result2View;
    __weak IBOutlet UIView *result3View;
    __weak IBOutlet UIView *result4View;
    __weak IBOutlet UIView *result0View;
    __weak IBOutlet UIView *disconnectView;
    __weak IBOutlet UILabel *lbl0Message;
    __weak IBOutlet UITextView *lbl1Message;
    __weak IBOutlet UILabel *lbl1ShopName;
    __weak IBOutlet UITextView *lbl2Message;
    __weak IBOutlet FTCoreTextView *lbl2SGP;
    __weak IBOutlet UILabel *lbl2ShopName;
    __weak IBOutlet UITextView *lbl3Message;
    __weak IBOutlet UILabel *lbl3Type;
    __weak IBOutlet UITextView *lbl3Gift;
    __weak IBOutlet FTCoreTextView *lbl3SGP;
    __weak IBOutlet UILabel *lbl3ShopName;
    __weak IBOutlet UITextView *lbl4Message;
    __weak IBOutlet UILabel *lbl4Type;
    __weak IBOutlet UITextView *lbl4VoucherName;
    __weak IBOutlet UILabel *lbl4ShopName;
}

-(QRCodeResultViewController*) initWithResult:(id) result;

-(id) result;

@end

@interface ScanQRCodeDisconnect : NSObject

@end