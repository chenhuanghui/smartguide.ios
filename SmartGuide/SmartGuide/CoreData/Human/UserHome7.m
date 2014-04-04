#import "UserHome7.h"
#import "Utility.h"

@implementation UserHome7
@synthesize contentHeight,titleHeight,homeSize;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    self.contentHeight=-1;
    self.titleHeight=-1;
    
    return self;
}

+(UserHome7 *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome7 *home=[UserHome7 insert];
    
    home.store=[StoreShop makeWithDictionary:dict[@"storeInfo"]];

    home.date=[NSString stringWithStringDefault:dict[@"date"]];
    home.cover=[NSString stringWithStringDefault:dict[@"cover"]];
    home.title=[NSString stringWithStringDefault:dict[@"title"]];
    home.content=[NSString stringWithStringDefault:dict[@"content"]];
    home.gotostore=[NSString stringWithStringDefault:dict[@"goto"]];
    home.coverHeight=[NSNumber numberWithObject:dict[@"coverHeight"]];
    home.coverWidth=[NSNumber numberWithObject:dict[@"coverWidth"]];
    
    float fixWidth=296;
    home.homeSize=CGSizeMake(fixWidth, MAX(0,fixWidth*home.coverHeight.floatValue/home.coverWidth.floatValue));
    
    return home;
}

-(NSString *)storeName
{
    return self.store.storeName;
}

@end
