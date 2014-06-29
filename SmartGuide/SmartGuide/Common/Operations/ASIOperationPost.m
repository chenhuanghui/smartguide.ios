//
//  ASIOperationPost.m
//  SmartGuide
//
//  Created by XXX on 7/25/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "OperationRefreshToken.h"
#import "TokenManager.h"
#import "SGData.h"
#import <ImageIO/ImageIO.h>

static NSMutableArray *_asioperations=nil;

@interface ASIOperationPost()
{
}

@property (nonatomic, strong) NSURLRequest *requestURL;

@end

@implementation ASIOperationPost

+(NSURL*) makeURL:(NSURL*) sourceURL accessToken:(NSString*) accessToken
{
    NSString *url=[NSString stringWithFormat:@"%@",sourceURL];
    
    NSRange range=[url rangeOfString:@"access_token"];
    if(range.location!=NSNotFound)
    {
        url=[url substringWithRange:NSMakeRange(0, range.location-1)];
    }
    
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@",url,accessToken]];
}

-(ASIOperationPost *)initPOSTWithRouter:(NSURL *)_url
{
    NSURLRequest *request=[[ASIOperationManager shareInstance] createPOST:_url.absoluteString parameters:nil];
    self=[super initWithRequest:request];
    
    [self commonInit];
    
    self.requestURL=request;
    self.sourceURL=[_url copy];
    
    return self;
}

-(ASIOperationPost *)initPOSTWithURL:(NSURL *)_url
{
    NSString *accessToken=[NSString stringWithString:[TokenManager shareInstance].accessToken];
    _url=[ASIOperationPost makeURL:_url accessToken:accessToken];
    
    NSURLRequest *request=[[ASIOperationManager shareInstance] createPOST:_url.absoluteString parameters:nil];
    
    self=[super initWithRequest:request];
    
    [self commonInit];
    
    self.requestURL=request;
    self.sourceURL=[_url copy];
    
    return self;
}

-(ASIOperationPost *)initGETWithRouter:(NSURL *)_url
{
    NSURLRequest *request=[[ASIOperationManager shareInstance] createGET:_url.absoluteString parameters:nil];
    self=[super initWithRequest:request];
    
    [self commonInit];
    
    self.requestURL=request;
    self.sourceURL=[_url copy];
    
    return self;
}

-(ASIOperationPost *)initGETWithURL:(NSURL *)_url
{
    NSString *accessToken=[NSString stringWithString:[TokenManager shareInstance].accessToken];
    _url=[ASIOperationPost makeURL:_url accessToken:accessToken];
    
    NSURLRequest *request=[[ASIOperationManager shareInstance] createGET:_url.absoluteString parameters:nil];
    
    self=[super initWithRequest:request];
    
    [self commonInit];
    
    self.requestURL=request;
    self.sourceURL=[_url copy];
    
    return self;
}

-(ASIOperationPost *)initRouterWithMethod:(enum OPERATION_METHOD_TYPE)methodType url:(NSString *)url
{
    NSURLRequest *request=nil;
    
    switch (methodType) {
        case OPERATION_METHOD_TYPE_GET:
            request=[[ASIOperationManager shareInstance] createGET:url parameters:nil];
            break;
            
        case OPERATION_METHOD_TYPE_POST:
            request=[[ASIOperationManager shareInstance] createPOST:url parameters:nil];
            break;
    }
    
    self=[super initWithRequest:request];
    
    [self commonInit];
    
    self.requestURL=request;
    self.sourceURL=[url copy];
    
    return self;
}

-(NSURLRequest *)request
{
    return self.requestURL?:[super request];
}

-(void) commonInit
{
    self.keyValue=[NSMutableDictionary dictionary];
    self.fData=[NSMutableDictionary dictionary];
    self.storeData=[NSMutableDictionary dictionary];
}

-(void)addImage:(NSData *)binary withKey:(NSString *)key
{
    if(!self.imagesData)
        self.imagesData=[NSMutableDictionary new];
    
    [self.imagesData setObject:binary forKey:key];
}

-(void)start
{
    [self applyPostValue];
    
    DLOG_DEBUG(@"%@ %@ start %@ %@ %@ %@",CLASS_NAME, self.requestURL.HTTPMethod,self.requestURL.URL, self.keyValue.allKeys, self.keyValue.allValues,self.imagesData.allKeys?:@"");
    
    __weak ASIOperationPost *wSelf=self;
    [self setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(wSelf)
            [wSelf requestFinished:operation];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(wSelf)
            [wSelf requestFailed:operation];
    }];
    
    [super start];
}

-(void)addToQueue
{
    [[ASIOperationManager shareInstance] addOperation:self];
}

-(void) applyPostValue
{
    if([self isApplySGData])
    {
        if([self fScreen].length==0 && [SGData shareInstance].fScreen.length>0)
            self.fScreen=[SGData shareInstance].fScreen;
        if([self fData].allKeys.count==0 && [SGData shareInstance].fData.allKeys.count>0)
            self.fData=[SGData shareInstance].fData;
        
        if([self tScreen].length>0)
            [self.keyValue setObject:[self tScreen] forKey:@"tScreen"];
        if([self tData].allKeys.count>0)
        {
            NSString *jsonString=[[NSString alloc] initWithData:[[self tData] json] encoding:NSUTF8StringEncoding];
            [self.keyValue setObject:jsonString forKey:@"tData"];
        }
        
        if([self fScreen].length>0)
            [self.keyValue setObject:[self fScreen] forKey:@"fScreen"];
        if([self fData].allKeys.count>0)
        {
            NSString *jsonString=[[NSString alloc] initWithData:[[self fData] json] encoding:NSUTF8StringEncoding];
            [self.keyValue setObject:jsonString forKey:@"fData"];
        }
    }
    
    if(![self.keyValue isNullData])
    {
        NSError *error=nil;;
        
        if(self.imagesData.count>0)
        {
            self.requestURL=[[ASIOperationManager shareInstance].requestSerializer multipartFormRequestWithMethod:self.requestURL.HTTPMethod URLString:self.requestURL.URL.absoluteString parameters:self.keyValue constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                for(NSString *key in self.imagesData.allKeys)
                {
                    NSData *data=self.imagesData[key];
                    
                    CGImageSourceRef imgSourceRef=CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
                    CFStringRef imgType=CGImageSourceGetType(imgSourceRef);
                    NSString *imageType=@"jpeg";
                    
                    if([((__bridge NSString*)imgType) isContainString:@"png"])
                        imageType=@"png";
                    
                    [formData appendPartWithFileData:data name:key fileName:key mimeType:imageType];
                    
                    CFRelease(imgSourceRef);
                    CFRelease(imgType);
                }
            } error:&error];
        }
        else
        {
            self.requestURL=[[ASIOperationManager shareInstance].requestSerializer requestBySerializingRequest:self.request withParameters:self.keyValue error:&error];
        }
    }
}

-(void) notifyFailed:(NSError*) errorr
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    DLOG_DEBUG(@"%@ failed %@",CLASS_NAME,[NSHTTPURLResponse localizedStringForStatusCode:self.response.statusCode]);
              
    if([self isRespondsToSelector:@selector(ASIOperaionPostFailed:)])
        [self.delegate ASIOperaionPostFailed:self];
}

-(bool) handleTokenError:(NSDictionary*) json
{
    if(json.count>0)
    {
        NSString *key=[NSString stringWithStringDefault:[json valueForKey:@"error"]];
        if(key.length>0)
        {
            if([key isEqualToString:@"invalid_grant"])
            {
                if(!_asioperations)
                {
                    _asioperations=[[NSMutableArray alloc] init];
                }
                
                [_asioperations addObject:self];
                
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTokenSuccess:) name:NOTIFICATION_REFRESH_TOKEN_SUCCESS object:nil];
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTokenFailed:) name:NOTIFICATION_REFRESH_TOKEN_FAILED object:nil];
                
                if(![TokenManager shareInstance].isRefreshingToken)
                {
                    [[TokenManager shareInstance] refresh];
                }
                
                return true;
            }
        }
    }
    
    return false;
}

-(void)onFinishLoading
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(ASIOperationPostFinishedLoading:)])
        [self.delegate ASIOperationPostFinishedLoading:self];
}

-(bool)isHandleResponseString:(NSString *)resString error:(NSError *__autoreleasing *)error
{
    return false;
}

-(void)requestFinished:(AFHTTPRequestOperation *)request
{
    DLOG_DEBUG(@"%@ requestFinished %@",CLASS_NAME,[NSHTTPURLResponse localizedStringForStatusCode:self.response.statusCode]);
    
    [self onFinishLoading];
    if(self.responseString.length>0)
    {
        NSError *error=nil;
        bool isHandleResponString=[self isHandleResponseString:self.responseString error:&error];
        if(isHandleResponString)
        {
            if(error)
            {
                [self notifyFailed:error];
            }
            else
            {
                [self notifyCompleted];
            }
        }
        else
        {
            id json = self.responseObject;
            
            if(self.error)
            {
                [self onFailed:self.error];
                [self notifyFailed:self.error];
            }
            else
            {
                if([json isKindOfClass:[NSArray class]])
                {
                    NSMutableArray *jsonArray=json;
                    
                    if(jsonArray.count==0 || [jsonArray objectAtIndex:0] == [NSNull null])
                        [self onCompletedWithJSON:[NSArray array]];
                    else
                        [self onCompletedWithJSON:jsonArray];
                    
                    [self notifyCompleted];
                }
                else if([json isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary *jsonDict=json;
                    
                    if([self handleTokenError:jsonDict])
                        return;
                    
                    if(jsonDict.count==0)
                        [self onCompletedWithJSON:[NSArray array]];
                    else
                        [self onCompletedWithJSON:[NSArray arrayWithObject:jsonDict]];
                    
                    [self notifyCompleted];
                }
                else if(json==[NSNull null])
                {
                    @try {
                        [self onCompletedWithJSON:@[[NSNull null]]];
                    }
                    @catch (NSException *exception) {
                        DLOG_DEBUG(@"%@ process null error %@",CLASS_NAME,exception);
                    }
                    @finally {
                        [self notifyCompleted];
                    }
                }
                else if([json isKindOfClass:[NSNumber class]])
                {
                    @try {
                        [self onCompletedWithJSON:@[json]];
                    }
                    @catch (NSException *exception) {
                        DLOG_DEBUG(@"%@ process number error %@",CLASS_NAME,exception);
                    }
                    @finally {
                        [self notifyCompleted];
                    }
                }
                else
                {
                    DLogDebug(^NSString *{
                        return [NSString stringWithFormat:@"%@ unknow json class %@",CLASS_NAME,NSStringFromClass([json class])];
                    });
                    
                    [self notifyCompleted];
                }
            }
        }
    }
    else
        [self notifyCompleted];
}

-(void)notifyCompleted
{
    DLogDebug(^NSString *{
        return [NSString stringWithFormat:@"%@ finished %i",CLASS_NAME,self.responseString.length];
    });
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if([self isRespondsToSelector:@selector(ASIOperaionPostFinished:)])
        [self.delegate ASIOperaionPostFinished:self];
}

-(void)requestFailed:(AFHTTPRequestOperation *)request
{
    DLogDebug(^NSString *{
        return [NSString stringWithFormat:@"%@ requestFailed %@",CLASS_NAME, [NSHTTPURLResponse localizedStringForStatusCode:self.response.statusCode]];
    });
    
    if(self.responseString.length>0)
    {
        NSArray *json=self.responseObject;
        
        if([json isKindOfClass:[NSDictionary class]] && json.count>0)
        {
            if([self handleTokenError:(NSDictionary*)json])
                return;
        }
    }
    
    [self onFinishLoading];
    [self onFailed:self.error];
    [self notifyFailed:self.error];
}

-(void) refreshTokenFailed:(NSNotification*) notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self onFailed:self.error];
    [self notifyFailed:self.error];
}

-(void) refreshTokenSuccess:(NSNotification*) notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self restart];
}

-(void)restart
{
    ASIOperationPost *ope=[[[self class] alloc] initPOSTWithURL:self.sourceURL];
    ope.delegate=self.delegate;
    ope.keyValue=self.keyValue;
    ope.imagesData=self.imagesData;
    ope.storeData=self.storeData;
    
    DLogDebug(^NSString *{
        return [NSString stringWithFormat:@"%@ %@ restart %@ %@ %@",NSStringFromClass([ope class]),ope.request.HTTPMethod,ope.request.URL,ope.keyValue, ope.imagesData.allKeys?:@""];
    });
    
    [_asioperations removeObject:self];
    
    [ope addToQueue];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    
}

-(void)onFailed:(NSError *)error
{
    
}

-(BOOL) isRespondsToSelector:(SEL)aSelector
{
    return self.delegate && [self.delegate respondsToSelector:aSelector];
}

-(void)clearDelegatesAndCancel
{
    DLogDebug(^NSString *{
        return [NSString stringWithFormat:@"%@ clearDelegatesAndCancel",CLASS_NAME];
    });
    
    self.delegate=nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self cancel];
}

// If a delegate implements one of these, it will be asked to supply credentials when none are available
// The delegate can then either restart the request ([request retryUsingSuppliedCredentials]) once credentials have been set
// or cancel it ([request cancelAuthentication])
//- (void)authenticationNeededForRequest:(ASIHTTPRequest *)request;
//- (void)proxyAuthenticationNeededForRequest:(ASIHTTPRequest *)request;

-(id)copyWithZone:(NSZone *)zone
{
    ASIOperationPost *ope=[super copyWithZone:zone];
    
    ope.keyValue=self.keyValue;
    ope.imagesData=self.imagesData;
    ope.sourceURL=self.sourceURL;
    ope.storeData=self.storeData;
    
    return ope;
}

-(bool)isApplySGData
{
    return true;
}

- (void)dealloc
{
    DLogDebug(^NSString *{
        return [NSString stringWithFormat:@"dealloc %@",CLASS_NAME];
    });
    
    self.keyValue=nil;
    self.sourceURL=nil;
    self.tScreen=nil;
    self.tData=nil;
    self.fScreen=nil;
    self.fData=nil;
    self.delegate=nil;
}

@end

static ASIOperationManager *_operationManager=nil;
@implementation ASIOperationManager

+(ASIOperationManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _operationManager=[[ASIOperationManager alloc] init];
    });
    
    return _operationManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.responseSerializer=[AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves];
    }
    return self;
}

-(NSMutableURLRequest *)createPOST:(NSString *)urlString parameters:(NSDictionary *)parameters
{
    NSError *error=nil;
    NSMutableURLRequest *urlRequest=[self.requestSerializer requestWithMethod:@"POST" URLString:urlString parameters:parameters error:&error];
    
    if(error)
        DLogDebug(^NSString *{
            return [NSString stringWithFormat:@"%@ createPOST %@ parameters %@ error %@", CLASS_NAME, urlString, parameters, error];
        });
    
    return urlRequest;
}

-(NSMutableURLRequest *)createGET:(NSString *)urlString parameters:(NSDictionary *)parameters
{
    NSError *error=nil;
    NSMutableURLRequest *urlRequest=[self.requestSerializer requestWithMethod:@"GET" URLString:urlString parameters:parameters error:&error];
    
    if(error)
        DLogDebug(^NSString *{
            return [NSString stringWithFormat:@"%@ createGET %@ parameters %@ error %@", CLASS_NAME, urlString, parameters, error];
        });
    
    return urlRequest;
}

-(void)addOperation:(ASIOperationPost *)operation
{
    operation.responseSerializer = self.responseSerializer;
    operation.shouldUseCredentialStorage = self.shouldUseCredentialStorage;
    operation.credential = self.credential;
    operation.securityPolicy = self.securityPolicy;
    
    [self.operationQueue addOperation:operation];
}

-(void)clearAllOperation
{
    [self.operationQueue cancelAllOperations];
}

@end

@implementation ASIOperationResponseSerializer



@end