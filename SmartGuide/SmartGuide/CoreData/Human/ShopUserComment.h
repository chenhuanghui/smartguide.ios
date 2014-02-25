#import "_ShopUserComment.h"
#import "Constant.h"

@interface ShopUserComment : _ShopUserComment 
{
}

+(ShopUserComment*) commentWithIDComment:(int) idComment;
+(ShopUserComment*) makeWithJSON:(NSDictionary*) data;

-(enum AGREE_STATUS) enumAgreeStatus;

-(Shop*) shop;

@property (nonatomic, assign) float commentHeight;
@property (nonatomic, assign) float cellCommentHeight;

@end
