//
//  AvatarListView.m
//  SmartGuide
//
//  Created by MacMini on 9/23/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "AvatarListView.h"
#import "LoadingView.h"

@interface AvatarListStrategy : GMGridViewLayoutVerticalStrategy

@end

@implementation AvatarListStrategy

-(void)setEdgeAndContentSizeFromAbsoluteContentSize:(CGSize)actualContentSize
{
    [super setEdgeAndContentSizeFromAbsoluteContentSize:actualContentSize];
    
    _contentSize=CGSizeMake(_contentSize.width, _contentSize.height+200);
}

@end

@implementation AvatarListView
@synthesize avatarDelegate,selectedAvatar;

-(AvatarListView *)initWithIDUser:(int)idUser frame:(CGRect)frame
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"AvatarListView" owner:nil options:nil] objectAtIndex:0];
    
    self.backgroundColor=COLOR_BACKGROUND_APP_ALPHA(0.8);
    
    self.frame=frame;
    
    _idUser=idUser;
    
    blurTop.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(180));
    
    AvatarListStrategy *strategy=[[AvatarListStrategy alloc] init];
    
    grid.layoutStrategy=strategy;
    
    grid.centerGrid=true;
    grid.itemSpacing=5;
    grid.minEdgeInsets=UIEdgeInsetsMake((self.frame.size.height-100)/2, 110, 0, 110);
    
    _images=[[NSMutableArray alloc] init];

    grid.actionDelegate=self;
    grid.dataSource=self;
    
    _opeartion=[[ASIOperationGetAvatars alloc] initGetAvatars];
    _opeartion.delegatePost=self;
    
    [_opeartion startAsynchronous];
    
    return self;
}

-(NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return _images.count;
}

-(GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    GMGridViewCell *cell=[gridView dequeueReusableCell];
    
    if(!cell)
    {
        cell=[[GMGridViewCell alloc] init];
        
        UIImageView *imgv=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [self iconSize].width, [self iconSize].height)];
        cell.contentView=imgv;
    }
    
    UIImageView *imgv=(UIImageView*)cell.contentView;
    
    [imgv setImageWithLoading:[NSURL URLWithString:[_images objectAtIndex:index]] emptyImage:UIIMAGE_LOADING_AVATAR success:nil failure:nil];
    
    return cell;
}

-(CGSize) iconSize
{
    return CGSizeMake(100, 100);
}

-(CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return [self iconSize];
}

-(float)contentHeight
{
    return [self iconSize].height*2+grid.itemSpacing+grid.minEdgeInsets.top+grid.minEdgeInsets.bottom;
}

-(void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    GMGridViewCell *cell=[gridView cellForItemAtIndex:position];
    UIImageView *imgv=(UIImageView*)cell.contentView;
 
    self.selectedAvatar=nil;
    self.selectedAvatar=[[AvatarListItem alloc] init];
    self.selectedAvatar.url=[_images objectAtIndex:position];
    self.selectedAvatar.image=imgv.image;
    
    if(avatarDelegate)
        [avatarDelegate avatarListSelectedItem:self item:[_images objectAtIndex:position] image:imgv.image];
}

-(void)GMGridViewDidTapOnEmptySpace:(GMGridView *)gridView
{
    self.selectedAvatar=nil;
    if(avatarDelegate)
        [avatarDelegate avatarListSelectedEmptySpacing:self];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    ASIOperationGetAvatars *ope=(ASIOperationGetAvatars*) operation;
    
    [self removeLoading];
    
    NSString *userAvatar=[NSString stringWithStringDefault:[User userWithIDUser:_idUser].avatar];
    
    _images=[[NSMutableArray alloc] initWithArray:ope.avatars];

    [_images removeObject:userAvatar];
    
    if(_images.count>0)
        [_images insertObject:userAvatar atIndex:0];
    else
        [_images addObject:userAvatar];

    [grid reloadData];
    
    _opeartion=nil;
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    [self removeLoading];
    
    _opeartion=nil;
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if(newSuperview)
    {
        if(_opeartion)
            [self showLoading];
    }
}

@end

@implementation AvatarListItem
@synthesize url,image;

@end