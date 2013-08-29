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

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RANDOM(min,max) arc4random() % (max - min) + min

NSString* NSStringFromCoordinate(CLLocationCoordinate2D coordinate);
CGPathRef CGPathCreateRoundRect( const CGRect r, const CGFloat cornerRadius );
NSString* NSStringFromColor(UIColor* color);
CGRect CGRectWithOrigin(CGRect rect, CGPoint pnt);
bool isVailCLLocationCoordinate2D(CLLocationCoordinate2D location);

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
-(void)cornerRadiusWithRounding:(UIRectCorner) round cornerRad:(CGSize) size;

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

+(NSNumberFormatter*) moneyFormat;
+(NSNumberFormatter*) numberFormat;

+(NSString*) moneyFromNSNumber:(NSNumber*) number;
+(NSString*) numberFromNSNumber:(NSNumber*) number;

@end

@interface NSMoneyFormat : NSNumberFormatter

+(NSMoneyFormat*) moneyFormat;

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

@end