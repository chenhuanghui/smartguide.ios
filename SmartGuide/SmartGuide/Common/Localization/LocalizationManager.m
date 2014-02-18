//
//  LocalizationManager.m
//  SmartGuide
//
//  Created by XXX on 7/11/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "LocalizationManager.h"

NSString* localizeOK()
{
    return @"OK";
}

NSString* localizeCancel()
{
    return @"Cancel";
}

NSString* localizeLocationServicesDisabled()
{
    return @"Location services disabled";
}

NSString* localizeLocationAuthorationDenied()
{
    return @"Location authorization denied";
}

NSString* localizeErrorPhoneLength()
{
    return @"Phone length <= 12";
}

NSString* localizeRequireSGP()
{
    return @"Hiện bạn không đủ SGP để nhận khuyến mãi này.";
}

NSString* localizeUpdateProfileFailed()
{
    return @"Cập nhật thông tin thất bại";
}

NSString* localizeConnectToServerFailed()
{
    return @"Kết nối đến máy chủ thất bại";
}

NSString* localizeDanhMucHienKhongCoKhuyenMai()
{
    return @"Danh mục hiện không có khuyến mãi";
}

NSString *localizeGender(int gender)
{
    switch (gender) {
        case 0:
            return @"Nữ";
            
        case 1:
            return @"Nam";
            
        default:
            return @"";
    }
}