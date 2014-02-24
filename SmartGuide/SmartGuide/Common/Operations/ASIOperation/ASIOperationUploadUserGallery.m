//
//  ASIOperationUploadUserGallery.m
//  SmartGuide
//
//  Created by XXX on 8/6/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationUploadUserGallery.h"
#import "ShopUserGallery.h"
#import "Shop.h"

@implementation ASIOperationUploadUserGallery
@synthesize status,message;

-(ASIOperationUploadUserGallery *)initWithIDShop:(int)idShop desc:(NSString *)desc photo:(NSData *)image shareFacebook:(bool)isSharedFacebook userLat:(double)userLat userLng:(double)userLng
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_USER_GALLERY_POST)]];
    
    [self.keyValue setObject:@(idShop) forKey:IDSHOP];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    [self.keyValue setObject:desc forKey:DESCRIPTION];
    [self.keyValue setObject:@(isSharedFacebook) forKey:@"hasShareFB"];
    
    [self addData:image withFileName:@"photo" andContentType:@"image/jpeg" forKey:@"photo"];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([self isNullData:json])
        return;
    
    NSDictionary *dict=[json objectAtIndex:0];
    status=[[NSNumber numberWithObject:dict[@"status"]] integerValue];
    message=[NSString stringWithStringDefault:dict[@"message"]];
    
    if(status==1)
    {
        Shop *shop=[Shop shopWithIDShop:[self.keyValue[IDSHOP] integerValue]];
        ShopUserGallery *userGallery=[ShopUserGallery makeWithJSON:dict[@"userGallery"]];
        userGallery.shop=shop;
        
        int sortOrder=0;
        
        if(shop.userGalleriesObjects.count>0)
            sortOrder=[[shop.userGalleriesObjects valueForKeyPath:[NSString stringWithFormat:@"@min.%@",ShopUserGallery_SortOrder]] integerValue]-1;
        
        userGallery.sortOrder=@(sortOrder);
        
        [[DataManager shareInstance] save];
    }
}

@end
