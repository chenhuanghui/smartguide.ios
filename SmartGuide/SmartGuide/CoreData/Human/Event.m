#import "Event.h"

@implementation Event
@synthesize titleRect,contentRect,nameRect,descRect;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    self.titleRect=CGRectZero;
    self.contentRect=CGRectZero;
    self.nameRect=CGRectZero;
    self.descRect=CGRectZero;
    
    return self;
}

+(Event *)makeWithData:(NSDictionary *)dict
{
    Event *obj=[Event insert];
    
    obj.logo=[NSString makeString:dict[@"logo"]];
    obj.brandName=[NSString makeString:dict[@"brandName"]];
    obj.title=[NSString makeString:dict[@"title"]];
    obj.desc=[NSString makeString:dict[@"description"]];
    obj.date=[NSString makeString:dict[@"date"]];
    obj.cover=[NSString makeString:dict[@"cover"]];
    obj.coverWidth=[NSNumber makeNumber:dict[@"coverWidth"]];
    obj.coverHeight=[NSNumber makeNumber:dict[@"coverHeight"]];
    obj.goTo=[NSString makeString:dict[@"goTo"]];
    obj.type=[NSNumber makeNumber:dict[@"type"]];
    
    switch (obj.enumType) {
        case EVENT_TYPE_SHOP:
            obj.idShop=[NSNumber makeNumber:dict[@"idShop"]];
            obj.shopLat=[NSNumber makeNumber:dict[@"shopLat"]];
            obj.shopLng=[NSNumber makeNumber:dict[@"shopLng"]];
            break;
            
        case EVENT_TYPE_BRAND:
            obj.idShops=[NSString makeString:dict[@"idShops"]];
            break;
            
        case EVENT_TYPE_UNKNOW:
            break;
    }
    
    return obj;
}

-(enum EVENT_TYPE)enumType
{
    switch ((enum EVENT_TYPE)self.type.integerValue) {
        case EVENT_TYPE_BRAND:
            return EVENT_TYPE_BRAND;
            
        case EVENT_TYPE_SHOP:
            return EVENT_TYPE_SHOP;
            
        case EVENT_TYPE_UNKNOW:
            return EVENT_TYPE_UNKNOW;
    }
    
    return EVENT_TYPE_UNKNOW;
}

@end
