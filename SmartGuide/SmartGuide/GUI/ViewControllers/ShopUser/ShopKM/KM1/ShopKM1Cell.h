//
//  ShopKM1Cel.h
//  SmartGuide
//
//  Created by MacMini on 21/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShopKM1ContentView, KM1Voucher;

@interface ShopKM1Cell : UITableViewCell
{
    __weak IBOutlet ShopKM1ContentView *containView;
    __weak IBOutlet UILabel *lblVoucher;
    __weak IBOutlet UILabel *lblContent;
    __weak IBOutlet UIImageView *imgvFlag;
    __weak IBOutlet UILabel *lblSGP;
}

-(void) setVoucher:(NSString*) voucher content:(NSString*) content sgp:(NSString*) sgp isHighlighted:(bool) isHighlighted;

+(NSString *)reuseIdentifier;
+(float) heightWithVoucher:(KM1Voucher*) voucher;

@end

@interface ShopKM1ContentView : UIView
{
}

@end

@interface UITableView(ShopKM1Cell)

-(void) registerShopKM1Cell;
-(ShopKM1Cell*) shopKM1Cell;

@end