//
//  ASIOperationUploadFBToken.h
//  SmartGuide
//
//  Created by MacMini on 9/23/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationUploadFBToken : ASIOperationPost

-(ASIOperationUploadFBToken*) initWithIDUser:(int) idUser fbToken:(NSString*) token;

@end
