#import "ShopInfoComment.h"

@implementation ShopInfoComment

+(ShopInfoComment *)makeWithData:(NSDictionary *)data
{
    ShopInfoComment *obj=[ShopInfoComment insert];
    
    obj.idComment=[NSNumber makeNumber:data[@"idComment"]];;
    obj.username=[NSString makeString:data[@"username"]];
    obj.comment=[NSString makeString:data[@"comment"]];
    obj.avatar=[NSString makeString:data[@"avatar"]];
    obj.numOfAgree=[NSString stringWithString:data[@"numOfAgree"]];
    obj.totalAgree=[NSNumber makeNumber:data[@"totalAgree"]];
    obj.time=[NSString makeString:data[@"time"]];
    obj.agreeStatus=[NSNumber makeNumber:data[@"agreeStatus"]];
    
    return obj;

}

-(enum COMMENT_AGREE_STATUS)enumAgreeStatus
{
    switch ((enum COMMENT_AGREE_STATUS)self.agreeStatus.integerValue) {
        case COMMENT_AGREE_STATUS_NONE:
            return COMMENT_AGREE_STATUS_NONE;
            
        case COMMENT_AGREE_STATUS_AGREED:
            return COMMENT_AGREE_STATUS_AGREED;
    }
    
    return COMMENT_AGREE_STATUS_NONE;
}

@end
