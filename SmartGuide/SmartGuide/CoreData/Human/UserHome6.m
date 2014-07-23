#import "UserHome6.h"
#import "Utility.h"

@implementation UserHome6
@synthesize homeSize,contentAttribute;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];

    self.homeSize=CGSizeZero;
    
    return self;
}

+(UserHome6 *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome6 *home=[UserHome6 insert];
    
    int idShop=[[NSNumber numberWithObject:dict[@"idShop"]] integerValue];
    
    home.shop=[Shop shopWithIDShop:idShop];
    
    if(!home.shop)
    {
        home.shop=[Shop insert];
        home.shop.idShop=@(idShop);
        home.shop.dataMode=@(SHOP_DATA_HOME_6);
    }

    home.shop.logo=[NSString stringWithStringDefault:dict[@"logo"]];
    
    home.shopName=[NSString stringWithStringDefault:dict[@"shopName"]];
    home.date=[NSString stringWithStringDefault:dict[@"date"]];
    home.cover=[NSString stringWithStringDefault:dict[@"cover"]];
    home.title=[NSString stringWithStringDefault:dict[@"title"]];
    home.content=[NSString stringWithStringDefault:dict[@"content"]];
    home.gotoshop=[NSString stringWithStringDefault:dict[@"goto"]];
    home.coverHeight=[NSNumber numberWithObject:dict[@"coverHeight"]];
    home.coverWidth=[NSNumber numberWithObject:dict[@"coverWidth"]];
    
    return home;
}

-(void)setCoverHeight:(NSNumber *)coverHeight
{
    if(coverHeight.floatValue==0)
        coverHeight=@(0);
    
    [super setCoverHeight:coverHeight];
}

-(void)setCoverWidth:(NSNumber *)coverWidth
{
    if(coverWidth.floatValue==0)
        coverWidth=@(0);
    
    [super setCoverWidth:coverWidth];
}

-(NSNumber *)idShop
{
    return self.shop.idShop;
}

-(NSString *)logo
{
    return self.shop.logo;
}

@end
