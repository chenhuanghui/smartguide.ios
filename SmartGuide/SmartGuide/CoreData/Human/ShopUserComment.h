#import "_ShopUserComment.h"
#import "Constant.h"

@interface ShopUserComment : _ShopUserComment 
{
}

+(ShopUserComment*) commentWithIDComment:(int) idComment;
+(ShopUserComment*) makeWithJSON:(NSDictionary*) data;

-(enum AGREE_STATUS) enumAgreeStatus;

@end
