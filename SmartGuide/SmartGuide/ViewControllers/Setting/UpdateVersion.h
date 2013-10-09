//
//  UpdateVersion.h
//  SmartGuide
//
//  Created by XXX on 9/5/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UpdateVersion;

@protocol UpdateVersionDelegate <NSObject>

-(void) updateVersionClose:(UpdateVersion*) uv;

@end

@interface UpdateVersion : UIView
{
    __weak IBOutlet UIButton *btnDG;
}

@property (nonatomic, assign) id<UpdateVersionDelegate> delegate;

@end