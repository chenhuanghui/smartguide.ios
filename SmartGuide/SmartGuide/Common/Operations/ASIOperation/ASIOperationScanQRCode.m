//
//  ASIOperationScanQRCode.m
//  SmartGuide
//
//  Created by MacMini on 13/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationScanQRCode.h"
#import "Shop.h"

@implementation ASIOperationScanQRCode
@synthesize status,result;

-(ASIOperationScanQRCode *)initWithCode:(NSString *)code userLat:(double)userLat userLng:(double)userLng
{
    self=[super initPOSTWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_SCAN_CODE)]];
    
    [self.keyValue setObject:code forKey:@"code"];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    status=-1;
    if([json isNullData])
        return;
    
    NSDictionary *dict=json[0];
    status=[[NSNumber numberWithObject:dict[@"status"]] integerValue];
    
    switch (status) {
        case 0:
            
            result=[ScanQRCodeResult0 makeWithDictionary:dict];
            
            break;
            
        case 1:
            
            result=[ScanQRCodeResult1 makeWithDictionary:dict];
            
            break;
            
        case 2:
        {
            result=[ScanQRCodeResult2 makeWithDictionary:dict];
            
            ScanQRCodeResult2 *obj=result;
            
            Shop *shop=[Shop shopWithIDShop:obj.idShop];
            shop.km1.sgp=obj.totalSGP;
        }
            break;
            
        case 3:
        {
            result=[ScanQRCodeResult3 makeWithDictionary:dict];
            ScanQRCodeResult3 *obj=result;
            
            Shop *shop=[Shop shopWithIDShop:obj.idShop];
            shop.km1.sgp=obj.totalSGP;
        }
            break;
            
        case 4:
            
            result=[ScanQRCodeResult4 makeWithDictionary:dict];
            
            break;
            
        default:
            DLOG_DEBUG(@"ASIOperationScanQRCode unknow status %i", status);
            return;
    }
    
    [[DataManager shareInstance] save];
}

@end

@implementation ScanQRCodeResult0
@synthesize message;

+(ScanQRCodeResult0 *)makeWithDictionary:(NSDictionary *)dict
{
    ScanQRCodeResult0 *obj=[ScanQRCodeResult0 new];
    obj.message=[NSString stringWithStringDefault:dict[@"message"]];
    
    return obj;
}

@end

@implementation ScanQRCodeResult1
@synthesize message,idShop,shopName;

+(ScanQRCodeResult1 *)makeWithDictionary:(NSDictionary *)dict
{
    ScanQRCodeResult1 *obj=[ScanQRCodeResult1 new];
    obj.message=[NSString stringWithStringDefault:dict[@"message"]];
    obj.idShop=[[NSNumber numberWithObject:dict[@"idShop"]] integerValue];
    obj.shopName=[NSString stringWithStringDefault:dict[@"shopName"]];
    
    return obj;
}

@end
@implementation ScanQRCodeResult2
@synthesize message,shopName,idShop,sgp,totalSGP;

+(ScanQRCodeResult2 *)makeWithDictionary:(NSDictionary *)dict
{
    ScanQRCodeResult2 *obj=[ScanQRCodeResult2 new];
    obj.message=[NSString stringWithStringDefault:dict[@"message"]];
    obj.shopName=[NSString stringWithStringDefault:dict[@"shopName"]];
    obj.idShop=[[NSNumber numberWithObject:dict[@"idShop"]] integerValue];
    obj.sgp=[NSString stringWithStringDefault:dict[@"sgp"]];
    obj.totalSGP=[NSString stringWithStringDefault:dict[@"totalSGP"]];
    
    return obj;
}

@end

@implementation ScanQRCodeResult3
@synthesize message,totalSGP,sgp,giftName,type,idShop,shopName;

+(ScanQRCodeResult3 *)makeWithDictionary:(NSDictionary *)dict
{
    ScanQRCodeResult3 *obj=[ScanQRCodeResult3 new];
    obj.message=[NSString stringWithStringDefault:dict[@"message"]];
    obj.totalSGP=[NSString stringWithStringDefault:dict[@"totalSGP"]];
    obj.sgp=[NSString stringWithStringDefault:dict[@"sgp"]];
    obj.giftName=[NSString stringWithStringDefault:dict[@"giftName"]];
    obj.type=[NSString stringWithStringDefault:dict[@"type"]];
    obj.idShop=[[NSNumber numberWithObject:dict[@"idShop"]] integerValue];
    obj.shopName=[NSString stringWithStringDefault:dict[@"shopName"]];
    
    return obj;
}

@end

@implementation ScanQRCodeResult4
@synthesize message,type,voucherName,shopName,idShop;

+(ScanQRCodeResult4 *)makeWithDictionary:(NSDictionary *)dict
{
    ScanQRCodeResult4 *obj=[ScanQRCodeResult4 new];
    obj.message=[NSString stringWithStringDefault:dict[@"message"]];
    obj.type=[NSString stringWithStringDefault:dict[@"type"]];
    obj.voucherName=[NSString stringWithStringDefault:dict[@"voucherName"]];
    obj.idShop=[[NSNumber numberWithObject:dict[@"idShop"]] integerValue];
    obj.shopName=[NSString stringWithStringDefault:dict[@"shopName"]];
    
    
    return obj;
}

@end