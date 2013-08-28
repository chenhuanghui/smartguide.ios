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
@synthesize values,isSuccess,imageData,userGallery;

-(ASIOperationUploadUserGallery *)initWithIDShop:(int)idShop userID:(int)idUser desc:(NSString *)desc photo:(NSData *)image
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_UPLOAD_USER_GALLERY)];
    
    self=[super initWithURL:_url];
    
    NSString *d=[NSString stringWithStringDefault:desc];
    
    values=@[@(idShop),@(idUser),d];
    
    [self addData:image withFileName:@"photo" andContentType:@"image/jpeg" forKey:@"photo"];
    imageData=[image copy];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"shop_id",@"user_id",@"description"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    isSuccess=[[json objectAtIndex:0] boolValue];
    
    if(isSuccess)
    {
        userGallery=[ShopUserGallery insert];
        userGallery.shop=[Shop shopWithIDShop:[[values objectAtIndex:0] integerValue]];
        userGallery.imagePosed=[UIImage imageWithData:imageData];
        userGallery.desc=[values objectAtIndex:2];
        
        [[DataManager shareInstance] save];
    }
}

@end
