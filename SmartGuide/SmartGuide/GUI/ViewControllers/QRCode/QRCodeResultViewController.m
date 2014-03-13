//
//  SGQRCodeResultViewController.m
//  SmartGuide
//
//  Created by MacMini on 04/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "QRCodeResultViewController.h"

@interface QRCodeResultViewController ()

@end

@implementation QRCodeResultViewController

- (QRCodeResultViewController *)initWithResult:(id)result
{
    self = [super initWithNibName:@"QRCodeResultViewController" bundle:nil];
    if (self) {
        // Custom initialization
        _result=result;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    FTCoreTextStyle *style=[FTCoreTextStyle styleWithName:@"plus"];
    style.font=[UIFont fontWithName:@"Avenir-Heavy" size:17];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor darkGrayColor];
    
    [lbl3SGP addStyle:style];
    [lbl2SGP addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"sgp"];
    style.font=[UIFont fontWithName:@"Avenir-Heavy" size:35];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor darkGrayColor];
    
    [lbl3SGP addStyle:style];
    [lbl2SGP addStyle:style];
    
    if([_result isKindOfClass:[ScanQRCodeResult0 class]])
    {
        ScanQRCodeResult0 *obj=_result;
        
        lbl0Message.text=obj.message;
        
        result0View.hidden=false;
    }
    else if([_result isKindOfClass:[ScanQRCodeResult1 class]])
    {
        ScanQRCodeResult1 *obj=_result;
        
        lbl1Message.text=obj.message;
        lbl1ShopName.text=obj.shopName;
        
        result1View.hidden=false;
    }
    else if([_result isKindOfClass:[ScanQRCodeResult2 class]])
    {
        ScanQRCodeResult2 *obj=_result;
        
        lbl2Message.text=obj.message;
        lbl2ShopName.text=obj.shopName;
        
        NSString *sgp=[obj.sgp stringByReplacingOccurrencesOfString:@"+" withString:@"⁺"];
        sgp=[sgp stringByReplacingOccurrencesOfString:@"-" withString:@"⁻"];
        
        lbl2SGP.text=[sgp stringByAppendingTagName:@"sgp"];
        
        result2View.hidden=false;
    }
    else if([_result isKindOfClass:[ScanQRCodeResult3 class]])
    {
        ScanQRCodeResult3 *obj=_result;
        
        lbl3Gift.text=obj.giftName;
        lbl3Message.text=obj.message;
        NSString *sgp=[obj.sgp stringByReplacingOccurrencesOfString:@"+" withString:@"⁺"];
        sgp=[sgp stringByReplacingOccurrencesOfString:@"-" withString:@"⁻"];
        
        lbl3SGP.text=[sgp stringByAppendingTagName:@"sgp"];
        lbl3ShopName.text=obj.shopName;
        lbl3Type.text=obj.type;
        
        result3View.hidden=false;
    }
    else if([_result isKindOfClass:[ScanQRCodeResult4 class]])
    {
        ScanQRCodeResult4 *obj=_result;
        
        lbl4Message.text=obj.message;
        lbl4Type.text=obj.type;
        lbl4VoucherName.text=obj.voucherName;
        lbl4ShopName.text=obj.shopName;
        
        result4View.hidden=false;
    }
    else if([_result isKindOfClass:[ScanQRCodeDisconnect class]])
    {
        disconnectView.hidden=false;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn0TouchUpInside:(id)sender {
}

-(void)dealloc
{
    _result=nil;
}

-(id)result
{
    return _result;
}

@end

@implementation ScanQRCodeDisconnect

@end