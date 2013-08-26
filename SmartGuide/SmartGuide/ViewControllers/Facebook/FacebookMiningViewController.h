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
#import "ImageEditor.h"

@interface FacebookMiningViewController : ViewController<OperationURLDelegate,ASIOperationPostDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIActionSheetDelegate,ImageEditorDelegate>
{
    __weak IBOutlet UIButton *btnSkip;
    __weak IBOutlet UIButton *btnFace;
    __weak IBOutlet UIImageView *imgvAvatar;
    __weak IBOutlet UIView *infoView;
    __weak IBOutlet UIView *faceView;
    __weak IBOutlet UITextField *txtAccount;
    __weak IBOutlet UIButton *btnAvatar;
    
    ASIOperationFBProfile *postProfile;
    OperationFBGetProfile *getProfile;
}

@end
