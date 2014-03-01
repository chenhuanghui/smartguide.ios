//
//  ASIOperationPostPicture.h
//  SmartGuide
//
//  Created by MacMini on 01/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationPostPicture : ASIOperationPost

-(ASIOperationPostPicture*) initWithIDUserGallery:(int) idUserGallery userLat:(double) userLat userLng:(double) userLng description:(NSString*) desc;

@property (nonatomic, readonly) int status;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *desc;

@end
