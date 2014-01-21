//
//  ASIOperationSocialShare.h
//  SmartGuide
//
//  Created by MacMini on 21/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationSocialShare : ASIOperationPost

-(ASIOperationSocialShare*) initWithContent:(NSString*) content url:(NSString*) url image:(UIImage*) image accessToken:(NSString*) accessToken socialType:(enum SOCIAL_TYPE) socialType;

@property (nonatomic, readonly) int status;
@property (nonatomic, readonly) NSString *message;

@end
