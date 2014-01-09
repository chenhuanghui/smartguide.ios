//
//  AvatarViewController.h
//  SmartGuide
//
//  Created by MacMini on 04/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "ASIOperationGetAvatars.h"
#import "TouchView.h"
#import "GMGridView.h"

@class AvatarViewController;

@protocol AvatarControllerDelegate <SGViewControllerDelegate>

-(void) avatarControllerTouched:(AvatarViewController*) controller avatar:(NSString*) avatar avatarImage:(UIImage*) avatarImage;

@end

@interface AvatarViewController : SGViewController<GMGridViewDataSource,ASIOperationPostDelegate,GMGridViewActionDelegate>
{
    __weak IBOutlet UIButton *btnUpPhoto;
    __weak IBOutlet UIButton *btnConfirm;
    __weak IBOutlet GMGridView *grid;
    __weak IBOutlet TouchView *touchView;
    
    ASIOperationGetAvatars *_operationGetAvatars;
    NSMutableArray *_avatars;
    
    NSString *_avatar;
    UIImage *_avatarImage;
    
    __weak UIImagePickerController *imagePicker;
    
    int _selectedIndex;
}

-(AvatarViewController*) initWithAvatars:(NSMutableArray*) avatars avatarImage:(UIImage*) avatarImage;
-(NSMutableArray*) avatars;

-(void) setSelectedAvatar:(NSString*) selectedAvatar;

@property (nonatomic, weak) id<AvatarControllerDelegate> delegate;

@end