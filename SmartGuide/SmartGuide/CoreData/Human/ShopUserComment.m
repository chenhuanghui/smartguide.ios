#import "ShopUserComment.h"
#import "Utility.h"

@implementation ShopUserComment

+(ShopUserComment *)commentWithIDComment:(int)idComment
{
    return [ShopUserComment queryShopUserCommentObject:[NSPredicate predicateWithFormat:@"%K == %i",ShopUserComment_IdComment,idComment]];
}

+(ShopUserComment *)makeWithJSON:(NSDictionary *)data
{
    int idComment=[[NSNumber numberWithObject:data[@"idComment"]] integerValue];
    ShopUserComment *obj=[ShopUserComment commentWithIDComment:idComment];
    
    if(!obj)
    {
        obj=[ShopUserComment insert];
        obj.idComment=@(idComment);
    }
    
    obj.username=[NSString stringWithStringDefault:data[@"username"]];
    obj.comment=[NSString stringWithStringDefault:data[@"comment"]];
    obj.avatar=[NSString stringWithStringDefault:data[@"avatar"]];
    obj.numOfAgree=[NSString stringWithString:data[@"numOfAgree"]];
    obj.time=[NSString stringWithStringDefault:data[@"time"]];
    obj.agreeStatus=[NSNumber numberWithObject:data[@"agreeStatus"]];
    
    return obj;
}

-(enum AGREE_STATUS)enumAgreeStatus
{
    switch (self.agreeStatus.integerValue) {
        case 0:
            return AGREE_STATUS_NONE;
            
        case 1:
            return AGREE_STATUS_AGREED;
            
        default:
            return AGREE_STATUS_NONE;
    }
}

@end
