//
//  AvatarViewController.m
//  SmartGuide
//
//  Created by MacMini on 04/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "AvatarViewController.h"
#import "AvatarCell.h"

@interface AvatarViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation AvatarViewController
@synthesize delegate;

-(AvatarViewController *)initWithAvatars:(NSMutableArray *)avatars avatarImage:(UIImage *)avatarImage
{
    self = [super initWithNibName:@"AvatarViewController" bundle:nil];
    if (self) {
        // Custom initialization
        _avatars=[avatars copy];
        _avatarImage=avatarImage;
        _selectedIndex=NSNotFound;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if(_avatars.count==0)
    {
        _avatars=[NSMutableArray new];
        
        _operationGetAvatars=[[ASIOperationGetAvatars alloc] initGetAvatars];
        _operationGetAvatars.delegatePost=self;
        
        [_operationGetAvatars startAsynchronous];
        
        [touchView showLoading];
    }
    
    grid.style=GMGridViewStylePush;
    grid.centerGrid=false;
    grid.layoutStrategy=[GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutHorizontal];
    grid.minEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 0);
    grid.pagingEnabled=true;
    grid.itemSpacing=0;
    
    grid.dataSource=self;
    grid.actionDelegate=self;
    
    if(_selectedIndex!=NSNotFound)
    {
        [grid scrollToObjectAtIndex:_selectedIndex atScrollPosition:GMGridViewScrollPositionTop animated:false];
    }
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationGetAvatars class]])
    {
        [touchView removeLoading];
        
        ASIOperationGetAvatars *ope=(ASIOperationGetAvatars*) operation;
        
        _avatars=[ope.avatars copy];
        
        grid.dataSource=self;
        
        _operationGetAvatars=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationGetAvatars class]])
    {
        [touchView removeLoading];
        
        _operationGetAvatars=nil;
    }
}

-(void)dealloc
{
    if(_operationGetAvatars)
    {
        [_operationGetAvatars clearDelegatesAndCancel];
        _operationGetAvatars=nil;
    }
    
    [touchView removeLoading];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnUpPhotoTouchUpInside:(id)sender {
    UIImagePickerController *imgPicker=[[UIImagePickerController alloc] init];
    imgPicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    imgPicker.delegate=self;
    imgPicker.editing=false;
    
    imagePicker=imgPicker;
    
    [self.navigationController presentModalViewController:imgPicker animated:true];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _avatarImage=[info[UIImagePickerControllerOriginalImage] convertToServer];
    
    [grid reloadData];
    [grid scrollToObjectAtIndex:0 atScrollPosition:GMGridViewScrollPositionTop animated:false];
    
    [self.navigationController dismissModalViewControllerAnimated:true];
}

- (IBAction)btnConfirmTouchUpInside:(id)sender {
    
    CGPoint pnt=CGPointMake(self.l_v_w/2+grid.l_co_x, grid.l_v_h/2);
    int index=[grid.layoutStrategy itemPositionFromLocation:pnt];
    
    if(_avatarImage)
    {
        if(index==0)
        {
            [self.delegate avatarControllerTouched:self avatar:@"" avatarImage:_avatarImage];
        }
        else
        {
            [self.delegate avatarControllerTouched:self avatar:_avatars[index-1] avatarImage:nil];
        }
    }
    else
        [self.delegate avatarControllerTouched:self avatar:_avatars[index] avatarImage:nil];
    
    _avatarImage=nil;
}

-(NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return _avatars.count + (_avatarImage?1:0);
}

-(GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    GMGridViewCell *cell=[gridView dequeueReusableCell];
    
    if(!cell)
    {
        cell=[[GMGridViewCell alloc] initWithFrame:CGRectZero];
        cell.contentView=[AvatarCell new];
    }
    
    AvatarCell *aCell=(AvatarCell*)cell.contentView;
    
    if(_avatarImage)
    {
        if(index==0)
            [aCell loadWithImage:_avatarImage];
        else
            [aCell loadWithURL:_avatars[index-1]];
    }
    else
        [aCell loadWithURL:_avatars[index]];
    
    return cell;
}

-(CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    CGSize size=[AvatarCell size];
    size.width+=grid.l_v_w-[AvatarCell size].width;
    
    return size;
}

-(NSMutableArray *)avatars
{
    return _avatars;
}

-(UIImage *)avatarImage
{
    return _avatarImage;
}

-(void)setSelectedAvatar:(NSString *)selectedAvatar
{
    int index=[_avatars indexOfObject:selectedAvatar];
    
    if(index!=NSNotFound)
        index+=(_avatarImage?1:0);
    
    _selectedIndex=index;
}

-(void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    int centerIndex=[self centerItem];
    if(position!=centerIndex)
    {
        [gridView scrollToObjectAtIndex:position atScrollPosition:GMGridViewScrollPositionTop animated:true];
    }
    else
    {
        CGPoint pnt=CGPointMake(self.l_v_w/2+grid.l_co_x, grid.l_v_h/2);
        int index=[grid.layoutStrategy itemPositionFromLocation:pnt];
        
        if(_avatarImage)
        {
            if(index==0)
            {
                [self.delegate avatarControllerTouched:self avatar:@"" avatarImage:_avatarImage];
            }
            else
            {
                [self.delegate avatarControllerTouched:self avatar:_avatars[index-1] avatarImage:nil];
            }
        }
        else
            [self.delegate avatarControllerTouched:self avatar:_avatars[index] avatarImage:nil];
        
        _avatarImage=nil;
    }
}

-(int) centerItem
{
    CGPoint pnt=CGPointMake(self.l_v_w/2+grid.l_co_x, grid.l_v_h/2);
    int index=[grid.layoutStrategy itemPositionFromLocation:pnt];
    
    return index;
}

-(NSString *)title
{
    return @"Avatar";
}

@end