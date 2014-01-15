#import "UserPlacelist.h"
#import "Utility.h"

@implementation UserPlacelist
@synthesize arrayIDShops;

+(UserPlacelist *)userPlacelistWithIDPlacelist:(int)idPlace
{
    return [UserPlacelist queryUserPlacelistObject:[NSPredicate predicateWithFormat:@"%K == %i",UserPlacelist_IdPlacelist,idPlace]];
}

+(UserPlacelist *)makeWithDictionary:(NSDictionary *)dict
{
    int idPlacelist=[[NSNumber numberWithObject:dict[@"idPlacelist"]] integerValue];
    
    UserPlacelist *obj = [UserPlacelist userPlacelistWithIDPlacelist:idPlacelist];
    
    if(!obj)
    {
        obj=[UserPlacelist insert];
        obj.idPlacelist=@(idPlacelist);
        obj.isTicked=@(false);
    }
    
    obj.name=[NSString stringWithStringDefault:dict[@"name"]];
    obj.numOfShop=[NSString stringWithStringDefault:dict[@"numOfShop"]];
    obj.idShops=[NSString stringWithStringDefault:dict[@"idShops"]];
    
    return obj;
}

-(void)setIdShops:(NSString *)idShops
{
    [super setIdShops:idShops];
    
    if(self.idShops.length>0)
    {
        arrayIDShops=[[self.idShops componentsSeparatedByString:@","] copy];
    }
    else
        arrayIDShops=[[NSArray alloc] init];
}

@end
