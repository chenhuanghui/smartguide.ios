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
@synthesize isSuccess,imageData,userGallery;

-(ASIOperationUploadUserGallery *)initWithIDShop:(int)idShop userID:(int)idUser desc:(NSString *)desc photo:(NSData *)image shareFacebook:(bool)isSharedFacebook
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_UPLOAD_USER_GALLERY)];
    
    self=[super initWithURL:_url];
    
    NSString *d=[NSString stringWithStringDefault:desc];
    
    self.values=@[@(idShop),@(idUser),d,@(isSharedFacebook)];
    
    [self addData:image withFileName:@"photo" andContentType:@"image/jpeg" forKey:@"photo"];
    imageData=[image copy];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"shop_id",@"user_id",@"description",@"share"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([self isNullData:json])
        return;
    
    NSDictionary *dict=[json objectAtIndex:0];
    isSuccess=[[NSNumber numberWithObject:[dict objectForKey:@"status"]] boolValue];
    
    if(isSuccess)
    {
        userGallery=[ShopUserGallery insert];
        userGallery.shop=[Shop shopWithIDShop:[[self.values objectAtIndex:0] integerValue]];
        userGallery.imagePosed=[UIImage imageWithData:imageData];
        userGallery.desc=[self.values objectAtIndex:2];
        
        [[DataManager shareInstance] save];
    }
}

@end
