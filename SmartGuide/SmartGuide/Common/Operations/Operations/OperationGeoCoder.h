//
//  OperationGeoCoder.h
//  SmartGuide
//
//  Created by MacMini on 24/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationURL.h"

enum GEOCODER_LANGUAGE {
    GEOCODER_LANGUAGE_VN = 0,
    };

@interface OperationGeoCoder : OperationURL

-(OperationGeoCoder*) initWithLat:(double) lat lng:(double) lng language:(enum GEOCODER_LANGUAGE) language;

@property (nonatomic, readonly) NSMutableArray *address;

@end
