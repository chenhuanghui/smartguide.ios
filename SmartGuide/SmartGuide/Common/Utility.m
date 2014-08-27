//
//  Utility.m
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "Utility.h"
#import <CommonCrypto/CommonHMAC.h>
#import "FTCoreTextStyle.h"
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
#import "Constant.h"
#import <objc/runtime.h>
#import <sys/sysctl.h>
#import "LoadingView.h"
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

NSNumber* NMIN(NSNumber* num1,...)
{
    NSNumber *min=[num1 copy];
    
    va_list list;
    
    va_start(list, num1);
    
    for(NSNumber* num=num1; num; num=va_arg(list, NSNumber*))
    {
        if(num.floatValue<min.floatValue)
            min=[num copy];
    }
    
    va_end(list);
    
    return min;
}

NSNumber* NMAX(NSNumber* num1,...)
{
    NSNumber *max=[num1 copy];
    
    va_list list;
    
    va_start(list, num1);
    
    for(NSNumber* num=num1; num; num=va_arg(list, NSNumber*))
    {
        if(num.floatValue>max.floatValue)
            max=[num copy];
    }
    
    va_end(list);
    
    return max;
}

NSParagraphStyle *paragraphStyleJustified()
{
    NSMutableParagraphStyle *paraStyle=[NSMutableParagraphStyle new];
    
    paraStyle.alignment=NSTextAlignmentJustified;
    paraStyle.lineBreakMode=NSLineBreakByTruncatingTail;
    
    return paraStyle;
}

NSString* NSStringFromCoordinate(CLLocationCoordinate2D coordinate)
{
    return [NSString stringWithFormat:@"coordinate latitude %f longitude %f",coordinate.latitude,coordinate.longitude];
}

CGPathRef CGPathCreateRoundRect( const CGRect r, const CGFloat cornerRadius )
{
    CGMutablePathRef p = CGPathCreateMutable() ;
    
    CGPathMoveToPoint( p, NULL, r.origin.x + cornerRadius, r.origin.y ) ;
    
    CGFloat maxX = CGRectGetMaxX( r ) ;
    CGFloat maxY = CGRectGetMaxY( r ) ;
    
    CGPathAddArcToPoint( p, NULL, maxX, r.origin.y, maxX, r.origin.y + cornerRadius, cornerRadius ) ;
    CGPathAddArcToPoint( p, NULL, maxX, maxY, maxX - cornerRadius, maxY, cornerRadius ) ;
    
    CGPathAddArcToPoint( p, NULL, r.origin.x, maxY, r.origin.x, maxY - cornerRadius, cornerRadius ) ;
    CGPathAddArcToPoint( p, NULL, r.origin.x, r.origin.y, r.origin.x + cornerRadius, r.origin.y, cornerRadius ) ;
    
    return p ;
}

bool isVailCLLocationCoordinate2D(CLLocationCoordinate2D location)
{
    return location.latitude>0 && location.longitude>0;
}

void makePhoneCall(NSString* phone)
{
    NSString *text=[phone copy];
    
    text=[text stringByRemoveString:@" ",nil];
    if(text.length==0)
        return;
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",text]]];
}

int random_int(int from, int to)
{
    return from + rand() % (to-from);
}

float UIScreenScale()
{
    return [UIScreen mainScreen].scale;
}

CGSize UIScreenSize()
{
    return [UIScreen mainScreen].bounds.size;
}

CGSize UIApplicationSize()
{
    return [UIScreen mainScreen].applicationFrame.size;
}

float UIStatusBarHeight()
{
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}

NSURL* URL(NSString* url)
{
    if([url isKindOfClass:[NSURL class]])
        return [NSURL URLWithString:((NSURL*)url).absoluteString];
    
    return [NSURL URLWithString:url];
}

NSIndexPath *makeIndexPath(int row, int section)
{
    return [NSIndexPath indexPathForRow:row inSection:section];
}

CGSize CGSizeResizeToWidth(float width, CGSize size)
{
    if(size.width==0)
        return CGSizeZero;
    
    return CGSizeMake(width, MAX(0, width*size.height/size.width));
}

CGSize CGSizeReduceToWidth(float width, CGSize size)
{
    if(size.width==0)
        return CGSizeZero;
    else if(size.width<width)
        return size;
    
    return CGSizeMake(width, MAX(0, width*size.height/size.width));
}

CGSize CGSizeResizeToHeight(float height, CGSize size) {
    size.width *= height / size.height;
    size.height = height;
    return size;
}

NSString *documentPath()
{
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [searchPaths lastObject];
    
    return documentPath;
}

NSString *avatarPath()
{
    return [[NSFileManager defaultManager] avatarsPath];
}

NSUInteger UIViewAutoresizingAll()
{
    return UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
}

NSUInteger UIViewAutoresizingDefault()
{
    return UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
}

float roundToN(float num, int decimals)
{
    int tenpow = 1;
    for (; decimals; tenpow *= 10, decimals--);
    return round(tenpow * num) / tenpow;
}

NSString *NSStringFromObject(NSObject* obj)
{
    return NSStringFromClass([obj class]);
}

NSString *NSStringFromUIGestureRecognizerState(UIGestureRecognizerState state)
{
    switch (state) {
        case UIGestureRecognizerStateBegan:
            return @"UIGestureRecognizerStateBegan";
            
        case UIGestureRecognizerStateCancelled:
            return @"UIGestureRecognizerStateCancelled";
            
        case UIGestureRecognizerStateChanged:
            return @"UIGestureRecognizerStateChanged";
            
        case UIGestureRecognizerStateEnded:
            return @"UIGestureRecognizerStateEnded";
            
        case UIGestureRecognizerStateFailed:
            return @"UIGestureRecognizerStateFailed";
            
        case UIGestureRecognizerStatePossible:
            return @"UIGestureRecognizerStatePossible";
    }
}

NSString* UUID()
{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *uuid=[[NSUserDefaults standardUserDefaults] stringForKey:@"uuid"];
    if(uuid.length==0)
    {
        uuid=[[NSUUID UUID] UUIDString];
        [[NSUserDefaults standardUserDefaults] setObject:uuid forKey:@"uuid"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return uuid;
}

static NSCache *_shareCache=nil;
NSCache *shareCached()
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareCache=[[NSCache alloc] init];
    });
    
    return _shareCache;
}

NSArray *CITY_LIST()
{
    if(![shareCached() objectForKey:@"cityList"])
    {
        NSString *path=[[NSBundle mainBundle] pathForResource:@"city_list" ofType:@"txt"];
        NSData *data=[[NSFileManager defaultManager] contentsAtPath:path];
        NSError *error=nil;
        NSArray *array=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if(error)
            [shareCached() setObject:[NSArray array] forKey:@"cityList"];
        else
            [shareCached() setObject:array forKey:@"cityList"];
    }
    
    return [shareCached() objectForKey:@"cityList"];
}

NSString *CITY_NAME(int idCity)
{
    NSArray *cities=CITY_LIST();
    
    if(cities.count==0)
        return @"";
    
    id obj=nil;
    for(NSDictionary *dict in cities)
    {
        obj=dict[@"id"];
        
        if(obj && [obj integerValue]==idCity)
            return [NSString makeString:dict[@"name"]];
    }
    
    return @"";
}

int IDCITY_HCM()
{
    return 1;
}

int IDCITY_DANANG()
{
    return 140;
}

NSAttributedString *APPLY_QUOTATION_MARK(NSString* text, NSDictionary *textAttribute, NSDictionary *quotationAttribute)
{
    text=[NSString stringWithFormat:@" %@ ",text];
    NSMutableAttributedString *attStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\xE2\x80\x9C%@\xE2\x80\x9D",text]];
    
    [attStr setAttributes:quotationAttribute range:NSMakeRange(0, 1)];
    [attStr setAttributes:textAttribute range:NSMakeRange(1, text.length)];
    [attStr setAttributes:quotationAttribute range:NSMakeRange(text.length+1, 1)];
    
    return attStr;
}

UIColor* COLOR255(float r, float g, float b, float a)
{
    return [UIColor color255WithRed:r green:g blue:b alpha:a];
}

#pragma mark LAZY_INIT

NSString* LAZY_STRING_INT(int i)
{
    return [NSString stringWithFormat:@"%i",i];
}

NSSortDescriptor *sortDesc(NSString *key, BOOL ascending)
{
    return [NSSortDescriptor sortDescriptorWithKey:key ascending:ascending];
}

NSString *macAddress()
{
    int                 mgmtInfoBase[6];
    char                *msgBuffer = NULL;
    NSString            *errorFlag = NULL;
    size_t              length;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
        // Get the size of the data available (store in len)
        else if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
            // Alloc memory based on above call
            else if ((msgBuffer = malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
                // Get system information, store in buffer
                else if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                {
                    free(msgBuffer);
                    errorFlag = @"sysctl msgBuffer failure";
                }
                else
                {
                    // Map msgbuffer to interface message structure
                    struct if_msghdr *interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
                    
                    // Map to link-level socket structure
                    struct sockaddr_dl *socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
                    
                    // Copy link layer address data in socket structure to an array
                    unsigned char macAddress[6];
                    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
                    
                    // Read from char array into a string object, into traditional Mac address format
                    NSString *macAddressString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                                                  macAddress[0], macAddress[1], macAddress[2], macAddress[3], macAddress[4], macAddress[5]];
                    
                    DLOG_DEBUG(@"Mac Address: %@", macAddressString);
                    
                    // Release the buffer memory
                    free(msgBuffer);
                    
                    return macAddressString;
                }
    
    // Error...
    DLOG_DEBUG(@"Error: %@", errorFlag);
    
    return @"";
}

@implementation Utility

+(CGRect) centerPinWithFrameAnnotation:(CGRect) rectAnn framePin:(CGRect) rectPin
{
    rectPin.origin=CGPointMake(-rectPin.size.width/2+rectAnn.size.width/2, -rectPin.size.height);
    return rectPin;
}

+(NSArray *)ftCoreTextFormatScoreMapStyle
{
    NSMutableArray *array=[NSMutableArray array];
    
    FTCoreTextStyle *scoreStyle=[FTCoreTextStyle new];
    scoreStyle.name=@"score";
    scoreStyle.font=[UIFont systemFontOfSize:16];
    scoreStyle.color=[UIColor whiteColor];
    scoreStyle.textAlignment=FTCoreTextAlignementCenter;
    
    FTCoreTextStyle *aStyle=[FTCoreTextStyle new];
    aStyle.name=@"a";
    aStyle.font=[UIFont systemFontOfSize:12];
    aStyle.color=[UIColor color255WithRed:150 green:150 blue:150 alpha:255];
    
    [array addObject:scoreStyle];
    [array addObject:aStyle];
    
    return array;
}

+(NSArray *)ftCoreTextFormatScoreStyle
{
    NSMutableArray *array=[NSMutableArray array];
    
    FTCoreTextStyle *scoreStyle=[FTCoreTextStyle new];
    scoreStyle.name=@"score";
    scoreStyle.font=[UIFont systemFontOfSize:25];
    scoreStyle.color=[UIColor whiteColor];
    scoreStyle.textAlignment=FTCoreTextAlignementCenter;
    
    FTCoreTextStyle *aStyle=[FTCoreTextStyle new];
    aStyle.name=@"a";
    aStyle.font=[UIFont systemFontOfSize:18];
    aStyle.color=[UIColor color255WithRed:0 green:235 blue:190 alpha:255];
    
    [array addObject:scoreStyle];
    [array addObject:aStyle];
    
    return array;
}

+(NSArray *)ftCoreTextFormatScoreListStyle
{
    NSMutableArray *array=[NSMutableArray array];
    
    FTCoreTextStyle *scoreStyle=[FTCoreTextStyle new];
    scoreStyle.name=@"score";
    scoreStyle.font=[UIFont boldSystemFontOfSize:14];
    scoreStyle.color=[UIColor whiteColor];
    scoreStyle.textAlignment=FTCoreTextAlignementCenter;
    
    FTCoreTextStyle *aStyle=[FTCoreTextStyle new];
    aStyle.name=@"a";
    aStyle.font=[UIFont boldSystemFontOfSize:10];
    aStyle.color=COLOR_BACKGROUND_APP;
    
    [array addObject:scoreStyle];
    [array addObject:aStyle];
    
    return array;
}

+(NSString*) ftCoreTextFormatScore:(NSString *)score rank:(NSString *)rank
{
    return [NSString stringWithFormat:@"<score>%@</score><a>%@</a>",score,rank];
}

// Decode a polyline.
// See: http://code.google.com/apis/maps/documentation/utilities/polylinealgorithm.html
+ (NSMutableArray *)decodePolyLine:(NSMutableString *)encoded {
	[encoded replaceOccurrencesOfString:@"\\\\" withString:@"\\"
								options:NSLiteralSearch
								  range:NSMakeRange(0, [encoded length])];
	NSInteger len = [encoded length];
	NSInteger index = 0;
	NSMutableArray *array = [NSMutableArray array];
	NSInteger lat=0;
	NSInteger lng=0;
	while (index < len) {
		NSInteger b;
		NSInteger shift = 0;
		NSInteger result = 0;
		do {
			b = [encoded characterAtIndex:index++] - 63;
			result |= (b & 0x1f) << shift;
			shift += 5;
		} while (b >= 0x20);
		NSInteger dlat = ((result & 1) ? ~(result >> 1) : (result >> 1));
		lat += dlat;
		shift = 0;
		result = 0;
		do {
			b = [encoded characterAtIndex:index++] - 63;
			result |= (b & 0x1f) << shift;
			shift += 5;
		} while (b >= 0x20);
		NSInteger dlng = ((result & 1) ? ~(result >> 1) : (result >> 1));
		lng += dlng;
		NSNumber *latitude = [NSNumber numberWithFloat:lat*1e-5];
		NSNumber *longitude = [NSNumber numberWithFloat:lng*1e-5];
		// printf("[%f,", [latitude doubleValue]);
		// printf("%f]", [longitude doubleValue]);
		CLLocation *loc = [[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
		[array addObject:loc];
	}
    
	return array;
}

+(NSString *)documentPath
{
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [searchPaths objectAtIndex:0];
}

+(int)idShopFromQRCode:(NSString *)url
{
    //    return -1;
    if(url.length>0 && [url isContainString:@"/"])
    {
        int index=[url rangeOfString:@"/" options:NSBackwardsSearch].location;
        return [[url substringWithRange:NSMakeRange(index+1, url.length-index-1)] integerValue];
    }
    
    return -1;
}

+(CGSize) scaleProportionallyHeightFromSize:(CGSize) fSize toHeight:(float)height
{
    float h=height/fSize.height;
    fSize=CGSizeMake(fSize.width*h, height);
    
    return fSize;
}

+(CGSize)scaleProportionallyFromSize:(CGSize)fSize toSize:(CGSize)tSize
{
    if(fSize.width>fSize.height)
    {
        tSize=CGSizeMake((fSize.width/fSize.height)*tSize.height,tSize.height);
    }
    else
    {
        tSize=CGSizeMake(tSize.width,(fSize.height/fSize.width)*tSize.width);
    }
    
    return tSize;
}

+(CGSize)scaleUserPoseFromSize:(CGSize)fSize toSize:(CGSize)tSize
{
    if(fSize.width>fSize.height)
    {
        float oldHeight=fSize.height;
        float scaleFactor=tSize.height/oldHeight;
        
        return CGSizeMake(fSize.width*scaleFactor, oldHeight*scaleFactor);
    }
    
    float oldWitdh=fSize.width;
    float scaleFactor=tSize.width/oldWitdh;
    
    return CGSizeMake(oldWitdh*scaleFactor, fSize.height*scaleFactor);
}

+(CGPoint)centerRect:(CGRect)rect
{
    return CGPointMake(rect.size.width/2, rect.size.height/2);
}

@end

@implementation UIViewController(Utility)

-(UIBarButtonItem *)itemWithImage:(UIImage *)image sel:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    btn.frame=CGRectMake(0, 0, 32, 32);
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithCustomView:btn];
    
    return item;
}

@end

@implementation UIViewController(lazy_method)

//view x,y
-(CGPoint) l_v_o
{
    return self.view.frame.origin;
}
-(float) l_v_x
{
    return self.view.frame.origin.x;
}
-(float) l_v_y
{
    return self.view.frame.origin.y;
}
-(void) l_v_setO:(CGPoint) xy
{
    CGRect rect=self.view.frame;
    rect.origin=xy;
    self.view.frame=rect;
}
-(void) l_v_addO:(CGPoint) xy
{
    CGRect rect=self.view.frame;
    rect.origin.x+=xy.x;
    rect.origin.y+=xy.y;
    self.view.frame=rect;
}
-(void) l_v_setX:(float) x
{
    CGRect rect=self.view.frame;
    rect.origin.x=x;
    self.view.frame=rect;
}
-(void) l_v_setY:(float) y
{
    CGRect rect=self.view.frame;
    rect.origin.y=y;
    self.view.frame=rect;
}
-(void) l_v_addX:(float) x
{
    CGRect rect=self.view.frame;
    rect.origin.x+=x;
    self.view.frame=rect;
}
-(void) l_v_addY:(float) y
{
    CGRect rect=self.view.frame;
    rect.origin.y+=y;
    self.view.frame=rect;
}
//view width, height
-(CGSize) l_v_s
{
    return self.view.frame.size;
}
-(float) l_v_w
{
    return self.view.frame.size.width;
}
-(float) l_v_h
{
    return self.view.frame.size.height;
}
-(void) l_v_setS:(CGSize) wh
{
    CGRect rect=self.view.frame;
    rect.size=wh;
    self.view.frame=rect;
}
-(void) l_v_addS:(CGSize) wh
{
    CGRect rect=self.view.frame;
    rect.size.width+=wh.width;
    rect.size.height+=wh.height;
    self.view.frame=rect;
}
-(void) l_v_setW:(float) w
{
    CGRect rect=self.view.frame;
    rect.size.width=w;
    self.view.frame=rect;
}
-(void) l_v_setH:(float) h
{
    CGRect rect=self.view.frame;
    rect.size.height=h;
    self.view.frame=rect;
}
-(void) l_v_addW:(float) w
{
    CGRect rect=self.view.frame;
    rect.size.width+=w;
    self.view.frame=rect;
}
-(void) l_v_addH:(float) h
{
    CGRect rect=self.view.frame;
    rect.size.height+=h;
    self.view.frame=rect;
}

//view center
-(CGPoint) l_c
{
    return self.view.center;
}
-(float) l_c_x
{
    return self.view.center.x;
}
-(float) l_c_y
{
    return self.view.center.y;
}
-(void) l_c_setXY:(CGPoint) xy
{
    self.view.center=xy;
}
-(void) l_c_addXY:(CGPoint) xy
{
    CGPoint pnt=self.view.center;
    pnt.x+=xy.x;
    pnt.y+=xy.y;
    self.view.center=pnt;
}
-(void) l_c_setX:(float) x
{
    CGPoint pnt=self.view.center;
    pnt.x=x;
    self.view.center=pnt;
}
-(void) l_c_setY:(float) y
{
    CGPoint pnt=self.view.center;
    pnt.y=y;
    self.view.center=pnt;
}
-(void) l_c_addX:(float) x
{
    CGPoint pnt=self.view.center;
    pnt.x+=x;
    self.view.center=pnt;
}
-(void) l_c_addY:(float) y
{
    CGPoint pnt=self.view.center;
    pnt.y+=y;
    self.view.center=pnt;
}

@end

@implementation UIScrollView(lazy_method)

-(float)CSW
{
    return self.contentSize.width;
}

-(void)setCSW:(float)CSW
{
    self.contentSize=CGSizeMake(CSW, self.contentSize.height);
}

-(float)CSH
{
    return self.contentSize.height;
}

-(void)setCSH:(float)CSH
{
    self.contentSize=CGSizeMake(self.contentSize.width, CSH);
}

-(float)COX
{
    return self.contentOffset.x;
}

-(void)setCOX:(float)COX
{
    self.contentOffset=CGPointMake(COX, self.contentOffset.y);
}

-(void)setCOX:(float)COX animate:(bool)animate
{
    [self setContentOffset:CGPointMake(COX, self.contentOffset.y) animated:animate];
}

-(float)COY
{
    return self.contentOffset.y;
}

-(void)setCOY:(float)COY
{
    self.contentOffset=CGPointMake(self.contentOffset.x, COY);
}

-(void)setCOY:(float)COY animate:(bool)animate
{
    [self setContentOffset:CGPointMake(self.contentOffset.x, COY) animated:animate];
}

-(float) l_cs_h
{
    return self.contentSize.height;
}
-(float) l_cs_w
{
    return self.contentSize.width;
}
-(void) l_cs_setH:(float) h
{
    self.contentSize=CGSizeMake(self.contentSize.width, h);
}
-(void) l_cs_setW:(float) w
{
    self.contentSize=CGSizeMake(w, self.contentSize.height);
}
-(void) l_cs_addH:(float) h
{
    self.contentSize=CGSizeMake(self.contentSize.width, self.contentSize.height+h);
}
-(void) l_cs_addW:(float) w
{
    self.contentSize=CGSizeMake(self.contentSize.width+w, self.contentSize.height);
}

-(float) l_co_x
{
    return self.contentOffset.x;
}
-(float) l_co_y
{
    return self.contentOffset.y;
}
-(void) l_co_setX:(float) x
{
    self.contentOffset=CGPointMake(x, self.contentOffset.y);
}
-(void) l_co_setY:(float) y
{
    self.contentOffset=CGPointMake(self.contentOffset.x, y);
}
-(void) l_co_addX:(float) x
{
    self.contentOffset=CGPointMake(self.contentOffset.x+x, self.contentOffset.y);
}
-(void) l_co_addY:(float) y
{
    self.contentOffset=CGPointMake(self.contentOffset.x, self.contentOffset.y+y);
}

-(void) l_co_setX:(float) x animate:(bool)animate
{
    [self setContentOffset:CGPointMake(x, self.contentOffset.y) animated:animate];
}
-(void) l_co_setY:(float) y animate:(bool)animate
{
    [self setContentOffset:CGPointMake(self.contentOffset.x, y) animated:animate];
}
-(void) l_co_addX:(float) x animate:(bool)animate
{
    [self setContentOffset:CGPointMake(self.contentOffset.x+x, self.contentOffset.y) animated:animate];
}
-(void) l_co_addY:(float) y animate:(bool)animate
{
    [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y+y) animated:animate];
}

@end

@implementation UIView(lazy_method)

-(CGPoint)O
{
    return self.frame.origin;
}

-(void)setO:(CGPoint)O
{
    self.frame=CGRectMake(O.x, O.y, self.frame.size.width, self.frame.size.height);
}

-(float)OX
{
    return self.frame.origin.x;
}

-(void)setOX:(float)OX
{
    self.frame=CGRectMake(OX, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

-(float)OY
{
    return self.frame.origin.y;
}

-(void)setOY:(float)oy
{
    self.frame=CGRectMake(self.frame.origin.x, oy, self.frame.size.width, self.frame.size.height);
}

-(CGSize)S
{
    return self.frame.size;
}

-(void)setS:(CGSize)S
{
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, S.width, S.height);
}

-(float)SW
{
    return self.frame.size.width;
}

-(void)setSW:(float)SW
{
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, SW, self.frame.size.height);
}

-(float)SH
{
    return self.frame.size.height;
}

-(void)setSH:(float)SH
{
    self.frame=self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, SH);
}

-(CGPoint)C
{
    return self.center;
}

-(void)setC:(CGPoint)C
{
    self.center=C;
}

-(float)CX
{
    return self.center.x;
}

-(void)setCX:(float)CX
{
    self.center=CGPointMake(CX, self.center.y);
}

-(float)CY
{
    return self.center.y;
}

-(void)setCY:(float)CY
{
    self.center=CGPointMake(self.center.x, CY);
}

-(float)xw
{
    return self.frame.origin.x+self.frame.size.width;
}

-(float)yh
{
    return self.frame.origin.y+self.frame.size.height;
}

//view x,y
-(CGPoint) l_v_o
{
    return self.frame.origin;
}
-(float) l_v_x
{
    return self.frame.origin.x;
}
-(float) l_v_y
{
    return self.frame.origin.y;
}
-(void) l_v_setO:(CGPoint) xy
{
    CGRect rect=self.frame;
    rect.origin=xy;
    self.frame=rect;
}
-(void) l_v_addO:(CGPoint) xy
{
    CGRect rect=self.frame;
    rect.origin.x+=xy.x;
    rect.origin.y+=xy.y;
    self.frame=rect;
}
-(void) l_v_setX:(float) x
{
    CGRect rect=self.frame;
    rect.origin.x=x;
    self.frame=rect;
}
-(void) l_v_setY:(float) y
{
    CGRect rect=self.frame;
    rect.origin.y=y;
    self.frame=rect;
}
-(void) l_v_addX:(float) x
{
    CGRect rect=self.frame;
    rect.origin.x+=x;
    self.frame=rect;
}
-(void) l_v_addY:(float) y
{
    CGRect rect=self.frame;
    rect.origin.y+=y;
    self.frame=rect;
}
//view width, height
-(CGSize) l_v_s
{
    return self.frame.size;
}
-(float) l_v_w
{
    return self.frame.size.width;
}
-(float) l_v_h
{
    return self.frame.size.height;
}
-(void) l_v_setS:(CGSize) wh
{
    CGRect rect=self.frame;
    rect.size=wh;
    self.frame=rect;
}
-(void) l_v_addS:(CGSize) wh
{
    CGRect rect=self.frame;
    rect.size.width+=wh.width;
    rect.size.height+=wh.height;
    self.frame=rect;
}
-(void) l_v_setW:(float) w
{
    CGRect rect=self.frame;
    rect.size.width=w;
    self.frame=rect;
}
-(void) l_v_setH:(float) h
{
    CGRect rect=self.frame;
    rect.size.height=h;
    self.frame=rect;
}
-(void) l_v_addW:(float) w
{
    CGRect rect=self.frame;
    rect.size.width+=w;
    self.frame=rect;
}
-(void) l_v_addH:(float) h
{
    CGRect rect=self.frame;
    rect.size.height+=h;
    self.frame=rect;
}

//view center
-(CGPoint) l_c
{
    return self.center;
}
-(float) l_c_x
{
    return self.center.x;
}
-(float) l_c_y
{
    return self.center.y;
}
-(void) l_c_setXY:(CGPoint) xy
{
    self.center=xy;
}
-(void) l_c_addXY:(CGPoint) xy
{
    CGPoint pnt=self.center;
    pnt.x+=xy.x;
    pnt.y+=xy.y;
    self.center=pnt;
}
-(void) l_c_setX:(float) x
{
    CGPoint pnt=self.center;
    pnt.x=x;
    self.center=pnt;
}
-(void) l_c_setY:(float) y
{
    CGPoint pnt=self.center;
    pnt.y=y;
    self.center=pnt;
}
-(void) l_c_addX:(float) x
{
    CGPoint pnt=self.center;
    pnt.x+=x;
    self.center=pnt;
}
-(void) l_c_addY:(float) y
{
    CGPoint pnt=self.center;
    pnt.y+=y;
    self.center=pnt;
}

@end

@implementation UIColor(Utility)

+(UIColor *)color255WithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:red/255 green:green/255 blue:blue/255 alpha:alpha/255];
}

@end

@implementation NSString(Utility)

-(NSString *)stringByTrimmingWhiteSpace
{
    if(self)
    {
        return [self stringByRemoveString:@" ",nil];
    }
    
    return @"";
}

-(bool)isContainString:(NSString *)string
{
    return [self rangeOfString:string].location!=NSNotFound;
}

-(bool)isMatchedByRegex:(NSString *)regex
{
    if(self && self.length>0)
    {
        NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regex options:NSRegularExpressionCaseInsensitive error:nil];
        NSUInteger regExMatches = [regEx numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])];
        
        if (regExMatches == 0)
            return NO;
        else
            return YES;
    }
    
    return false;
}

-(bool) isValidEmail
{
    if(self && self.length>1)
    {
        NSString *regExPattern = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$";
        return [self isMatchedByRegex:regExPattern];
    }
    
    return false;
}

-(bool) isValidPhone
{
    if(self && self.length>0 && self.length<20)
    {
        NSString *phone = [NSString stringWithString:self];
        NSString *string=[phone substringWithRange:NSMakeRange(0, 1)];
        NSString *regex = @"";
        
        //vietnam
        if([string isEqualToString:@"0"])
        {
            phone=[phone stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"84"];
            regex = @"^([84])[0-9]\\d{9,11}+$";
        }
        //international
        else if([string isEqualToString:@"+"])
        {
            //@"^[+][0-9]\\d{2}(-| )[0-9]+?(-| )[0-9]+?"
            regex = @"^[+][0-9]{5,20}$";
        }
        else
            regex = @"^[0-9]{5,20}$";
        
        return [phone isMatchedByRegex:regex];
    }
    
    return false;
}

-(NSString *) stringByRemoveString:(NSString *)first, ...
{
    if(!self)
        return @"";
    
    NSString *result = [NSString stringWithString:self];
    
    va_list list;
    
    va_start(list, first);
    
    for (NSString *str = first; str; str=va_arg(list, NSString*)) {
        while ([result isContainString:str]) {
            result=[result stringByReplacingOccurrencesOfString:str withString:@""];
        }
    }
    
    va_end(list);
    
    return result;
}

-(bool)isContainStrings:(NSString *)first, ...
{
    va_list list;
    va_start(list, first);
    
    for(NSString *str = first;str;str = va_arg(list, NSString*))
    {
        if([self isContainString:str])
            return true;
    }
    
    va_end(list);
    
    return false;
}

-(NSString*) deleteCharacterAtIndex:(NSUInteger) index
{
    if(self.length-1>index)
        return [self stringByReplacingCharactersInRange:NSMakeRange(index, 1) withString:@""];
    
    return self;
}

-(NSString*) deleteStringAtRange:(NSRange) range
{
    if(self.length-1>=range.location+range.length)
        return [self stringByReplacingCharactersInRange:range withString:@""];
    
    return self;
}

+(NSString *)makeString:(id)obj
{
    if(obj==nil)
        return @"";
    
    if(obj==[NSNull null])
        return @"";
    
    if([obj isKindOfClass:[NSNumber class]])
        return [NSString stringWithFormat:@"%@",obj];
    
    if([obj isKindOfClass:[NSString class]])
        return [obj copy];
    
    return @"";
}

-(NSString *)stringByAppendingStringDefault:(NSString *)aString
{
    if(aString && aString.length>0)
        return [NSString stringWithString:self];
    
    return [self stringByAppendingString:aString];
}

-(NSString *)stringByReplacingByString:(NSString *)aString withParams:(NSString *)first, ...
{
    NSString *source=[NSString makeString:self];
    va_list list;
    va_start(list, first);
    
    for(NSString *str = first;str;str = va_arg(list, NSString*))
    {
        source=[source stringByReplacingOccurrencesOfString:str withString:aString];
    }
    
    va_end(list);
    
    return source;
}

-(NSDate *)toDateWithFormat:(NSString *)format
{
    if(self.length>0)
    {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:format];
        
        return  [dateFormat dateFromString:self];
    }
    
    return nil;
}

- (NSString*)substringFrom:(NSInteger)a to:(NSInteger)b {
	NSRange r;
	r.location = a;
	r.length = b - a;
	return [self substringWithRange:r];
}

- (NSInteger)indexOf:(NSString*)substring from:(NSInteger)starts {
	NSRange r;
	r.location = starts;
	r.length = [self length] - r.location;
    
	NSRange index = [self rangeOfString:substring options:NSLiteralSearch range:r];
	if (index.location == NSNotFound) {
		return -1;
	}
	return index.location + index.length;
}

- (NSString*)trim {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)startsWith:(NSString*)s {
	if([self length] < [s length]) return NO;
	return [s isEqualToString:[self substringFrom:0 to:[s length]]];
}

-(BOOL)startsWithStrings:(NSString *)s, ...
{
    va_list list;
    va_start(list, s);
    
    for(NSString *str = s;str;str = va_arg(list, NSString*))
    {
        if([[self lowercaseString] startsWith:[str lowercaseString]])
        {
            va_end(list);
            
            return true;
        }
    }
    
    va_end(list);
    
    return false;
}

- (BOOL)containsString:(NSString *)aString
{
	NSRange range = [[self lowercaseString] rangeOfString:[aString lowercaseString]];
	return range.location != NSNotFound;
}

- (NSString *)urlEncode
{
	NSString* encodedString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                           NULL,
                                                                                           (CFStringRef) self,
                                                                                           NULL,
                                                                                           (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                           kCFStringEncodingUTF8 );
    
    encodedString=[NSString stringWithString:encodedString];
    
	return encodedString;
}

- (NSString *)sha1 {
	NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
	uint8_t digest[CC_SHA1_DIGEST_LENGTH] = {0};
	CC_SHA1(data.bytes, data.length, digest);
	NSData *d = [NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
	return [d hexString];
}

-(NSString *)ASIString
{
    NSData *data=[self dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:true];
    NSMutableString *str=[[NSMutableString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [str replaceOccurrencesOfString:@"?" withString:@"d" options:0 range:NSMakeRange(0, str.length)];
    
    return str;
}

-(NSDictionary *)jsonDictionary
{
    NSError *error=nil;
    
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&error];
    
    if(error)
        DLOG_DEBUG(@"jsonDictionary error %@",error);
    
    return dict;
}

@end

@interface TrackerObjectScrollView : NSObject
{
    void(^_onCompleted)();
}

-(void) setCompletion:(void(^)()) onCompleted;

@property (nonatomic, assign) CGPoint offset;

@end

@implementation TrackerObjectScrollView

-(void)setCompletion:(void (^)())onCompleted
{
    _onCompleted=[onCompleted copy];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    UIScrollView *scroll=object;
    
    if(CGPointEqualToPoint(scroll.contentOffset, _offset))
    {
        _onCompleted();
        _onCompleted=nil;
    }
}

@end

static char TrackerObjectScrollViewKey;
@implementation UIScrollView(Utility)

-(UIImageView *)scrollBar
{
    UIImageView *imgv=nil;
    for (id subview in [self subviews])
    {
        if ([subview isKindOfClass:[UIImageView class]])
        {
            UIImageView *imageView = (UIImageView *)subview;
            
            if (imageView.frame.size.width == 7.0f || imageView.frame.size.width == 5.0f || imageView.frame.size.width == 3.5f)
            {
                imgv=imageView;
                break;
            }
        }
    }
    
    return imgv;
}

-(int)currentPage
{
    return self.contentOffset.x / self.frame.size.width;
}

-(int)currentPageForHoriTable
{
    return (self.contentOffset.y+self.frame.size.width/2) / self.frame.size.width;
}

-(void)scrollToPage:(int)page
{
    [self scrollRectToVisible:CGRectMake(self.frame.size.width*page, 0, self.frame.size.width, self.frame.size.height) animated:true];
}

-(void)scrollToPage:(int)page animated:(bool) animated
{
    [self scrollRectToVisible:CGRectMake(self.frame.size.width*page, 0, self.frame.size.width, self.frame.size.height) animated:animated];
}

-(void)scrollToPageForHoriTable:(int)page
{
    [self scrollToPageForHoriTable:page animated:true];
}

-(void)scrollToPageForHoriTable:(int)page animated:(bool)animated
{
    [self scrollRectToVisible:CGRectMake(0, self.frame.size.width*page, self.frame.size.height, self.frame.size.width) animated:animated];
}

-(float)contentOffSetY
{
    CGPoint offset = self.contentOffset;
    CGRect bounds = self.bounds;
    UIEdgeInsets inset = self.contentInset;
    return offset.y + bounds.size.height - inset.bottom;
}

-(float)offsetYWithInsetTop
{
    return self.contentOffset.y+self.contentInset.top;
}

-(float)makeZoomScaleWithSize:(CGSize)size
{
    CGFloat widthScale = size.width / self.frame.size.width;
    CGFloat heightScale = size.height / self.frame.size.height;
    self.maximumZoomScale=MAX(MIN(widthScale, heightScale),1)*2;
    
    CGFloat zoomScale = (self.zoomScale == self.maximumZoomScale) ?
    self.minimumZoomScale : self.maximumZoomScale;
    
    return zoomScale;
}

-(void)killScroll
{
    CGPoint offset = self.contentOffset;
    offset.x -= 1.0;
    offset.y -= 1.0;
    [self setContentOffset:offset animated:NO];
    offset.x += 1.0;
    offset.y += 1.0;
    [self setContentOffset:offset animated:NO];
    
    offset = self.contentOffset;
    [self setContentOffset:offset animated:NO];
    
    self.scrollEnabled = NO;
    self.scrollEnabled = YES;
}

-(TrackerObjectScrollView*) trackerObject
{
    return objc_getAssociatedObject(self, &TrackerObjectScrollViewKey);
}

-(void) setTrackerObject:(TrackerObjectScrollView*) trackerObject
{
    objc_setAssociatedObject(self, &TrackerObjectScrollViewKey, trackerObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated completion:(void (^)())onCompleted
{
    if(CGPointEqualToPoint(contentOffset, self.contentOffset))
    {
        onCompleted();
        return;
    }
    
    if([self trackerObject])
        return;
    
    __weak UIScrollView *wSelf=self;
    
    TrackerObjectScrollView *obj=[TrackerObjectScrollView new];
    [obj setCompletion:^{
        
        if(wSelf)
        {
            wSelf.userInteractionEnabled=true;
            [wSelf removeObserver:[wSelf trackerObject] forKeyPath:@"contentOffset"];
            [wSelf setTrackerObject:nil];
            
            onCompleted();
        }
    }];
    
    [self addObserver:obj forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    [self setTrackerObject:obj];
    
    self.userInteractionEnabled=false;
    
    [self setContentOffset:contentOffset animated:animated];
}

@end



@implementation NSData(Utility)

- (NSString*)hexString
{
	NSMutableString *str = [NSMutableString stringWithCapacity:64];
	int length = [self length];
	char *bytes = malloc(sizeof(char) * length);
    
	[self getBytes:bytes length:length];
    
	int i = 0;
    
	for (; i < length; i++) {
		[str appendFormat:@"%02.2hhx", bytes[i]];
	}
	free(bytes);
    
	return str;
}

@end

@implementation UIView(Utility)

-(UIView*)childViewWithTag:(NSUInteger) childTag
{
    UIView *view=nil;
    bool isFound=false;
    for(view in self.subviews)
        if(view.tag==childTag)
        {
            isFound=true;
            break;
        }
    
    if(isFound)
        return view;
    
    return nil;
}

- (void)shake
{
    CGFloat t = 2.0;
    CGAffineTransform translateRight  = CGAffineTransformTranslate(CGAffineTransformIdentity, t, 0.0);
    CGAffineTransform translateLeft = CGAffineTransformTranslate(CGAffineTransformIdentity, -t, 0.0);
    
    self.transform = translateLeft;
    
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        self.transform = translateRight;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                self.transform = CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
}

-(void)flipLeftToRight:(float)duration
{
    CATransform3D tranform=self.layer.transform;
    
    self.layer.transform=CATransform3DMakeScale(-1, 1, 1);
    [UIView animateWithDuration:duration animations:^{
        self.layer.transform=tranform;
    }];
}

-(void) scaleToSmall:(float) duration
{
    CATransform3D tranform=self.layer.transform;
    
    self.layer.transform=CATransform3DMakeScale(1, 1.35f, 1);
    [UIView animateWithDuration:duration animations:^{
        self.layer.transform=tranform;
    }];
}

-(void)addShadow:(float)offset
{
    self.layer.masksToBounds=false;
    self.layer.shadowColor=[[UIColor blackColor] CGColor];
    self.layer.shadowOpacity=1;
    self.layer.shadowRadius=offset;
    self.layer.shadowOffset=CGSizeMake(0, 0);
    self.layer.shadowPath=[[UIBezierPath bezierPathWithRect:self.bounds] CGPath];
}

-(void)effectCornerRadius:(float)corner shadow:(float)radius
{
    self.layer.masksToBounds=true;
    self.layer.cornerRadius=corner;
    self.layer.masksToBounds=false;
    self.layer.shadowColor=[[UIColor blackColor] CGColor];
    self.layer.shadowOpacity=1;
    self.layer.shadowRadius=radius;
    self.layer.shadowOffset=CGSizeMake(0, 0);
    self.layer.shadowPath=CGPathCreateRoundRect(self.bounds, corner);
}

-(void)cornerRadiusWithRounding:(UIRectCorner)round cornerRad:(CGSize)size
{
    UIBezierPath *maskPath=[UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:round cornerRadii:size];
    
    CAShapeLayer *maskLayer=[CAShapeLayer layer];
    maskLayer.frame=self.bounds;
    maskLayer.path=maskPath.CGPath;
    self.layer.mask=maskLayer;
    self.layer.masksToBounds=false;
}

-(CGPoint)convertPoint:(CGPoint)point untilView:(UIView *)view
{
    UIView *v=self.superview;
    
    CGPoint pnt=[self convertPoint:point toView:v];
    while (v!=view) {
        pnt=[v convertPoint:pnt toView:v.superview];
        v=v.superview;
    }
    
    //    pnt=[v convertPoint:pnt toView:view];
    
    return pnt;
}

-(UIImage *)captureView
{
    UIGraphicsBeginImageContextWithOptions(self.l_v_s,false,0.0f);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end

@implementation MKUserLocation(Utility)

-(NSString *)description
{
    return [NSString stringWithFormat:@"MKUserLocation %@",NSStringFromCoordinate(self.coordinate)];
}

@end

@implementation NSDictionary(Utility)

-(int)integerForKey:(NSString *)key
{
    return [[NSNumber makeNumber:[self objectForKey:key]] integerValue];
}

-(double)doubleForKey:(NSString *)key
{
    return [[NSNumber makeNumber:[self objectForKey:key]] doubleValue];
}

-(float)floatForKey:(NSString *)key
{
    return [[NSNumber makeNumber:[self objectForKey:key]] floatValue];
}

-(bool)boolForKey:(NSString *)key
{
    return [[NSNumber makeNumber:[self objectForKey:key]] boolValue];
}

-(NSString *)makeParamsHTTPGET
{
    NSMutableArray *array=[NSMutableArray array];
    for(NSString *key in [self allKeys])
    {
        [array addObject:[NSString stringWithFormat:@"%@=%@",key,self[key]]];
    }
    
    NSString *param=[array componentsJoinedByString:@"&"];
    array=nil;
    
    return [param copy];
}

-(NSData *)json
{
    if(self.allKeys.count==0 || self.allValues.count==0)
        return nil;
    
    NSError *error=nil;
    NSData *data=[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    
    if(error)
    {
        data=nil;
        DLOG_DEBUG(@"NSDictionary json error %@ %@",error,self);
    }
    
    return data;
}

-(NSString *)jsonString
{
    NSData *data=[self json];
    
    if(data.length>0)
    {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    return @"";
}

+(NSDictionary *)makeDictionary:(id)obj
{
    if(obj==nil)
        return @{};
    
    if(obj==[NSNull null])
        return @{};
    
    if([obj isKindOfClass:[NSDictionary class]])
        return obj;
    
    return @{};
}

@end

@implementation NSURLRequest(Utility)

+(NSURLRequest *)aboutBlank
{
    return [NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]];
}

-(bool)isAboutBlank
{
    if(self.URL && [[NSString stringWithFormat:@"%@",self.URL] isEqual:@"about:blank"])
        return true;
    
    return false;
}

@end

@implementation UIImageView(Utility)

-(CGRect)imageFrame
{
    return [self imageFrameWithContentMode:self.contentMode];
}

-(CGRect)imageFrameWithContentMode:(UIViewContentMode)mode
{
    if(mode==UIViewContentModeScaleAspectFit)
    {
        CGSize imageSize = self.image.size;
        CGFloat imageScale = fminf(CGRectGetWidth(self.bounds)/imageSize.width, CGRectGetHeight(self.bounds)/imageSize.height);
        CGSize scaledImageSize = CGSizeMake(imageSize.width*imageScale, imageSize.height*imageScale);
        CGRect imageFrame = CGRectMake(roundf(0.5f*(CGRectGetWidth(self.bounds)-scaledImageSize.width)), roundf(0.5f*(CGRectGetHeight(self.bounds)-scaledImageSize.height)), roundf(scaledImageSize.width), roundf(scaledImageSize.height));
        
        return imageFrame;
    }
    
    return CGRectZero;
}

-(bool)isImageBigger
{
    return self.image.size.width>self.frame.size.width && self.image.size.height>self.frame.size.height;
}

-(bool)isImageSmaller
{
    return self.image.size.width<self.frame.size.width && self.image.size.height<self.frame.size.height;
}

@end

@implementation UIImage(Utility)

-(UIImage *)loopImage
{
    CGRect rect=CGRectZero;
    rect.size=self.size;
    
    UIGraphicsBeginImageContext(CGSizeMake([UIScreen mainScreen].bounds.size.width, self.size.height));
    
    while (rect.origin.x<[UIScreen mainScreen].bounds.size.width)
    {
        [self drawInRect:rect];
        rect.origin.x+=self.size.width;
    }
    
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

- (UIImage *) scaleToSize: (CGSize)size
{
    if(CGSizeEqualToSize(size, CGSizeZero))
        return nil;
    
    // Scalling selected image to targeted size
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CGContextClearRect(context, CGRectMake(0, 0, size.width, size.height));
    
    if(self.imageOrientation == UIImageOrientationRight)
    {
        CGContextRotateCTM(context, -M_PI_2);
        CGContextTranslateCTM(context, -size.height, 0.0f);
        CGContextDrawImage(context, CGRectMake(0, 0, size.height, size.width), self.CGImage);
    }
    else
        CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), self.CGImage);
    
    CGImageRef scaledImage=CGBitmapContextCreateImage(context);
    
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    UIImage *image = [UIImage imageWithCGImage: scaledImage];
    
    CGImageRelease(scaledImage);
    
    return image;
}

- (UIImage *) scaleProportionalToSize: (CGSize)size1
{
    if(CGSizeEqualToSize(size1, CGSizeZero))
        return nil;
    
    size1=[Utility scaleUserPoseFromSize:self.size toSize:size1];    
    return [self resizedImage:size1 interpolationQuality:kCGInterpolationHigh];
}

// Returns a copy of this image that is cropped to the given bounds.
// The bounds will be adjusted using CGRectIntegral.
// This method ignores the image's imageOrientation setting.
- (UIImage *)croppedImage:(CGRect)bounds {
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], bounds);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return croppedImage;
}

// Returns a copy of this image that is squared to the thumbnail size.
// If transparentBorder is non-zero, a transparent border of the given size will be added around the edges of the thumbnail. (Adding a transparent border of at least one pixel in size has the side-effect of antialiasing the edges of the image when rotating it using Core Animation.)
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality {
    UIImage *resizedImage = [self resizedImageWithContentMode:UIViewContentModeScaleAspectFill
                                                       bounds:CGSizeMake(thumbnailSize, thumbnailSize)
                                         interpolationQuality:quality];
    
    // Crop out any part of the image that's larger than the thumbnail size
    // The cropped rect must be centered on the resized image
    // Round the origin points so that the size isn't altered when CGRectIntegral is later invoked
    CGRect cropRect = CGRectMake(round((resizedImage.size.width - thumbnailSize) / 2),
                                 round((resizedImage.size.height - thumbnailSize) / 2),
                                 thumbnailSize,
                                 thumbnailSize);
    UIImage *croppedImage = [resizedImage croppedImage:cropRect];
    
    UIImage *transparentBorderImage = borderSize ? [croppedImage transparentBorderImage:borderSize] : croppedImage;
    
    return [transparentBorderImage roundedCornerImage:cornerRadius borderSize:borderSize];
}

// Creates a copy of this image with rounded corners
// If borderSize is non-zero, a transparent border of the given size will also be added
// Original author: BjÃ¶rn SÃ¥llarp. Used with permission. See: http://blog.sallarp.com/iphone-uiimage-round-corners/
- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize {
    // If the image does not have an alpha layer, add one
    UIImage *image = [self imageWithAlpha];
    
    // Build a context that's the same dimensions as the new size
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 image.size.width,
                                                 image.size.height,
                                                 CGImageGetBitsPerComponent(image.CGImage),
                                                 0,
                                                 CGImageGetColorSpace(image.CGImage),
                                                 CGImageGetBitmapInfo(image.CGImage));
    
    // Create a clipping path with rounded corners
    CGContextBeginPath(context);
    [self addRoundedRectToPath:CGRectMake(borderSize, borderSize, image.size.width - borderSize * 2, image.size.height - borderSize * 2)
                       context:context
                     ovalWidth:cornerSize
                    ovalHeight:cornerSize];
    CGContextClosePath(context);
    CGContextClip(context);
    
    // Draw the image to the context; the clipping path will make anything outside the rounded rect transparent
    CGContextDrawImage(context, CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage);
    
    // Create a CGImage from the context
    CGImageRef clippedImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    // Create a UIImage from the CGImage
    UIImage *roundedImage = [UIImage imageWithCGImage:clippedImage];
    CGImageRelease(clippedImage);
    
    return roundedImage;
}

#pragma mark -
#pragma mark Private helper methods

// Adds a rectangular path to the given context and rounds its corners by the given extents
// Original author: BjÃ¶rn SÃ¥llarp. Used with permission. See: http://blog.sallarp.com/iphone-uiimage-round-corners/
- (void)addRoundedRectToPath:(CGRect)rect context:(CGContextRef)context ovalWidth:(CGFloat)ovalWidth ovalHeight:(CGFloat)ovalHeight {
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    CGFloat fw = CGRectGetWidth(rect) / ovalWidth;
    CGFloat fh = CGRectGetHeight(rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

// Returns true if the image has an alpha layer
- (BOOL)hasAlpha {
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(self.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

// Returns a copy of the given image, adding an alpha channel if it doesn't already have one
- (UIImage *)imageWithAlpha {
    if ([self hasAlpha]) {
        return self;
    }
    
    CGImageRef imageRef = self.CGImage;
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    // The bitsPerComponent and bitmapInfo values are hard-coded to prevent an "unsupported parameter combination" error
    CGContextRef offscreenContext = CGBitmapContextCreate(NULL,
                                                          width,
                                                          height,
                                                          8,
                                                          0,
                                                          CGImageGetColorSpace(imageRef),
                                                          kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    
    // Draw the image into the context and retrieve the new image, which will now have an alpha layer
    CGContextDrawImage(offscreenContext, CGRectMake(0, 0, width, height), imageRef);
    CGImageRef imageRefWithAlpha = CGBitmapContextCreateImage(offscreenContext);
    UIImage *imageWithAlpha = [UIImage imageWithCGImage:imageRefWithAlpha];
    
    // Clean up
    CGContextRelease(offscreenContext);
    CGImageRelease(imageRefWithAlpha);
    
    return imageWithAlpha;
}

// Returns a copy of the image with a transparent border of the given size added around its edges.
// If the image has no alpha layer, one will be added to it.
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize {
    // If the image does not have an alpha layer, add one
    UIImage *image = [self imageWithAlpha];
    
    CGRect newRect = CGRectMake(0, 0, image.size.width + borderSize * 2, image.size.height + borderSize * 2);
    
    // Build a context that's the same dimensions as the new size
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                CGImageGetBitsPerComponent(self.CGImage),
                                                0,
                                                CGImageGetColorSpace(self.CGImage),
                                                CGImageGetBitmapInfo(self.CGImage));
    
    // Draw the image in the center of the context, leaving a gap around the edges
    CGRect imageLocation = CGRectMake(borderSize, borderSize, image.size.width, image.size.height);
    CGContextDrawImage(bitmap, imageLocation, self.CGImage);
    CGImageRef borderImageRef = CGBitmapContextCreateImage(bitmap);
    
    // Create a mask to make the border transparent, and combine it with the image
    CGImageRef maskImageRef = [self newBorderMask:borderSize size:newRect.size];
    CGImageRef transparentBorderImageRef = CGImageCreateWithMask(borderImageRef, maskImageRef);
    UIImage *transparentBorderImage = [UIImage imageWithCGImage:transparentBorderImageRef];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(borderImageRef);
    CGImageRelease(maskImageRef);
    CGImageRelease(transparentBorderImageRef);
    
    return transparentBorderImage;
}

-(UIImage *)blur
{
    return [self blurWithInputRadius:6];
}

-(UIImage *)blurWithInputRadius:(float)inputRadius
{
    // ***********If you need re-orienting (e.g. trying to blur a photo taken from the device camera front facing camera in portrait mode)
    // theImage = [self reOrientIfNeeded:theImage];
    
    // create our blurred image
    CIImage *inputImage = [CIImage imageWithCGImage:self.CGImage];
    
    // setting up Gaussian Blur (we could use one of many filters offered by Core Image)
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:inputRadius] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    // CIGaussianBlur has a tendency to shrink the image a little,
    // this ensures it matches up exactly to the bounds of our original image
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];//create a UIImage for this function to "return" so that ARC can manage the memory of the blur... ARC can't manage CGImageRefs so we need to release it before this function "returns" and ends.
    CGImageRelease(cgImage);//release CGImageRef because ARC doesn't manage this on its own.
    
    return returnImage;
}

- (UIImage *)imageWithGaussianBlur9 {
    
    const int loop=5;
    float weight[loop] = {0.2270270270, 0.1945945946, 0.1216216216, 0.0540540541, 0.0162162162};
    // Blur horizontally
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height) blendMode:kCGBlendModePlusLighter alpha:weight[0]];
    for (int x = 1; x < loop; ++x) {
        [self drawInRect:CGRectMake(x, 0, self.size.width, self.size.height) blendMode:kCGBlendModePlusLighter alpha:weight[x]];
        [self drawInRect:CGRectMake(-x, 0, self.size.width, self.size.height) blendMode:kCGBlendModePlusDarker alpha:weight[x]];
    }
    UIImage *horizBlurredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // Blur vertically
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [horizBlurredImage drawInRect:CGRectMake(0, 0, self.size.width, self.size.height) blendMode:kCGBlendModePlusLighter alpha:weight[0]];
    for (int y = 1; y < loop; ++y) {
        [horizBlurredImage drawInRect:CGRectMake(0, y, self.size.width, self.size.height) blendMode:kCGBlendModePlusLighter alpha:weight[y]];
        [horizBlurredImage drawInRect:CGRectMake(0, -y, self.size.width, self.size.height) blendMode:kCGBlendModePlusLighter alpha:weight[y]];
    }
    UIImage *blurredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //
    return blurredImage;
}

- (UIImage*)convertToGrayscale
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGRect imageRect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // Draw a white background
    CGContextSetRGBFillColor(ctx, 1.0f, 1.0f, 1.0f, 1.0f);
    CGContextFillRect(ctx, imageRect);
    
    // Draw the luminosity on top of the white background to get grayscale
    [self drawInRect:imageRect blendMode:kCGBlendModeLuminosity alpha:1.0f];
    
    // Apply the source image's alpha
    [self drawInRect:imageRect blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    
    UIImage* grayscaleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return grayscaleImage;
}

-(UIImage *)convertToServer
{
    CGSize size=self.size;
    float hdSize=207360;
    float scale=hdSize/(size.width*size.height);
    
    size.width*=scale;
    size.height*=scale;
    
    return [self resizedImage:size interpolationQuality:kCGInterpolationHigh];
}

-(UIImage *)convertAvatarToServer
{
    return [self scaleProportionalToSize:CGSizeMake(180, 180)];
}

CGFloat degreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat radiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};

- (UIImage *)imageRotatedByRadians:(CGFloat)radians {
    return [self imageRotatedByDegrees:radiansToDegrees(radians)];
}

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees {
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(degreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    // Rotate the image context
    CGContextRotateCTM(bitmap, degreesToRadians(degrees));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark -
#pragma mark Private helper methods

// Creates a mask that makes the outer edges transparent and everything else opaque
// The size must include the entire mask (opaque part + transparent border)
// The caller is responsible for releasing the returned reference by calling CGImageRelease
- (CGImageRef)newBorderMask:(NSUInteger)borderSize size:(CGSize)size {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    // Build a context that's the same dimensions as the new size
    CGContextRef maskContext = CGBitmapContextCreate(NULL,
                                                     size.width,
                                                     size.height,
                                                     8, // 8-bit grayscale
                                                     0,
                                                     colorSpace,
                                                     kCGBitmapByteOrderDefault | kCGImageAlphaNone);
    
    // Start with a mask that's entirely transparent
    CGContextSetFillColorWithColor(maskContext, [UIColor blackColor].CGColor);
    CGContextFillRect(maskContext, CGRectMake(0, 0, size.width, size.height));
    
    // Make the inner part (within the border) opaque
    CGContextSetFillColorWithColor(maskContext, [UIColor whiteColor].CGColor);
    CGContextFillRect(maskContext, CGRectMake(borderSize, borderSize, size.width - borderSize * 2, size.height - borderSize * 2));
    
    // Get an image of the context
    CGImageRef maskImageRef = CGBitmapContextCreateImage(maskContext);
    
    // Clean up
    CGContextRelease(maskContext);
    CGColorSpaceRelease(colorSpace);
    
    return maskImageRef;
}

// Returns a rescaled copy of the image, taking into account its orientation
// The image will be scaled disproportionately if necessary to fit the bounds specified by the parameter
- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality {
    BOOL drawTransposed;
    
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            drawTransposed = YES;
            break;
            
        default:
            drawTransposed = NO;
    }
    
    return [self resizedImage:newSize
                    transform:[self transformForOrientation:newSize]
               drawTransposed:drawTransposed
         interpolationQuality:quality];
}

// Resizes the image according to the given content mode, taking into account the image's orientation
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality {
    CGFloat horizontalRatio = bounds.width / self.size.width;
    CGFloat verticalRatio = bounds.height / self.size.height;
    CGFloat ratio;
    
    switch (contentMode) {
        case UIViewContentModeScaleAspectFill:
            ratio = MAX(horizontalRatio, verticalRatio);
            break;
            
        case UIViewContentModeScaleAspectFit:
            ratio = MIN(horizontalRatio, verticalRatio);
            break;
            
        default:
            [NSException raise:NSInvalidArgumentException format:@"Unsupported content mode: %d", contentMode];
    }
    
    CGSize newSize = CGSizeMake(self.size.width * ratio, self.size.height * ratio);
    
    return [self resizedImage:newSize interpolationQuality:quality];
}

#pragma mark -
#pragma mark Private helper methods

// Returns a copy of the image that has been transformed using the given affine transform and scaled to the new size
// The new image's orientation will be UIImageOrientationUp, regardless of the current image's orientation
// If the new size is not integral, it will be rounded up
- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGRect transposedRect = CGRectMake(0, 0, newRect.size.height, newRect.size.width);
    CGImageRef imageRef = self.CGImage;
    
    // Build a context that's the same dimensions as the new size
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                CGImageGetBitsPerComponent(imageRef),
                                                0,
                                                CGImageGetColorSpace(imageRef),
                                                CGImageGetBitmapInfo(imageRef));
    
    // Rotate and/or flip the image if required by its orientation
    CGContextConcatCTM(bitmap, transform);
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(bitmap, quality);
    
    // Draw into the context; this scales the image
    CGContextDrawImage(bitmap, transpose ? transposedRect : newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(newImageRef);
    
    return newImage;
}

// Returns an affine transform that takes into account the image orientation when drawing a scaled image
- (CGAffineTransform)transformForOrientation:(CGSize)newSize {
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:           // EXIF = 3
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:           // EXIF = 6
        case UIImageOrientationLeftMirrored:   // EXIF = 5
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:          // EXIF = 8
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, 0, newSize.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
            
        default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:     // EXIF = 2
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:   // EXIF = 5
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, newSize.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        default:
            break;
    }
    
    return transform;
}

@end

@implementation NSDate(Utility)

-(NSString *)stringValueWithFormat:(NSString *)format
{
    if(!format || format.length==0)
        format=@"dd-MM-yyyy";
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *strDate = [dateFormatter stringFromDate:self];
    
    return strDate;
}

-(int)year
{
    NSDateComponents *component = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self];
    return [component year];
}

-(int)month
{
    NSDateComponents *component = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit fromDate:self];
    return [component month];
}

-(int)day
{
    NSDateComponents *component = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:self];
    return [component day];
}

-(int)minute
{
    NSDateComponents *component = [[NSCalendar currentCalendar] components:NSMinuteCalendarUnit fromDate:self];
    return [component minute];
}

+(NSDate *)endDateOfYear:(int)year
{
    NSDate *curDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:curDate]; // Get necessary date components
    
    // set last of month
    [comps setYear:year];
    [comps setMonth:13];
    [comps setDay:0];
    NSDate *tDateMonth = [calendar dateFromComponents:comps];
    
    return tDateMonth;
}

-(NSDate *)toServer
{
    NSTimeZone *zone=[NSTimeZone systemTimeZone];
    return [NSDate dateWithTimeIntervalSinceNow:-zone.secondsFromGMT];
}

+(NSDate *)toClient:(NSString *)dateStr
{
    NSTimeZone *zone=[NSTimeZone systemTimeZone];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSDate *date=[dateFormat dateFromString:dateStr];
    
    return [NSDate dateWithTimeInterval:-zone.secondsFromGMT sinceDate:date];
}

@end

@implementation UIButton (Utility)

-(void)setDefaultImage:(UIImage *)defaultImage highlightImage:(UIImage *)highlightImage
{
    [self setImage:defaultImage forState:UIControlStateNormal];
    [self setImage:highlightImage forState:UIControlStateHighlighted|UIControlStateSelected];
}

-(void) sizeToFitTitle
{
    self.titleLabel.numberOfLines=0;
    [self.titleLabel sizeToFit];
    [self l_v_setS:self.titleLabel.l_v_s];
}

@end

@implementation UITextView(Utility)

-(void)setPlaceHolderText:(NSString *)str textColor:(UIColor*) color
{
    [self removePlaceHolderText];
    
    CGRect rect=self.frame;
    rect.origin=CGPointZero;
    
    float x=0;
    
    NSString *space=@"";
    while (false && x<10) {
        x=[space sizeWithFont:self.font].width;
        space=[space stringByAppendingString:@" "];
    }
    
    NSString *placeHolderText=[NSString stringWithFormat:@"%@%@",space,str];
    
    UITextView *placeholderLabel = [[UITextView alloc] initWithFrame:rect];
    [placeholderLabel setText:placeHolderText];
    // placeholderLabel is instance variable retained by view controller
    [placeholderLabel setBackgroundColor:[UIColor clearColor]];
    [placeholderLabel setFont:self.font];
    [placeholderLabel setTextColor:color];
    placeholderLabel.tag=112;
    placeholderLabel.userInteractionEnabled=false;
    placeholderLabel.editable=false;
    placeholderLabel.scrollEnabled=false;
    
    // textView is UITextView object you want add placeholder text to
    [self addSubview:placeholderLabel];
}

-(void)removePlaceHolderText
{
    while ([self viewWithTag:112]) {
        [[self viewWithTag:112] removeFromSuperview];
    }
}

@end

@implementation NSNumberFormatter(Utility)

+(NSNumberFormatter *)moneyKFormat
{
    return [NSMoneyKFormat moneyKFormat];
}

+(NSNumberFormatter *)moneyFormat
{
    NSNumberFormatter *num=[[NSNumberFormatter alloc] init];
    num.maximumFractionDigits=0;
    num.groupingSeparator=@".";
    num.groupingSize=3;
    num.usesGroupingSeparator=true;
    
    return num;
}

+(NSNumberFormatter *)numberFormat
{
    NSNumberFormatter *num=[[NSNumberFormatter alloc] init];
    num.maximumFractionDigits=0;
    num.groupingSeparator=@".";
    num.groupingSize=3;
    num.usesGroupingSeparator=true;
    
    return num;
}

+(NSString *)moneyKFromNSNumber:(NSNumber *)number
{
    return [[NSNumberFormatter moneyKFormat] stringFromNumber:number];
}

+(NSString *)moneyFromNSNumber:(NSNumber *)number
{
    return [NSString stringWithFormat:@"%@ vnđ",[[NSNumberFormatter moneyFormat] stringFromNumber:number]];
}

+(NSString *)numberFromNSNumber:(NSNumber *)number
{
    if(!number)
        return 0;
    
    return [[NSNumberFormatter numberFormat] stringFromNumber:number];
}

@end

@implementation NSMoneyKFormat

- (id)init
{
    self = [super init];
    if (self) {
        self.groupingSeparator=@".";
        self.maximumFractionDigits=0;
    }
    return self;
}

+(NSMoneyKFormat *)moneyKFormat
{
    return [[NSMoneyKFormat alloc] init];
}

-(NSString *)stringFromNumber:(NSNumber *)number
{
    if(!number)
        return @"0K vnđ";
    
    return [NSString stringWithFormat:@"%@K vnđ",[super stringFromNumber:@([number doubleValue]/1000)]];
}

@end

@implementation NSArray(Utility)

-(id)firstObject
{
    if(self.count>0)
        return [self objectAtIndex:0];
    
    return nil;
}

-(id)secondObject
{
    if(self.count>1)
        return [self objectAtIndex:1];
    
    return [self firstObject];
}

-(bool)isIndexInside:(int)index
{
    if(self.count==0 || index<0)
        return false;
    
    if(index<self.count)
        return true;
    
    return false;
}

-(NSArray*) objectsAtRange:(NSRange) range
{
    NSMutableArray *array=[NSMutableArray array];
    for(int i=range.location;i<range.location+range.length;i++)
    {
        if(i<self.count)
            [array addObject:self[i]];
    }
    
    return array;
}

+(NSArray *)makeArray:(id)obj
{
    if(obj==nil)
        return @[];
    
    if(obj==[NSNull null])
        return @[];
    
    if([obj isKindOfClass:[NSArray class]])
        return obj;
    
    return @[];
}

@end

@implementation NSNumber(Utility)

+(NSNumber *)makeNumber:(id)obj
{
    if(obj==nil)
        return @(0);
    
    if(obj==[NSNull null])
        return @(0);
    
    if([obj isKindOfClass:[NSString class]])
    {
        return @([obj floatValue]);
    }
    
    if([obj isKindOfClass:[NSNumber class]])
    {
        return [obj copy];
    }
    
    return @(0);
}

@end

@implementation Flurry(SmartGuide)

+(void)trackUserViewLogin
{
    [Flurry logEvent:@"View login"];
}

+(void)trackUserClickRequestActiveCode
{
    [Flurry logEvent:@"Request code"];
}

+(void)trackUserClickVerifyCode
{
    [Flurry logEvent:@"Verify code"];
}

+(void)trackUserClickFacebook
{
    [Flurry logEvent:@"Facebook"];
}

+(void)trackUserWaitFacebook
{
    [Flurry logEvent:@"WaitFacebook"];
}

+(void) trackUserClickFilter
{
    [Flurry logEvent:@"Filter"];
}

+(void)trackUserClickSearch
{
    [Flurry logEvent:@"Search"];
}

+(void) trackUserClickMap
{
    [Flurry logEvent:@"Map"];
}

+(void)trackUserClickCollection
{
    [Flurry logEvent:@"Collection"];
}

+(void)trackUserHideAppWhenLogin
{
    [Flurry logEvent:@"Hide app login"];
}

+(void)trackUserViewTutorialEnd
{
    [Flurry logEvent:@"TutorialEnd"];
}

+(void)trackUserClickTutorial
{
    [Flurry logEvent:@"Tutorial"];
}

+(void) trackUserSearch:(NSString*) key
{
    NSString *str=@"";
    if(key!=nil)
        str=key;
    
    NSDictionary *dict=[NSDictionary dictionaryWithObject:str forKey:@"key"];
    
    [Flurry logEvent:@"SearchKey" withParameters:dict];
}

+(void)trackUserAllowLocation:(CLLocationCoordinate2D)location
{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    
    [dict setObject:@(location.latitude) forKey:@"lat"];
    [dict setObject:@(location.longitude) forKey:@"lon"];
    
    [Flurry logEvent:@"location" withParameters:dict];
}

+(void)trackUserSkipFacebook
{
    [Flurry logEvent:@"skipFace"];
}

@end

@implementation NSObject(Utility)

-(bool)hasData
{
    if(self==nil)
        return false;
    
    if((id)self==[NSNull null])
        return false;
    
    if([self isKindOfClass:[NSArray class]])
    {
        NSArray *data=(NSArray*)self;
        if(data.count==0)
            return false;
    }
    else if([self isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dict=(NSDictionary*)self;
        if(dict.count==0)
            return false;
    }
    else if([self isKindOfClass:[NSString class]])
    {
        NSString *str=(NSString*) self;
        
        if(str.length==0)
            return false;
    }
    
    return true;
}

-(bool)isNullData
{
    if(!self)
        return true;
    
    if((id)self==[NSNull null])
        return true;
    
    if([self isKindOfClass:[NSArray class]])
    {
        NSArray *data=(NSArray*)self;
        if(data.count==0 || [data[0] isNullData])
            return true;
    }
    else if([self isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dict=(NSDictionary*)self;
        if(dict.count==0)
            return true;
    }
    
    return false;
}

-(bool)isHasString
{
    if(!self)
        return false;
    
    if([self isKindOfClass:[NSNull class]])
        return false;
    
    if([self isKindOfClass:[NSString class]])
    {
        return [((NSString*)self) length]>0;
    }
    
    return false;
}

@end

@implementation NSFileManager(Utility)

-(NSString*)makeDirectory:(NSString *)path
{
    NSString *docPath=[documentPath() stringByAppendingPathComponent:path];
    
    if(![self fileExistsAtPath:docPath])
        [self createDirectoryAtPath:docPath withIntermediateDirectories:true attributes:nil error:nil];
    
    return docPath;
}

-(NSString *)avatarsPath
{
    return [self makeDirectory:@"Avatars"];
}

@end

@implementation NSIndexPath(Utility)

-(NSString *)description
{
    return [NSString stringWithFormat:@"indexPath section %i row %i",self.section,self.row];
}

@end

@implementation UICollectionView(Utility)

-(CGRect) rectForItemAtIndexPath:(NSIndexPath*) indexPath
{
    return [self layoutAttributesForItemAtIndexPath:indexPath].frame;
}

-(UICollectionViewFlowLayout *)collectionViewFlowLayout
{
    return (UICollectionViewFlowLayout*)self.collectionViewLayout;
}

-(void)reloadVisibleItems
{
    if(self.visibleCells && self.visibleCells.count>0)
    {
        NSMutableArray *array=[NSMutableArray array];
        
        for(UICollectionViewCell *cell in self.visibleCells)
        {
            NSIndexPath *idx=[self indexPathForCell:cell];
            if(idx)
                [array addObject:idx];
        }
        
        if(array.count>0)
        {
            [self reloadItemsAtIndexPaths:array];
        }
    }
}

-(CGRect)rectForSection:(int)section
{
    CGRect rect=CGRectZero;
    if(section<=[self numberOfSections]-1)
    {
        int itemCount=[self numberOfItemsInSection:section];
        
        if(itemCount>0)
        {
            for(int i=0;i<itemCount;i++)
            {
                CGRect itemRect=[self rectForItemAtIndexPath:makeIndexPath(i, section)];
                if(CGPointEqualToPoint(rect.origin, CGPointZero))
                    rect.origin=itemRect.origin;
                
                if(itemRect.size.width>rect.size.width)
                    rect.size.width=itemRect.size.width;
                
                rect.size.height+=itemRect.size.height;
            }
        }
    }
    
    return rect;
}

@end

@implementation UIDevice(Utility)

- (NSString *)platformRawString {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

@end

@implementation UITableView(Utility)

-(bool) isCellCompletionVisibility:(NSIndexPath *) indexPath
{
    CGRect cellRect=[self convertRect:[self rectForRowAtIndexPath:indexPath] toView:self.superview];
    
    return CGRectContainsRect(self.frame, cellRect);
}

-(UIView *)showLoadingBelowSection:(int)section
{
    CGRect rect=[self rectForSection:section];
    rect.origin.y+=rect.size.height;
    rect.size.height=MAX(self.l_v_h,self.l_cs_h)-rect.size.height;
    
    [self showLoadingInsideFrame:rect];
    
    return self.loadingView;
}

-(UIView*) showLoadingBelowIndexPath:(NSIndexPath*) indexPath
{
    CGRect rect=[self rectForRowAtIndexPath:indexPath];
    rect.origin.y+=rect.size.height;
    
    if(MAX(self.l_v_h, self.l_cs_h)>rect.size.height)
        rect.size.height=MAX(self.l_v_h,self.l_cs_h)-rect.size.height+1;
    else
        rect.size.height=0;
    
    [self showLoadingInsideFrame:rect];
    
    return self.loadingView;
}

-(UIView *)showLoadingBelowIndexPath:(NSIndexPath *)indexPath alpha:(float)alpha
{
    CGRect rect=[self rectForRowAtIndexPath:indexPath];
    rect.origin.y+=rect.size.height;
    
    if(MAX(self.l_v_h, self.l_cs_h)>rect.size.height)
        rect.size.height=MAX(self.l_v_h,self.l_cs_h)-rect.size.height+1;
    else
        rect.size.height=0;
    
    [self showLoadingInsideFrame:rect];
    self.loadingView.backgroundView.alpha=alpha;
    
    return self.loadingView;
}

-(UITableViewCell *)emptyCell
{
    DLOG_DEBUG(@"emptyCell");
    
    UITableViewCell *cell=[self dequeueReusableCellWithIdentifier:@"emptyCell"];
    
    if(!cell)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"emptyCell"];
        cell.backgroundColor=[UIColor clearColor];
        cell.contentView.backgroundColor=[UIColor clearColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled=false;
        cell.contentView.userInteractionEnabled=false;
        cell.autoresizesSubviews=false;
        cell.contentView.autoresizesSubviews=false;
        cell.clipsToBounds=false;
        cell.contentView.clipsToBounds=false;
    }
    
    return cell;
}

-(enum CELL_POSITION)getCellPosition:(NSIndexPath *)indexPath
{
    return [self getCellPosition:indexPath numberOfRowInSection:[self numberOfRowsInSection:indexPath.section]];
}

-(enum CELL_POSITION)getCellPosition:(NSIndexPath *)indexPath numberOfRowInSection:(NSUInteger)numberOfRow
{
    enum CELL_POSITION cellPos=CELL_POSITION_MIDDLE;
    
    if(indexPath.row==numberOfRow-1)
        cellPos=CELL_POSITION_BOTTOM;
    else if(indexPath.row==0)
        cellPos=CELL_POSITION_TOP;
    
    return cellPos;
}

@end

@implementation NSMutableParagraphStyle(Utility)

+(NSMutableParagraphStyle*) paraStyleWithTextAlign:(NSTextAlignment) textAlign
{
    NSMutableParagraphStyle *obj=[NSMutableParagraphStyle new];
    
    obj.alignment=textAlign;
    obj.lineBreakMode=NSLineBreakByTruncatingTail;
    
    return obj;
}

+(NSMutableParagraphStyle *)paraStyleJustified
{
    return [NSMutableParagraphStyle paraStyleWithTextAlign:NSTextAlignmentJustified];
}

@end

@implementation UITableView(ReloadAnimation)

-(void)beginUpdatesAnimationWithDuration:(float)duration
{
    [UIView beginAnimations:@"UITableView+ReloadAnimation" context:nil];
    [UIView setAnimationDuration:duration];
    [CATransaction begin];
    [self beginUpdates];
}

-(void) performUpdateWithAction:(void (^)())action completion:(void (^)())completed
{
    [CATransaction setCompletionBlock:completed];
    
    if(action)
        action();
}

-(void)endUpdatesAnimation
{
    [self endUpdates];
    [CATransaction commit];
    [UIView commitAnimations];
}

@end

@implementation UILabel(Utility)

-(void)sizeToFitDisableAnimation
{
    bool isAnimationEnabled=[UIView areAnimationsEnabled];
    [UIView setAnimationsEnabled:false];
    [self sizeToFit];
    [UIView setAnimationsEnabled:isAnimationEnabled];
}

@end

@implementation MKMapView(Utility)

#define MERCATOR_OFFSET 268435456
#define MERCATOR_RADIUS 85445659.44705395

#pragma mark -
#pragma mark Map conversion methods

- (double)longitudeToPixelSpaceX:(double)longitude
{
    return round(MERCATOR_OFFSET + MERCATOR_RADIUS * longitude * M_PI / 180.0);
}

- (double)latitudeToPixelSpaceY:(double)latitude
{
    return round(MERCATOR_OFFSET - MERCATOR_RADIUS * logf((1 + sinf(latitude * M_PI / 180.0)) / (1 - sinf(latitude * M_PI / 180.0))) / 2.0);
}

- (double)pixelSpaceXToLongitude:(double)pixelX
{
    return ((round(pixelX) - MERCATOR_OFFSET) / MERCATOR_RADIUS) * 180.0 / M_PI;
}

- (double)pixelSpaceYToLatitude:(double)pixelY
{
    return (M_PI / 2.0 - 2.0 * atan(exp((round(pixelY) - MERCATOR_OFFSET) / MERCATOR_RADIUS))) * 180.0 / M_PI;
}

#pragma mark -
#pragma mark Helper methods

- (MKCoordinateSpan)coordinateSpanWithMapView:(MKMapView *)mapView
                             centerCoordinate:(CLLocationCoordinate2D)centerCoordinate
                                 andZoomLevel:(NSUInteger)zoomLevel
{
    // convert center coordiate to pixel space
    double centerPixelX = [self longitudeToPixelSpaceX:centerCoordinate.longitude];
    double centerPixelY = [self latitudeToPixelSpaceY:centerCoordinate.latitude];
    
    // determine the scale value from the zoom level
    NSInteger zoomExponent = 20 - zoomLevel;
    double zoomScale = pow(2, zoomExponent);
    
    // scale the map’s size in pixel space
    CGSize mapSizeInPixels = mapView.bounds.size;
    double scaledMapWidth = mapSizeInPixels.width * zoomScale;
    double scaledMapHeight = mapSizeInPixels.height * zoomScale;
    
    // figure out the position of the top-left pixel
    double topLeftPixelX = centerPixelX - (scaledMapWidth / 2);
    double topLeftPixelY = centerPixelY - (scaledMapHeight / 2);
    
    // find delta between left and right longitudes
    CLLocationDegrees minLng = [self pixelSpaceXToLongitude:topLeftPixelX];
    CLLocationDegrees maxLng = [self pixelSpaceXToLongitude:topLeftPixelX + scaledMapWidth];
    CLLocationDegrees longitudeDelta = maxLng - minLng;
    
    // find delta between top and bottom latitudes
    CLLocationDegrees minLat = [self pixelSpaceYToLatitude:topLeftPixelY];
    CLLocationDegrees maxLat = [self pixelSpaceYToLatitude:topLeftPixelY + scaledMapHeight];
    CLLocationDegrees latitudeDelta = -1 * (maxLat - minLat);
    
    // create and return the lat/lng span
    MKCoordinateSpan span = MKCoordinateSpanMake(latitudeDelta, longitudeDelta);
    return span;
}

#pragma mark -
#pragma mark Public methods

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated
{
    // clamp large numbers to 28
    zoomLevel = MIN(zoomLevel, 28);
    
    // use the zoom level to compute the region
    MKCoordinateSpan span = [self coordinateSpanWithMapView:self centerCoordinate:centerCoordinate andZoomLevel:zoomLevel];
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, span);
    
    // set the region like normal
    [self setRegion:region animated:animated];
}

-(void)zoomToFitCoordinates:(NSArray *)array zoomLevel:(NSUInteger)zoomLevel animate:(BOOL)animate
{
    if(array.count==0)
        return;
    
    CLLocationDegrees maxLat = -90.0f;
	CLLocationDegrees maxLon = -180.0f;
	CLLocationDegrees minLat = 90.0f;
	CLLocationDegrees minLon = 180.0f;
    
    for(NSValue *value in array)
    {
        CLLocationCoordinate2D coordinate=[value MKCoordinateValue];
        
        CLLocationCoordinate2D currentLocation=coordinate;
        if(currentLocation.latitude>maxLat)
            maxLat=currentLocation.latitude;
        if(currentLocation.latitude<minLat)
            minLat=currentLocation.latitude;
        if(currentLocation.longitude>maxLon)
            maxLon=currentLocation.longitude;
        if(currentLocation.longitude<minLon)
            minLon=currentLocation.longitude;
    }
    
	MKCoordinateRegion region;
    //    CLLocationCoordinate2D location=CLLocationCoordinate2DMake((maxLat + minLat) / 2, (maxLon + minLon) / 2);
	region.center.latitude     = (maxLat + minLat) / 2;
	region.center.longitude    = (maxLon + minLon) / 2;
	region.span.latitudeDelta  = maxLat - minLat;
	region.span.longitudeDelta = maxLon - minLon;
    
    MKCoordinateSpan span=[self coordinateSpanWithMapView:self centerCoordinate:region.center andZoomLevel:zoomLevel];
    double miles = (span.latitudeDelta+span.longitudeDelta)/2 * 0.000621371f;
    double scalingFactor = ABS( (cos(2 * M_PI * region.center.latitude / 360.0) ));
    
    region.span=MKCoordinateSpanMake(miles/69, miles/(scalingFactor*69));
    
	[self setRegion:region animated:animate];
}

-(void)zoomToFitAnnotations:(NSArray *)annotations zoomLevel:(NSUInteger)zoomLevel animate:(BOOL)animate
{
    if(annotations.count==0)
        return;
    
    NSMutableArray *array=[NSMutableArray array];
    
    for(id<MKAnnotation> ann in annotations)
        [array addObject:[NSValue valueWithMKCoordinate:[ann coordinate]]];
    
    [self zoomToFitCoordinates:array zoomLevel:zoomLevel animate:animate];
}

@end