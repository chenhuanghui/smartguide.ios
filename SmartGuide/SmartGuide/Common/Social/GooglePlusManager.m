//
//  GooglePlusManager.m
//  SmartGuide
//
//  Created by MacMini on 08/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "GooglePlusManager.h"
#import "Constant.h"
#import <GoogleOpenSource/GoogleOpenSource.h>

static GooglePlusManager *_gpManager=nil;
@implementation GooglePlusManager
@synthesize authentication;

+(void)load
{
    [GooglePlusManager shareInstance];
}

+(GooglePlusManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _gpManager=[GooglePlusManager new];
    });
    
    return _gpManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self gppSignIn].delegate=self;
        [[self gppSignIn] trySilentAuthentication];
    }
    return self;
}

-(GPPSignIn *)gppSignIn
{
    [[GPPSignIn sharedInstance] setClientID:kClientId];
    [GPPSignIn sharedInstance].scopes=@[kGTLAuthScopePlusLogin,kGTLAuthScopePlusMe];
    [GPPSignIn sharedInstance].shouldFetchGooglePlusUser=true;
    [GPPSignIn sharedInstance].shouldFetchGoogleUserEmail=true;
    
    return [GPPSignIn sharedInstance];
}

@end

#import <objc/runtime.h>

static char GooglePlusShareURLKey;

@implementation GooglePlusManager(Share)

-(NSURL *)urlToShare
{
    return objc_getAssociatedObject(self, &GooglePlusShareURLKey);
}

-(void)setUrlToShare:(NSURL *)urlToShare
{
    objc_setAssociatedObject(self, &GooglePlusShareURLKey, urlToShare, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void) shareLink:(NSURL *)url
{
    if(url==nil)
        return;
    
    [GPPShare sharedInstance].delegate=self;
    
    GPPSignIn *sign=[[GooglePlusManager shareInstance] gppSignIn];
    sign.delegate=self;
    
    if(sign.authentication)
    {
        id<GPPShareBuilder> share=[[GPPShare sharedInstance] nativeShareDialog];
        
        [share setURLToShare:url];
        [share open];
    }
    else
    {
        self.urlToShare=url;
        
        if([sign trySilentAuthentication])
        {
            
        }
        else
            [sign authenticate];
    }
}

-(void)finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error
{
    if(!error)
    {
        if(self.urlToShare)
        {
            [self shareLink:self.urlToShare];
        }
    }
    else
    {
        [auth reset];
        [[self gppSignIn] signOut];
    }
}

-(void)finishedSharing:(BOOL)shared
{
    self.urlToShare=nil;
}

-(void)finishedSharingWithError:(NSError *)error
{
    if(error.code!=kGPPErrorShareboxCanceled
       && error.code!=kGPPErrorShareboxCanceledByClient)
    {
        [[GPPSignIn sharedInstance] signOut];
    }
    
    self.urlToShare=nil;
}

@end