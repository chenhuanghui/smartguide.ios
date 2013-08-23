//
//  FacebookMiningViewController.h
//  SmartGuide
//
//  Created by XXX on 7/24/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ViewController.h"
#import "OperationFBGetProfile.h"
#import "ASIOperationFBProfile.h"
#import "FacebookManager.h"

@interface FacebookMiningViewController : ViewController<OperationURLDelegate,ASIOperationPostDelegate>
{
    __weak IBOutlet UIButton *btnSkip;
    __weak IBOutlet UIButton *btnFace;
    __weak IBOutlet UIImageView *imgvAvatar;
    
    ASIOperationFBProfile *postProfile;
    OperationFBGetProfile *getProfile;
}

@end
