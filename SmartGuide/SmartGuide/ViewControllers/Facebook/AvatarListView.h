//
//  AvatarListView.h
//  SmartGuide
//
//  Created by MacMini on 9/23/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMGridView.h"
#import "ASIOperationGetAvatars.h"

@class AvatarListView,AvatarListItem;

@protocol AvatarListViewDelegate <NSObject>

-(void) avatarListSelectedItem:(AvatarListView*) avatarListView item:(NSString*) url image:(UIImage*) image;
-(void) avatarListSelectedEmptySpacing:(AvatarListView*) avatarListView;

@end

@interface AvatarListView : UIView<GMGridViewDataSource,GMGridViewActionDelegate,ASIOperationPostDelegate>
{
    __weak IBOutlet GMGridView *grid;
    __weak IBOutlet UIImageView *blurTop;
    __weak IBOutlet UIImageView *blurBottom;
    int _idUser;
    NSMutableArray *_images;
    
    ASIOperationGetAvatars *_opeartion;
}

-(AvatarListView*) initWithIDUser:(int) idUser frame:(CGRect) frame;

-(float) contentHeight;

@property (nonatomic, assign) id<AvatarListViewDelegate> avatarDelegate;
@property (nonatomic, strong) AvatarListItem *selectedAvatar;

@end

@interface AvatarListItem : NSObject

@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) UIImage *image;

@end