#import "UserPromotion.h"
#import "Utility.h"

@implementation UserPromotion
@synthesize homeSize,contentAttribute;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    self.homeSize=CGSizeZero;
    
    return self;
}

+(UserPromotion *)makeWithDictionary:(NSDictionary *)dict
{
    UserPromotion *obj=[UserPromotion insert];
    
    obj.logo=[NSString stringWithStringDefault:dict[@"logo"]];
    obj.brandName=[NSString stringWithStringDefault:dict[@"brandName"]];
    obj.title=[NSString stringWithStringDefault:dict[@"title"]];
    obj.desc=[NSString stringWithStringDefault:dict[@"description"]];
    obj.date=[NSString stringWithStringDefault:dict[@"date"]];
    obj.cover=[NSString stringWithStringDefault:dict[@"cover"]];
    obj.goTo=[NSString stringWithStringDefault:dict[@"goTo"]];
    obj.type=[NSNumber numberWithObject:dict[@"type"]];
    obj.coverHeight=[NSNumber numberWithObject:dict[@"coverHeight"]];
    obj.coverWidth=[NSNumber numberWithObject:dict[@"coverWidth"]];
    
    switch (obj.promotionType) {
        case USER_PROMOTION_BRAND:
            obj.idShops=[NSString stringWithStringDefault:dict[@"idShops"]];
            break;
            
        case USER_PROMOTION_SHOP:
            obj.idShop=[NSNumber numberWithObject:dict[@"idShop"]];
            break;
            
        case USER_PROMOTION_STORE:
            obj.idStore=[NSNumber numberWithObject:dict[@"idStore"]];
            break;
            
        case USER_PROMOTION_ITEM_STORE:
            obj.idStore=[NSNumber numberWithObject:dict[@"idStore"]];
            obj.idItem=[NSNumber numberWithObject:dict[@"idItem"]];
            break;
            
        case USER_PROMOTION_UNKNOW:
            break;
    }
    
    return obj;
}

-(enum USER_PROMOTION_TYPE)promotionType
{
    switch (self.type.integerValue) {
        case USER_PROMOTION_BRAND:
            return USER_PROMOTION_BRAND;
            
        case USER_PROMOTION_SHOP:
            return USER_PROMOTION_SHOP;
            
        case USER_PROMOTION_STORE:
            return USER_PROMOTION_STORE;
            
        case USER_PROMOTION_ITEM_STORE:
            return USER_PROMOTION_ITEM_STORE;
            
        default:
            return USER_PROMOTION_UNKNOW;
    }
}

+(NSArray *)allObjects
{
    NSArray *array=[super allObjects];
    
    if(array.count>0)
        return [array sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:UserPromotion_SortOrder ascending:false]]];
    
    return array;
}

@end
