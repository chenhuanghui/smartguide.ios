#import "ShopCatalog.h"

@implementation ShopCatalog

+(ShopCatalog *)catalogWithIDCatalog:(int)idCatalog
{
    return [ShopCatalog queryShopCatalogObject:[NSPredicate predicateWithFormat:@"%K == %i",ShopCatalog_IdCatalog,idCatalog]];
}

-(bool)isActived
{
    return self.count && self.count.integerValue>0;
}

+(NSArray *)allObjects
{
    NSArray *array=[super allObjects];
    
    if(array.count>0)
        return [array sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:ShopCatalog_Name ascending:true]]];
    
    return array;
}

-(NSString *)imageName
{
    switch (self.idCatalog.integerValue) {
            
        case 1:
            return @"icon12.png";
            
        case 2:
            return @"icon13.png";
            
        case 3:
            return @"icon14.png";
            
        case 4:
            return @"icon15.png";
            
        case 5:
            return @"icon16.png";
            
        case 6:
            return @"icon17.png";
            
        case 7:
            return @"icon18.png";
            
        case 8:
            return @"icon19.png";
            
        default:
            return @"icon14.png";
    }
}

+(ShopCatalog *)all
{
    ShopCatalog *group=[ShopCatalog catalogWithIDCatalog:0];
    
    if(!group)
    {
        ShopCatalog *groupAll=[ShopCatalog temporary];
        groupAll.name=@"Tất cả";
        groupAll.idCatalog=@(0);
        groupAll.count=0;
        
        return groupAll;
    }
    
    return group;
}

+(ShopCatalog *)food
{
    return [ShopCatalog catalogWithIDCatalog:1];
}

+(ShopCatalog *)drink
{
    return [ShopCatalog catalogWithIDCatalog:2];
}

+(ShopCatalog *)health
{
    return [ShopCatalog catalogWithIDCatalog:3];
}

+(ShopCatalog *)entertaiment
{
    return [ShopCatalog catalogWithIDCatalog:4];
}

+(ShopCatalog *)fashion
{
    return [ShopCatalog catalogWithIDCatalog:5];
}

+(ShopCatalog *)travel
{
    return [ShopCatalog catalogWithIDCatalog:6];
}

+(ShopCatalog *)production
{
    return [ShopCatalog catalogWithIDCatalog:7];
}

+(ShopCatalog *)education
{
    return [ShopCatalog catalogWithIDCatalog:8];
}

-(NSString *)key
{
    if(self.idCatalog.integerValue==0)
        return @"1,2,3,4,5,6,7,8";
    
    return [NSString stringWithFormat:@"%i",self.idCatalog.integerValue];
}

-(UIImage *)iconPin
{
    switch (self.idCatalog.integerValue) {
        case 1:
            return [UIImage imageNamed:@"iconpin_food.png"];
            
        case 2:
            return [UIImage imageNamed:@"iconpin_drink.png"];
            
        case 3:
            return [UIImage imageNamed:@"iconpin_healness.png"];
            
        case 4:
            return [UIImage imageNamed:@"iconpin_entertaiment.png"];
            
        case 5:
            return [UIImage imageNamed:@"iconpin_fashion.png"];
            
        case 6:
            return [UIImage imageNamed:@"iconpin_travel.png"];
            
        case 7:
            return [UIImage imageNamed:@"iconpin_shopping.png"];
            
        case 8:
            return [UIImage imageNamed:@"iconpin_education.png"];
            
        default:
            return nil;
    }
}

@end
