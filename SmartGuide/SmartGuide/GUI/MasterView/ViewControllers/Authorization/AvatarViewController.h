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

@class AvatarViewController;

@protocol AvatarControllerDelegate <SGViewControllerDelegate>

-(void) avatarControllerTouched:(AvatarViewController*) controller avatar:(NSString*) avatar;

@end

@interface AvatarViewController : SGViewController<UITableViewDataSource,UITableViewDelegate,ASIOperationPostDelegate>
{
    __weak IBOutlet UITableView *table;
    __weak IBOutlet UIButton *btnUpPhoto;
    __weak IBOutlet UIButton *btnConfirm;
    __weak IBOutlet TouchView *touchView;
    
    ASIOperationGetAvatars *_operationGetAvatars;
    NSMutableArray *_avatars;
}

@property (nonatomic, weak) id<AvatarControllerDelegate> delegate;

@end