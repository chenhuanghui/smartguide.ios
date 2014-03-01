//
//  UserUploadGalleryManager.m
//  SmartGuide
//
//  Created by MacMini on 01/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "UserUploadGalleryManager.h"
#import "DataManager.h"
#import "ASIOperationUploadUserGallery.h"
#import "ASIOperationPostPicture.h"

@interface UserUploadGalleryManager()<ASIOperationPostDelegate>

@end

static UserUploadGalleryManager *_userUploadGalleryManager=nil;
@implementation UserUploadGalleryManager

+(UserUploadGalleryManager *)shareInstance
{
    if(!_userUploadGalleryManager)
    {
        _userUploadGalleryManager=[[UserUploadGalleryManager alloc] init];
    }
    
    return _userUploadGalleryManager;
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)startUploads
{
    [UserGalleryUpload clearUserGalleryUpLoad];
    [self startUpload];
}

-(UserGalleryUpload*)addUploadWithIDShop:(int)idShop image:(UIImage *)image
{
    UserGalleryUpload *obj=[UserGalleryUpload makeWithIDShop:idShop image:image];
    obj.userLat=@(userLat());
    obj.userLng=@(userLng());
    obj.status=@(USER_GALLERY_UPLOAD_STATUS_LISTED);
    
    [[DataManager shareInstance] save];
    
    [self startUpload];
    
    return obj;
}

-(void)updateDesc:(UserGalleryUpload *)upload desc:(NSString *)desc
{
    upload.desc=desc;
    [[DataManager shareInstance] save];
    
    [self startUpload];
}

-(void) cancelUpload:(UserGalleryUpload *)upload
{
    if(upload.objConnection)
    {
        ASIOperationPost *ope=upload.objConnection;
     
        if(_currentUpload==upload)
            _currentUpload=nil;
        
        [upload markDeleted];
        [[DataManager shareInstance] save];
        
        if(ope)
        {
            [ope clearDelegatesAndCancel];
            upload.objConnection=nil;
        }
    }
    else if(_currentUpload==upload)
    {
        [_currentUpload markDeleted];
        [[DataManager shareInstance] save];
        _currentUpload=nil;
    }
    else
    {
        [upload markDeleted];
        [[DataManager shareInstance] save];
    }
}



-(void) startUpload
{
    if(!_currentUpload)
        _currentUpload=[self getUpload];
    
    if(!_currentUpload)
        return;
    
    if(_currentUpload.objConnection)
        return;

    //Chưa up hình
    if(_currentUpload.idUserGallery.integerValue==0)
    {
        ASIOperationUploadUserGallery *ope=[[ASIOperationUploadUserGallery alloc] initWithIDShop:_currentUpload.idShop.integerValue image:_currentUpload.image userLat:userLat() userLng:userLng()];
        ope.delegatePost=self;
        
        [ope startAsynchronous];
        
        _currentUpload.objConnection=ope;
    }
    //Đã up hình chưa up description
    else if(_currentUpload.desc.length>0)
        [self uploadDesc];
    else
        //Đã up hình nhưng chưa có description, chờ screen gọi update description
        _currentUpload=nil;
}

-(UserGalleryUpload*) getUpload
{
    NSArray *array=[UserGalleryUpload allObjects];
    
    for(UserGalleryUpload *upload in array)
    {
        if(upload.enumStatus!=USER_GALLERY_UPLOAD_STATUS_NEXT)
            return upload;
    }
    
    return nil;
}

-(void) uploadDesc
{
    if(!_currentUpload)
        [self startUpload];
    
    if(_currentUpload && _currentUpload.desc.length>0 && _currentUpload.idUserGallery.integerValue>0)
    {
        ASIOperationPostPicture *opePost=[[ASIOperationPostPicture alloc] initWithIDUserGallery:_currentUpload.idUserGallery.integerValue userLat:userLat() userLng:userLng() description:_currentUpload.desc];
        opePost.delegatePost=self;
        [opePost startAsynchronous];
        
        _currentUpload.objConnection=opePost;
    }
    else
        _currentUpload=nil;
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUploadUserGallery class]])
    {
        if(_currentUpload)
        {
            if(_currentUpload.objConnection==operation)
            {
                ASIOperationUploadUserGallery *ope=(ASIOperationUploadUserGallery*)operation;
                
                if(ope.status==1)
                {
                    _currentUpload.idUserGallery=@(ope.idUserGallery);
                    [[DataManager shareInstance] save];

                    _currentUpload.objConnection=nil;
                    
                    if(_currentUpload.desc.length>0)
                        [self uploadDesc];
                    else
                        _currentUpload=nil;
                }
                else
                {
                    _currentUpload.objConnection=nil;
                    
                    [_currentUpload markDeleted];
                    [[DataManager shareInstance] save];

                    _currentUpload=nil;
                    
                    [self startUpload];
                }
            }
        }
    }
    else if([operation isKindOfClass:[ASIOperationPostPicture class]])
    {
        if(_currentUpload)
        {
            if(_currentUpload.objConnection==operation)
            {
                ASIOperationPostPicture *ope=(ASIOperationPostPicture*) operation;
                
                if(ope.status==1)
                {
                    _currentUpload.objConnection=nil;
                    [_currentUpload markDeleted];
                    [[DataManager shareInstance] save];
                    _currentUpload=nil;
                }
                else
                {
                    [_currentUpload markDeleted];
                    [[DataManager shareInstance] save];
                    _currentUpload=nil;
                }
            }
        }
    }
}

-(void) restartUploadImage
{
    if(_currentUpload)
    {
        ASIOperationUploadUserGallery *ope=[[ASIOperationUploadUserGallery alloc] initWithIDShop:_currentUpload.idShop.integerValue image:_currentUpload.image userLat:userLat() userLng:userLng()];
        ope.delegatePost=self;
        
        [ope startAsynchronous];
        
        _currentUpload.objConnection=ope;
    }
}

-(void) restartUploadDesc
{
    if(_currentUpload)
    {
        ASIOperationPostPicture *opePost=[[ASIOperationPostPicture alloc] initWithIDUserGallery:_currentUpload.idUserGallery.integerValue userLat:userLat() userLng:userLng() description:_currentUpload.desc];
        opePost.delegatePost=self;
        [opePost startAsynchronous];
        
        _currentUpload.objConnection=opePost;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUploadUserGallery class]])
    {
        if(_currentUpload)
        {
            if(_currentUpload.objConnection==operation)
            {
                _currentUpload.objConnection=nil;
                _currentUpload.status=@(USER_GALLERY_UPLOAD_STATUS_NEXT);
                [[DataManager shareInstance] save];
                
                _currentUpload=nil;
                
                [self startUpload];
            }
        }
    }
    else if([operation isKindOfClass:[ASIOperationPostPicture class]])
    {
        if(_currentUpload)
        {
            if(_currentUpload.objConnection==operation)
            {
                _currentUpload.objConnection=nil;
                _currentUpload.status=@(USER_GALLERY_UPLOAD_STATUS_NEXT);
                [[DataManager shareInstance] save];
                
                _currentUpload=nil;
                
                [self startUpload];
            }
        }
    }
}

@end
