#import "ShopUserComment.h"
#import "Utility.h"

@implementation ShopUserComment
@synthesize commentHeight;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    self.commentHeight=@(-1);
    
    return self;
}

+(ShopUserComment *)commentWithIDComment:(int)idComment
{
    return [ShopUserComment queryShopUserCommentObject:[NSPredicate predicateWithFormat:@"%K == %i",ShopUserComment_IdComment,idComment]];
}

+(ShopUserComment *)makeWithJSON:(NSDictionary *)data
{
    int idComment=[[NSNumber makeNumber:data[@"idComment"]] integerValue];
    ShopUserComment *obj=[ShopUserComment commentWithIDComment:idComment];
    
    if(!obj)
    {
        obj=[ShopUserComment insert];
        obj.idComment=@(idComment);
    }
    
    obj.username=[NSString makeString:data[@"username"]];
    obj.comment=[NSString makeString:data[@"comment"]];
    obj.avatar=[NSString makeString:data[@"avatar"]];
    obj.numOfAgree=[NSString stringWithString:data[@"numOfAgree"]];
    obj.totalAgree=[NSNumber makeNumber:data[@"totalAgree"]];
    obj.time=[NSString makeString:data[@"time"]];
    obj.agreeStatus=[NSNumber makeNumber:data[@"agreeStatus"]];
    
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

-(Shop *)shop
{
    if(self.shopTime)
        return self.shopTime;
    
    return self.shopTop;
}

@end
