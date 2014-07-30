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
    
    obj.logo=[NSString makeString:dict[@"logo"]];
    obj.brandName=[NSString makeString:dict[@"brandName"]];
    obj.title=[NSString makeString:dict[@"title"]];
    obj.desc=[NSString makeString:dict[@"description"]];
    obj.date=[NSString makeString:dict[@"date"]];
    obj.cover=[NSString makeString:dict[@"cover"]];
    obj.goTo=[NSString makeString:dict[@"goTo"]];
    obj.type=[NSNumber makeNumber:dict[@"type"]];
    obj.coverHeight=[NSNumber makeNumber:dict[@"coverHeight"]];
    obj.coverWidth=[NSNumber makeNumber:dict[@"coverWidth"]];
    
    switch (obj.promotionType) {
        case USER_PROMOTION_BRAND:
            obj.idShops=[NSString makeString:dict[@"idShops"]];
            break;
            
        case USER_PROMOTION_SHOP:
            obj.idShop=[NSNumber makeNumber:dict[@"idShop"]];
            break;
            
        case USER_PROMOTION_STORE:
            obj.idStore=[NSNumber makeNumber:dict[@"idStore"]];
            break;
            
        case USER_PROMOTION_ITEM_STORE:
            obj.idStore=[NSNumber makeNumber:dict[@"idStore"]];
            obj.idItem=[NSNumber makeNumber:dict[@"idItem"]];
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
