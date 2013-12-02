//
//  Utility.h
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Flurry.h"

#define IS_IPHONE_4 ([UIScreen mainScreen].bounds.size.height==480)
#define IS_RETINA ([UIScreen mainScreen].scale==2)

#define CGRECT_PHONE(rectIP4,rectIP5) (IS_IPHONE_4?rectIP4:rectIP5)
#define CGPOINT_PHONE(pntIP4,pntIP5) (IS_IPHONE_4?pntIP4:pntIP5)
#define WIDTH_PHONE(wIP4,wIP5) (IS_IPHONE_4?wIP4:wIP5)
#define HEIGHT_PHONE(hIP4,hIP5) (IS_IPHONE_4?hIP4:hIP5)
#define X_PHONE(xIP4,xIP5) (IS_IPHONE_4?xIP4:xIP5)
#define Y_PHONE(yIP4,yIP5) (IS_IPHONE_4?yIP4:yIP5)
#define NIB_PHONE(nibName) (IS_IPHONE_4?nibName:[nibName stringByAppendingString:@"_ip5"])
#define OBJ_IOS(ios6,ios7) (NSFoundationVersionNumber>NSFoundationVersionNumber_iOS_6_1?ios7:ios6)

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RANDOM(min,max) arc4random() % (max - min) + min
#define CGPOINT_X(cgpnt,px) CGPointMake(px,cgpnt.y)
#define CGPOINT_Y(cgpnt,py) CGPointMake(cgpnt.x,py)
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

NSString* NSStringFromCoordinate(CLLocationCoordinate2D coordinate);
CGPathRef CGPathCreateRoundRect( const CGRect r, const CGFloat cornerRadius );
NSString* NSStringFromColor(UIColor* color);
CGRect CGRectWithOrigin(CGRect rect, CGPoint pnt);
bool isVailCLLocationCoordinate2D(CLLocationCoordinate2D location);
void makePhoneCall(NSString* phone);
int random_int(int from, int to);

@interface Utility : NSObject

+(CGRect) centerPinWithFrameAnnotation:(CGRect) rectAnn framePin:(CGRect) rectPin;
+(NSArray*) ftCoreTextFormatScoreStyle;
+(NSArray*) ftCoreTextFormatScoreMapStyle;
+(NSArray*) ftCoreTextFormatScoreListStyle;
+(NSString*) ftCoreTextFormatScore:(NSString*) score rank:(NSString*) rank;
+(NSMutableArray *)decodePolyLine:(NSMutableString *)encoded;
+(NSString*) documentPath;
+(int) idShopFromQRCode:(NSString*) qrCode;
+(CGSize) scaleProportionallyFromSize:(CGSize) fSize toSize:(CGSize) tSize;
+(CGSize)scaleUserPoseFromSize:(CGSize)fSize toSize:(CGSize)tSize;
+(CGPoint) centerRect:(CGRect) rect;

@end

@interface UIViewController(Utility)

-(UIBarButtonItem*) itemWithImage:(UIImage*) image sel:(SEL) selector;

@end

@interface UIViewController(lazy_method)

//view x,y
-(CGSize) l_v_s;
-(CGPoint) l_v_o;
-(float) l_v_x;
-(float) l_v_y;
-(void) l_v_setO:(CGPoint) xy;
-(void) l_v_addO:(CGPoint) xy;
-(void) l_v_setX:(float) x;
-(void) l_v_setY:(float) y;
-(void) l_v_addX:(float) x;
-(void) l_v_addY:(float) y;
//view width, height
-(float) l_v_w;
-(float) l_v_h;
-(void) l_v_setS:(CGSize) wh;
-(void) l_v_addS:(CGSize) wh;
-(void) l_v_setW:(float) w;
-(void) l_v_setH:(float) h;
-(void) l_v_addW:(float) w;
-(void) l_v_addH:(float) h;

//view center
-(CGPoint) l_c;
-(float) l_c_x;
-(float) l_c_y;
-(void) l_c_setXY:(CGPoint) xy;
-(void) l_c_addXY:(CGPoint) xy;
-(void) l_c_setX:(float) x;
-(void) l_c_setY:(float) y;
-(void) l_c_addX:(float) x;
-(void) l_c_addY:(float) y;

@end

@interface UIView(lazy_method)

//view x,y
-(CGPoint) l_v_o;
-(float) l_v_x;
-(float) l_v_y;
-(void) l_v_setO:(CGPoint) xy;
-(void) l_v_addO:(CGPoint) xy;
-(void) l_v_setX:(float) x;
-(void) l_v_setY:(float) y;
-(void) l_v_addX:(float) x;
-(void) l_v_addY:(float) y;
//view width, height
-(CGSize) l_v_s;
-(float) l_v_w;
-(float) l_v_h;
-(void) l_v_setS:(CGSize) wh;
-(void) l_v_addS:(CGSize) wh;
-(void) l_v_setW:(float) w;
-(void) l_v_setH:(float) h;
-(void) l_v_addW:(float) w;
-(void) l_v_addH:(float) h;

//view center
-(CGPoint) l_c;
-(float) l_c_x;
-(float) l_c_y;
-(void) l_c_setXY:(CGPoint) xy;
-(void) l_c_addXY:(CGPoint) xy;
-(void) l_c_setX:(float) x;
-(void) l_c_setY:(float) y;
-(void) l_c_addX:(float) x;
-(void) l_c_addY:(float) y;

@end

@interface UIColor(Utility)

+(UIColor *)color255WithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

@end

@interface NSString(Utility)

+(NSString*)stringWithStringDefault:(NSString *)string;
-(NSString*) stringByTrimmingWhiteSpace;
-(bool) isContainString:(NSString*) string;
-(bool) isMatchedByRegex:(NSString*) regex;
-(bool) isValidEmail;
-(bool) isValidPhone;
-(NSString*) stringByRemoveString:(NSString*) first,...;
-(bool) isContainStrings:(NSString *)first,...;
-(NSString*) stringByAppendingStringDefault:(NSString *)aString;
-(NSString*) stringByReplacingByString:(NSString*) aString withParams:(NSString*) first,...;
-(NSDate*) toDateWithFormat:(NSString*) format;
-(NSString*) substringFrom:(NSInteger)a to:(NSInteger)b;
-(NSInteger) indexOf:(NSString*)substring from:(NSInteger)starts;
-(NSString*) trim;
-(BOOL) startsWith:(NSString*)s;
-(BOOL) containsString:(NSString*)aString;
-(NSString*) urlEncode;
-(NSString*) sha1;

@end

@interface UIScrollView(Utility)

-(UIImageView*) scrollBar;
-(int) currentPage;
-(int) currentPageForHoriTable;
-(void) scrollToPage:(int) page;
-(void) scrollToPage:(int) page animated:(bool) animated;
-(void) scrollToPageForHoriTable:(int) page;
-(void) scrollToPageForHoriTable:(int)page animated:(bool) animated;

@end

@interface NSDate(Utility)

-(NSString*) stringValueWithFormat:(NSString*) format;
-(int) year;
-(int) month;
-(int) day;
-(int) minute;

-(NSDate*) toServer;
+(NSDate*) toClient:(NSString*) dateStr;

@end

@interface NSData(Utility)

- (NSString*)hexString;

@end

@interface UIView(Utility)

-(void) shake;
-(void) flipLeftToRight:(float) duration;
-(void) scaleToSmall:(float) duration;
-(void) addShadow:(float) offset;
-(void) effectCornerRadius:(float) corner shadow:(float) radius;
-(void) cornerRadiusWithRounding:(UIRectCorner) round cornerRad:(CGSize) size;
-(UIView*) childViewWithTag:(NSUInteger) childTag;
-(CGPoint)convertPoint:(CGPoint)point untilView:(UIView *)view;

@end

@interface UIAlertView(Utility)

-(void) setEnableOKButton:(bool) isEnabled;
-(void) fireButtonWithTitle:(NSString*) title;
-(UILabel*) lblTitle;
-(UILabel*) lblMessage;
-(UIButton*) buttonWithTitle:(NSString*) title;
-(UIImageView*) backgroundView;
-(void) setBackground:(UIColor*) color;
-(void) setMessageTextColor:(UIColor*) color;

@end

@interface NSDictionary(Utility)

-(int) integerForKey:(NSString*) key;
-(double) doubleForKey:(NSString*) key;
-(float) floatForKey:(NSString*) key;
-(bool) boolForKey:(NSString*) key;

@end
@interface NSURLRequest(Utility)

-(bool) isAboutBlank;
+(NSURLRequest*) aboutBlank;

@end

@interface UIImage(Utility)

-(UIImage*) loopImage;
- (UIImage *) scaleToSize: (CGSize)size;
- (UIImage *) scaleProportionalToSize: (CGSize)size1;
- (UIImage *)croppedImage:(CGRect)bounds;
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;
- (BOOL)hasAlpha;
- (UIImage *)imageWithAlpha;
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;

@end

@interface UIButton (Utility)

@property(nonatomic, assign) UIEdgeInsets hitTestEdgeInsets;

@end

@interface UILabel(Utility)

-(void) animationScoreWithDuration:(float) duration startValue:(int) startValue endValue:(int) endValue format:(NSNumberFormatter*) format;
-(void) stopAnimationScore;
-(void) startFlashLabel;
-(void) stopFlashLabel;

@end

@interface UITextView(Utility)

-(void) setPlaceHolderText:(NSString*) str textColor:(UIColor*) color;
-(void) removePlaceHolderText;

@end

@interface NSNumberFormatter(Utility)

+(NSNumberFormatter*) moneyKFormat;
+(NSNumberFormatter*) moneyFormat;
+(NSNumberFormatter*) numberFormat;

+(NSString*) moneyFromNSNumber:(NSNumber*) number;
+(NSString*) moneyKFromNSNumber:(NSNumber*) number;
+(NSString*) numberFromNSNumber:(NSNumber*) number;

@end

@interface NSMoneyKFormat : NSNumberFormatter

+(NSMoneyKFormat*) moneyKFormat;

@end

@interface NSArray(Utility)

-(id) firstObject;
-(id) secondObject;//neu ko thi se chuyen ve firstObject

@end

@interface NSNumber(Utility)

+(id) numberWithObject:(id) obj;

@end

@interface Flurry(SmartGuide)

+(void) trackUserViewLogin;
+(void) trackUserClickRequestActiveCode;
+(void) trackUserClickVerifyCode;
+(void) trackUserClickFacebook;
+(void) trackUserWaitFacebook;
+(void) trackUserClickFilter;
+(void) trackUserClickSearch;
+(void) trackUserClickMap;
+(void) trackUserClickCollection;
+(void) trackUserHideAppWhenLogin;
+(void) trackUserViewTutorialEnd;
+(void) trackUserClickTutorial;
+(void) trackUserSearch:(NSString*) key;
+(void) trackUserAllowLocation:(CLLocationCoordinate2D) location;
+(void) trackUserSkipFacebook;

@end

@interface NSObject(Utility)

-(bool) isNullData;

@end