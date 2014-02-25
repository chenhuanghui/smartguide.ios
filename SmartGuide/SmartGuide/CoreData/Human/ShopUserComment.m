#import "ShopUserComment.h"
#import "Utility.h"

@implementation ShopUserComment
@synthesize commentHeight,cellCommentHeight;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    commentHeight=-1;
    cellCommentHeight=-1;
    
    return self;
}

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
    obj.totalAgree=[NSNumber numberWithObject:data[@"totalAgree"]];
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

-(Shop *)shop
{
    if(self.shopTime)
        return self.shopTime;
    
    return self.shopTime;
}

@end
