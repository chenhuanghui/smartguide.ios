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

NSString* localizeNameEmpty()
{
    return @"Vui lòng nhập tên";
}

NSString* localizeDOBEmpty()
{
    return @"Vui lòng chọn ngày sinh";
}

NSString* localizeGenderEmpty()
{
    return @"Vui lòng chọn giới tính";
}

NSString* localizeAvatarEmpty()
{
    return @"Vui lòng chọn avatar";
}

NSString* localizeLoginRequire()
{
    return @"Bạn phải đăng nhập để sử dụng chức năng này";
}

NSString* localizeUserProfileRequire()
{
    return @"Bạn phải cập nhật profile để sử dụng chức năng này";
}

NSString* localizeSortComment(enum SORT_SHOP_COMMENT sort)
{
    switch (sort) {
        case SORT_SHOP_COMMENT_TIME:
            return @"Mới nhất";
            
        case SORT_SHOP_COMMENT_TOP_AGREED:
            return @"Thích nhiều nhất";
    }
}

NSString* localizeSortList(enum SORT_LIST sort)
{
    switch (sort) {
        case SORT_LIST_DEFAULT:
            return @"Mặc định";
            
        case SORT_LIST_DISTANCE:
            return @"Khoảng cách";
        case SORT_LIST_LOVE:
            return @"Lượt thích";
        case SORT_LIST_VIEW:
            return @"Lượt xem";
    }
}

NSString* localizeInvailActivationCode()
{
    return @"Mã xác thực không hợp lệ";
}