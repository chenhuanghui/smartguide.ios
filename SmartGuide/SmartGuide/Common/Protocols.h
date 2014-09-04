//
//  Protocols.h
//  Infory
//
//  Created by XXX on 9/4/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

@protocol MapObject<NSObject, MKAnnotation>

-(NSString*) mapTitle;
-(NSString*) mapContent;
-(NSString*) mapLogo;
-(NSString*) mapName;
-(NSString*) mapDesc;

@optional
-(NSString*) mapPinLogo;

@end