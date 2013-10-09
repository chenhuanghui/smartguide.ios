//
//  CreateUserView.h
//  SmartGuide
//
//  Created by MacMini on 9/23/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AvatarListView.h"
#import "ASIOperationUpdateUserInfo.h"

@interface CreateUserView : UIView<AvatarListViewDelegate,ASIOperationPostDelegate>
{
    __weak IBOutlet UITextField *txtUser;
    __weak IBOutlet UIButton *btnAvatar;
    __weak IBOutlet UIImageView *imgvAvatar;
    __weak IBOutlet UIButton *btnDone;
    __weak IBOutlet UIImageView *imgvCreateAcc;
    
    AvatarListView *grid;
    float keyboardHeight;
    bool _isLoadingAvatar;
    bool _isDoneTouched;
    NSString *_selectedURL;
}

-(void) focusEdit;

- (IBAction)btnDoneTouchUpInside:(id)sender;
- (IBAction)btnAvatarTouchUpInside:(id)sender;

@end