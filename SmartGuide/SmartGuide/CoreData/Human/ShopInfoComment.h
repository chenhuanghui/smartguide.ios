#import "_ShopInfoComment.h"
#import "Enums.h"

@interface ShopInfoComment : _ShopInfoComment 
{
}

+(ShopInfoComment*) makeWithData:(NSDictionary*) data;
-(enum COMMENT_AGREE_STATUS) enumAgreeStatus;

@end
