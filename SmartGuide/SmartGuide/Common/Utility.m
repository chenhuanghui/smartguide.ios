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
#import "NSBKeyframeAnimationFunctions.h"

NSString* NSStringFromCoordinate(CLLocationCoordinate2D coordinate)
{
    return [NSString stringWithFormat:@"coordinate latitude %f longitude %f",coordinate.latitude,coordinate.longitude];
}

NSString* NSStringFromColor(UIColor* color)
{
    if(color)
    {
        float r,g,b,a;
        [color getRed:&r green:&g blue:&b alpha:&a];
        return [NSString stringWithFormat:@"color %f %f %f %f",r,g,b,a];
    }
    return @"";
}

CGRect CGRectWithOrigin(CGRect rect, CGPoint pnt)
{
    rect.origin=pnt;
    return rect;
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
    if(url.length>0 && [url isContainString:@"/"])
    {
        int index=[url rangeOfString:@"/" options:NSBackwardsSearch].location;
        return [[url substringWithRange:NSMakeRange(index+1, url.length-index-1)] integerValue];
    }
    
    return -1;
}

+(CGSize)scaleProportionallyFromSize:(CGSize)fSize toSize:(CGSize)tSize
{
    if(fSize.width==fSize.height)
    {
        while (fSize.width<MIN(tSize.width, tSize.height)) {
            fSize.width++;
            fSize.height++;
        }
        return fSize;
    }
    
    if(fSize.width>tSize.width&&fSize.height>tSize.height)
    {
        return [Utility scaleProportionallyFromSize:tSize toSize:fSize];
    }
    
    if(fSize.width>fSize.height)
    {
        float oldWitdh=fSize.width;
        float scaleFactor=tSize.width/oldWitdh;
        
        return CGSizeMake(oldWitdh*scaleFactor, fSize.height*scaleFactor);
    }
    else
    {
        float oldHeight=fSize.height;
        float scaleFactor=tSize.height/oldHeight;
        
        return CGSizeMake(fSize.width*scaleFactor, oldHeight*scaleFactor);
    }
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

+(NSString*)stringWithStringDefault:(NSString *)string
{
    if((id)string==[NSNull null])
        return @"";
    
    if(string && string.length>0)
        return [NSString stringWithString:string];
    
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
    NSString *source=[NSString stringWithStringDefault:self];
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

@end

@implementation UIScrollView(Utility)

-(int)currentPage
{
    return self.contentOffset.x / self.frame.size.width;
}

-(int)currentPageForHoriTable
{
    return self.contentOffset.y / self.frame.size.width;
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
    self.layer.shadowRadius=10;
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
    self.layer.shouldRasterize=true;
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
    self.layer.shouldRasterize=true;
}

@end

@implementation MKUserLocation(Utility)

-(NSString *)description
{
    return [NSString stringWithFormat:@"MKUserLocation %@",NSStringFromCoordinate(self.coordinate)];
}

@end

@implementation UIAlertView(Utility)

-(void)setEnableOKButton:(bool)isEnabled
{
    for(id obj in self.subviews)
    {
        if([obj isKindOfClass:[UIButton class]])
        {
            UIButton *btn = obj;
            
            int buttonIndex=0;
            
            if([btn.titleLabel.text isEqualToString:[self buttonTitleAtIndex:buttonIndex]])
            {
                btn.enabled=isEnabled;
            }
            else
                btn.enabled=true;
        }
    }
}

-(UILabel *)lblTitle
{
    for(id obj in self.subviews)
    {
        if([obj isKindOfClass:[UILabel class]])
        {
            UILabel *lbl = obj;
            if([lbl.text isEqualToString:self.title])
                return lbl;
        }
    }
    
    return nil;
}

-(UILabel *)lblMessage
{
    for(id obj in self.subviews)
    {
        if([obj isKindOfClass:[UILabel class]])
        {
            UILabel *lbl = obj;
            if([lbl.text isEqualToString:self.message])
                return lbl;
        }
    }
    
    return nil;
}

-(UIButton *)buttonWithTitle:(NSString *)title
{
    for(id obj in self.subviews)
    {
        if([obj isKindOfClass:[UIButton class]])
        {
            UIButton *btn = obj;
            if([btn.titleLabel.text isEqualToString:title])
                return btn;
        }
    }
    
    return nil;
}

-(void)fireButtonWithTitle:(NSString *)title
{
    UIButton *btn = [self buttonWithTitle:title];
    
    if(btn)
        [btn sendActionsForControlEvents:UIControlEventTouchUpInside];
    else
        NSLog(@"btn %@ not found",title);
}

-(UIImageView *)backgroundView
{
    for(id obj in self.subviews)
    {
        if([obj isKindOfClass:[UIImageView class]])
        {
            return obj;
        }
    }
    
    return nil;
}

-(void)setBackground:(UIColor *)color
{
    //    UIImage *img=[UIImage imageNamed:@"navigationbar background.png"];
    //    img=[img stretchableImageWithLeftCapWidth:16 topCapHeight:16];
    //
    //    UIGraphicsBeginImageContext([self backgroundView].frame.size);
    //    [img drawInRect:CGRectMake(0, 0, [self backgroundView].frame.size.width, [self backgroundView].frame.size.height)];
    //    img=UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //
    //    [[self backgroundView].layer setContents:[img CGImage]];
    //    [self backgroundView].layer.masksToBounds=true;
    //    [self backgroundView].layer.cornerRadius=16;
}

-(void)setMessageTextColor:(UIColor *)color
{
    UILabel *lbl=[self lblMessage];
    if(lbl)
        [lbl setTextColor:color];
}

@end

@implementation NSDictionary(Utility)

-(int)integerForKey:(NSString *)key
{
    return [[self objectForKey:key] integerValue];
}

-(double)doubleForKey:(NSString *)key
{
    return [[self objectForKey:key] doubleValue];
}

-(float)floatForKey:(NSString *)key
{
    return [[self objectForKey:key] floatValue];
}

-(bool)boolForKey:(NSString *)key
{
    return [[self objectForKey:key] boolValue];
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
    // Scalling selected image to targeted size
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
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
    if(self.size.width>self.size.height)
    {
        NSLog(@"LandScape");
        size1=CGSizeMake((self.size.width/self.size.height)*size1.height,size1.height);
    }
    else
    {
        NSLog(@"Potrait");
        size1=CGSizeMake(size1.width,(self.size.height/self.size.width)*size1.width);
    }
    
    return [self scaleToSize:size1];
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
@dynamic hitTestEdgeInsets;

static const NSString *KEY_HIT_TEST_EDGE_INSETS = @"HitTestEdgeInsets";

-(void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = [NSValue value:&hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS);
    if(value) {
        UIEdgeInsets edgeInsets; [value getValue:&edgeInsets]; return edgeInsets;
    }else {
        return UIEdgeInsetsZero;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if(UIEdgeInsetsEqualToEdgeInsets(self.hitTestEdgeInsets, UIEdgeInsetsZero) ||       !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    
    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.hitTestEdgeInsets);
    
    return CGRectContainsPoint(hitFrame, point);
}

@end

@implementation UILabel(Utility)

-(void) stopAnimationScore
{
    UILabel *lbl=(UILabel*)[self viewWithTag:909];
    
    if(lbl)
        self.text=lbl.text;;
    [lbl removeFromSuperview];
    
    [self finishAnimationScore];
}

-(void)animationScoreWithDuration:(float)duration startValue:(int)startValue endValue:(int)endValue format:(NSNumberFormatter *)format
{
    NSUInteger steps = (NSUInteger)ceil(60 * duration) + 2;
	
	NSMutableArray *valueArray = [NSMutableArray arrayWithCapacity:steps];
    
    const double increment = 1.0 / (double)(steps - 1);
    
    float progress = 0.0;
    float v = 0.0;
    double value = 0.0;
    
    NSBKeyframeAnimationFunction f=NSBKeyframeAnimationFunctionEaseOutQuad;
    
    NSUInteger i;
    for (i = 0; i < steps; i++)
    {
        v =  f(duration * progress * 1000, 0, 1, duration * 1000);
        
        value = startValue + v * (endValue - startValue);
        value = startValue+value;
        value=ceilf(value);
        
        [valueArray addObject:[format stringFromNumber:@(value)]];
        
        progress += increment;
    }
    
    // trick to animation score
    int aTag=909;
    
    UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectZero];
    lbl.text=[format stringFromNumber:@(endValue)];
    lbl.tag=aTag;
    lbl.hidden=true;
    [self addSubview:lbl];
    
    [self scoreAnimation:valueArray steps:steps/1000 tempView:lbl];
    
    self.alpha=0.3f;
    [UIView animateWithDuration:duration animations:^{
        self.alpha=1;
    } completion:nil];
}

-(void) scoreAnimation:(NSMutableArray*) array steps:(float) steps tempView:(UIView*) v
{
    if(array.count==0 || ![self viewWithTag:909])
    {
        [self finishAnimationScore];
        return;
    }
    
    [UIView animateWithDuration:steps animations:^{
        self.text=[array objectAtIndex:0];
        [array removeObjectAtIndex:0];
        v.alpha=0;
    } completion:^(BOOL finished) {
        if(finished)
        {
            v.alpha=1;
            [self scoreAnimation:array steps:steps tempView:v];
        }
    }];
}

-(void) finishAnimationScore
{
    UILabel *lbl=(UILabel*)[self viewWithTag:909];
    if(lbl)
    {
        self.text=lbl.text;
        [lbl removeFromSuperview];
    }
    
    self.alpha=1;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SCORE_FINISHED object:nil];
}

@end

@implementation UITextView(Utility)

-(void)setPlaceHolderText:(NSString *)str
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
    [placeholderLabel setTextColor:[UIColor lightGrayColor]];
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

+(NSNumberFormatter *)moneyFormat
{
    return [NSMoneyFormat moneyFormat];
}

+(NSNumberFormatter *)numberFormat
{
    NSNumberFormatter *num=[[NSNumberFormatter alloc] init];
    num.maximumFractionDigits=0;
    num.groupingSeparator=@".";
    
    return num;
}

+(NSString *)moneyFromNSNumber:(NSNumber *)number
{
    return [[NSNumberFormatter moneyFormat] stringFromNumber:number];
}

+(NSString *)numberFromNSNumber:(NSNumber *)number
{
    if(!number)
        return 0;
    
    return [[NSNumberFormatter numberFormat] stringFromNumber:number];
}

@end

@implementation NSMoneyFormat

- (id)init
{
    self = [super init];
    if (self) {
        self.groupingSeparator=@".";
        self.maximumFractionDigits=0;
    }
    return self;
}

+(NSMoneyFormat *)moneyFormat
{
    return [[NSMoneyFormat alloc] init];
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

@end

@implementation NSNumber(Utility)

+(id)numberWithObject:(id)obj
{
    if(obj==[NSNull null] || [obj isKindOfClass:[NSNull class]] || !obj)
    {
        return @(0);
    }
    
    return obj;
}

@end