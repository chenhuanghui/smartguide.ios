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
@synthesize status,message,values;

-(ASIOperationUploadUserGallery *)initWithIDShop:(int)idShop desc:(NSString *)desc photo:(NSData *)image shareFacebook:(bool)isSharedFacebook userLat:(double)userLat userLng:(double)userLng
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_USER_GALLERY_POST)]];
    
    values=@[@(idShop),@(userLat),@(userLng),desc,@(isSharedFacebook)];
    
    [self addData:image withFileName:@"photo" andContentType:@"image/jpeg" forKey:@"photo"];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"idShop",@"userLat",@"userLng",@"description",@"hasShareFB"];
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
        Shop *shop=[Shop shopWithIDShop:[values[0] integerValue]];
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
