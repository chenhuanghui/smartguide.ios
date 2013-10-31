#import "_ShopCatalog.h"

@interface ShopCatalog : _ShopCatalog 
{
}

+(ShopCatalog*) catalogWithIDCatalog:(int) idCatalog;
+(ShopCatalog*) all;
+(ShopCatalog*) food;
+(ShopCatalog*) drink;
+(ShopCatalog*) health;
+(ShopCatalog*) entertaiment;
+(ShopCatalog*) fashion;
+(ShopCatalog*) travel;
+(ShopCatalog*) production;
+(ShopCatalog*) education;

-(NSString*) key;

-(NSString*) imageName;
-(bool) isActived;

-(UIImage*) iconPin;

@end
