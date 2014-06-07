#import "Shop.h"
#import "Utility.h"
#import "Constant.h"

@implementation Shop
@synthesize descHeight,shopNameHeight,addressHeight,kmNewsHeight;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    self.shopLat=[NSNumber numberWithDouble:-1];
    self.shopLng=[NSNumber numberWithDouble:-1];
    self.kmNewsHeight=@(-1);
    
    _dragCoord=CLLocationCoordinate2DMake(-1, -1);
    
    return self;
}

+(Shop *)shopWithIDShop:(int)idShop
{
    return [Shop queryShopObject:[NSPredicate predicateWithFormat:@"%K == %i",Shop_IdShop,idShop]];
}

+(Shop *)makeWithIDShop:(int)idShop
{
    Shop *shop=[Shop shopWithIDShop:idShop];
    
    if(!shop)
    {
        shop=[Shop insert];
        shop.idShop=@(idShop);
        shop.dataMode=@(SHOP_DATA_IDSHOP);
    }
    
    return shop;
}

-(CLLocationCoordinate2D)coordinate
{
    if(isVailCLLocationCoordinate2D(_dragCoord))
        return _dragCoord;
    
    return CLLocationCoordinate2DMake(self.shopLat.doubleValue, self.shopLng.doubleValue);
}

+(Shop *)makeShopWithDictionary:(NSDictionary *)dict
{
    int idShop=[[NSNumber numberWithObject:dict[@"idShop"]] integerValue];
    
    Shop *shop=[Shop shopWithIDShop:idShop];
    
    if(!shop)
    {
        shop=[Shop insert];
        shop.idShop=@(idShop);
    }
    
    [shop removeAllTimeComments];
    [shop removeAllTopComments];
    [shop removeAllUserGalleries];
    [shop removeAllShopGalleries];
    shop.km1=nil;
    shop.km2=nil;
    
    shop.dataMode=@(SHOP_DATA_FULL);
    
    shop.shopName=[NSString stringWithStringDefault:dict[@"shopName"]];
    shop.shopType=[NSNumber numberWithObject:dict[@"shopType"]];
    shop.shopLat=[NSNumber numberWithObject:dict[@"shopLat"]];
    shop.shopLng=[NSNumber numberWithObject:dict[@"shopLng"]];
    shop.logo=[NSString stringWithStringDefault:dict[@"logo"]];
    shop.loveStatus=[NSNumber numberWithObject:dict[@"loveStatus"]];
    shop.numOfLove=[NSString stringWithStringDefault:dict[@"numOfLove"]];
    shop.totalLove=[NSNumber numberWithObject:dict[@"totalLove"]];
    shop.numOfView=[NSString stringWithStringDefault:dict[@"numOfView"]];
    shop.numOfComment=[NSString stringWithStringDefault:dict[@"numOfComment"]];
    shop.totalComment=[NSNumber numberWithObject:dict[@"totalComment"]];
    shop.address=[NSString stringWithStringDefault:dict[@"address"]];
    shop.city=[NSString stringWithStringDefault:dict[@"city"]];
    shop.tel=[NSString stringWithStringDefault:dict[@"tel"]];
    shop.displayTel=[NSString stringWithStringDefault:dict[@"displayTel"]];
    shop.desc=[NSString stringWithStringDefault:dict[@"description"]];
    shop.promotionType=[NSNumber numberWithObject:dict[@"promotionType"]];
    
    NSArray *array=dict[@"shopGallery"];
    
    if(![array isNullData])
    {
        int i=0;
        for(NSDictionary *gallery in array)
        {
            ShopGallery *sg=[ShopGallery makeWithJSON:gallery];
            sg.sortOrder=@(i++);
            
            [shop addShopGalleriesObject:sg];
        }
    }
    
    array=dict[@"userGallery"];
    
    if(![array isNullData])
    {
        int i=0;
        
        for(NSDictionary *userGallery in array)
        {
            ShopUserGallery *su = [ShopUserGallery makeWithJSON:userGallery];
            su.sortOrder=@(i++);
            
            [shop addUserGalleriesObject:su];
        }
    }
    
    array=dict[@"comments"];
    
    if(![array isNullData])
    {
        int i=0;
        
        for(NSDictionary *comment in array)
        {
            ShopUserComment *obj = [ShopUserComment makeWithJSON:comment];
            
            obj.sortOrder=@(i++);
            
            [shop addTopCommentsObject:obj];
        }
    }
    
    switch (shop.enumPromotionType) {
        case SHOP_PROMOTION_NONE:
            
            break;
            
        case SHOP_PROMOTION_KM1:
            
            if([dict[@"promotionDetail"] isNullData])
                shop.promotionType=@(SHOP_PROMOTION_NONE);
            else
                shop.km1=[ShopKM1 makeWithJSON:dict[@"promotionDetail"]];
            
            break;
            
        case SHOP_PROMOTION_KM2:
            
            if([dict[@"promotionDetail"] isNullData])
                shop.promotionType=@(SHOP_PROMOTION_NONE);
            else
                shop.km2=[ShopKM2 makeWithDictionary:dict[@"promotionDetail"]];
            
            break;
    }
    
    [shop removeAllPromotionNew];
    
    array=dict[@"promotionNews"];
    
    int count=0;
    for(NSDictionary *kmNew in array)
    {
        PromotionNews *km=[PromotionNews makeWithDictionary:kmNew];
        km.sortOrder=@(count++);
        
        [shop addPromotionNewObject:km];
    }
    
//    PromotionNews *proNews=[PromotionNews makeWithDictionary:dict[@"promotionNews"]];
//    proNews.sortOrder=@(0);
//    proNews.video=@"http://r6---sn-a8au-co5e.googlevideo.com/videoplayback?expire=1402083205&sver=3&source=youtube&id=o-ABepgfksTi2pNtrLL5a41KLXJ2hFefr8soWuJXrtn1zW&upn=G9-pKKMxnOo&mt=1402059822&itag=22&ipbits=0&ratebypass=yes&mv=m&signature=3588CB4B93B442E1FD1EA3F7391F6C8E0C1D7802.D8F666D73EC13EB02C9933930A4AFDF8AFB44C57&sparams=id%2Cip%2Cipbits%2Citag%2Cratebypass%2Csource%2Cupn%2Cexpire&fexp=904722%2C912301%2C913434%2C914073%2C923341%2C930008%2C931327%2C932106%2C932617%2C945533&mws=yes&ms=au&ip=2607%3A5300%3A60%3A513c%3A%3A34&key=yt5&signature=&title=Video";
//    proNews.videoHeight=@(420);
//    proNews.videoWidth=@(960);
//    proNews.videoThumbnail=@"http://www.menucool.com/slider/prod/image-slider-5.jpg";
//    
//    [shop addPromotionNewObject:proNews];
//    
//    proNews=[PromotionNews makeWithDictionary:dict[@"promotionNews"]];
//    proNews.sortOrder=@(1);
//    
//    [shop addPromotionNewObject:proNews];
//    
//    proNews=[PromotionNews makeWithDictionary:dict[@"promotionNews"]];
//    proNews.sortOrder=@(2);
//    proNews.video=@"http://r6---sn-a8au-co5e.googlevideo.com/videoplayback?expire=1402083205&sver=3&source=youtube&id=o-ABepgfksTi2pNtrLL5a41KLXJ2hFefr8soWuJXrtn1zW&upn=G9-pKKMxnOo&mt=1402059822&itag=22&ipbits=0&ratebypass=yes&mv=m&signature=3588CB4B93B442E1FD1EA3F7391F6C8E0C1D7802.D8F666D73EC13EB02C9933930A4AFDF8AFB44C57&sparams=id%2Cip%2Cipbits%2Citag%2Cratebypass%2Csource%2Cupn%2Cexpire&fexp=904722%2C912301%2C913434%2C914073%2C923341%2C930008%2C931327%2C932106%2C932617%2C945533&mws=yes&ms=au&ip=2607%3A5300%3A60%3A513c%3A%3A34&key=yt5&signature=&title=Video";
//    proNews.videoHeight=@(420);
//    proNews.videoWidth=@(960);
//    proNews.videoThumbnail=@"http://www.menucool.com/slider/prod/image-slider-5.jpg";
//    
//    [shop addPromotionNewObject:proNews];
//    
//    proNews=[PromotionNews makeWithDictionary:dict[@"promotionNews"]];
//    proNews.sortOrder=@(3);
//    proNews.video=@"http://r6---sn-a8au-co5e.googlevideo.com/videoplayback?expire=1402083205&sver=3&source=youtube&id=o-ABepgfksTi2pNtrLL5a41KLXJ2hFefr8soWuJXrtn1zW&upn=G9-pKKMxnOo&mt=1402059822&itag=22&ipbits=0&ratebypass=yes&mv=m&signature=3588CB4B93B442E1FD1EA3F7391F6C8E0C1D7802.D8F666D73EC13EB02C9933930A4AFDF8AFB44C57&sparams=id%2Cip%2Cipbits%2Citag%2Cratebypass%2Csource%2Cupn%2Cexpire&fexp=904722%2C912301%2C913434%2C914073%2C923341%2C930008%2C931327%2C932106%2C932617%2C945533&mws=yes&ms=au&ip=2607%3A5300%3A60%3A513c%3A%3A34&key=yt5&signature=&title=Video";
//    proNews.videoHeight=@(420);
//    proNews.videoWidth=@(960);
//    proNews.videoThumbnail=@"http://www.menucool.com/slider/prod/image-slider-5.jpg";
//    
//    [shop addPromotionNewObject:proNews];
//    
//    proNews=[PromotionNews makeWithDictionary:dict[@"promotionNews"]];
//    proNews.sortOrder=@(4);
//    
//    [shop addPromotionNewObject:proNews];
//    
//    proNews=[PromotionNews makeWithDictionary:dict[@"promotionNews"]];
//    proNews.sortOrder=@(5);
//    proNews.video=@"http://r6---sn-a8au-co5e.googlevideo.com/videoplayback?expire=1402083205&sver=3&source=youtube&id=o-ABepgfksTi2pNtrLL5a41KLXJ2hFefr8soWuJXrtn1zW&upn=G9-pKKMxnOo&mt=1402059822&itag=22&ipbits=0&ratebypass=yes&mv=m&signature=3588CB4B93B442E1FD1EA3F7391F6C8E0C1D7802.D8F666D73EC13EB02C9933930A4AFDF8AFB44C57&sparams=id%2Cip%2Cipbits%2Citag%2Cratebypass%2Csource%2Cupn%2Cexpire&fexp=904722%2C912301%2C913434%2C914073%2C923341%2C930008%2C931327%2C932106%2C932617%2C945533&mws=yes&ms=au&ip=2607%3A5300%3A60%3A513c%3A%3A34&key=yt5&signature=&title=Video";
//    proNews.videoHeight=@(420);
//    proNews.videoWidth=@(960);
//    proNews.videoThumbnail=@"http://www.menucool.com/slider/prod/image-slider-5.jpg";
//    
//    [shop addPromotionNewObject:proNews];
    
    return shop;
}

-(enum SHOP_PROMOTION_TYPE)enumPromotionType
{
    switch (self.promotionType.integerValue) {
        case 0:
            return SHOP_PROMOTION_NONE;
            
        case 1:
            return SHOP_PROMOTION_KM1;
            
        case 2:
            return SHOP_PROMOTION_KM2;
            
        default:
            return SHOP_PROMOTION_NONE;
    }
}

-(NSArray *) topCommentsObjects
{
    return [[super topCommentsObjects] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:ShopUserComment_SortOrder ascending:true]]];
}

-(NSArray *)timeCommentsObjects
{
    return [[super timeCommentsObjects] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:ShopUserComment_SortOrder ascending:true]]];
}

-(NSArray *)userGalleriesObjects
{
    return [[super userGalleriesObjects] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:ShopUserGallery_SortOrder ascending:true]]];
}

-(NSArray *)shopGalleriesObjects
{
    return [[super shopGalleriesObjects] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:ShopGallery_SortOrder ascending:true]]];
}

-(enum LOVE_STATUS)enumLoveStatus
{
    switch (self.loveStatus.integerValue) {
        case 0:
            return LOVE_STATUS_NONE;
            
        case 1:
            return LOVE_STATUS_LOVED;
            
        default:
            return LOVE_STATUS_NONE;
    }
}

-(NSString *)title
{
    return self.shopName;
}

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    _dragCoord=newCoordinate;
}

-(enum SHOP_DATA_MODE)enumDataMode
{
    switch (self.dataMode.integerValue) {
        case 0:
            return SHOP_DATA_SHOP_LIST;
            
        case 1:
            return SHOP_DATA_HOME_8;
            
        case 2:
            return SHOP_DATA_FULL;
    }
    
    return SHOP_DATA_HOME_8;
}

-(enum SHOP_TYPE)enumShopType
{
    switch (self.shopType.integerValue) {
        case SHOP_TYPE_ALL:
            return SHOP_TYPE_ALL;
            
        case SHOP_TYPE_FOOD:
            return SHOP_TYPE_FOOD;
            
        case SHOP_TYPE_CAFE:
            return SHOP_TYPE_CAFE;
            
        case SHOP_TYPE_HEALTH:
            return SHOP_TYPE_HEALTH;
            
        case SHOP_TYPE_ENTERTAIMENT:
            return SHOP_TYPE_ENTERTAIMENT;
            
        case SHOP_TYPE_FASHION:
            return SHOP_TYPE_FASHION;
            
        case SHOP_TYPE_TRAVEL:
            return SHOP_TYPE_TRAVEL;
            
        case SHOP_TYPE_PRODUCTION:
            return SHOP_TYPE_PRODUCTION;
            
        case SHOP_TYPE_EDUCATION:
            return SHOP_TYPE_EDUCATION;
            
        default:
            return SHOP_TYPE_ALL;
    }
}

-(NSString *)shopName1
{
    return @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh";
}

-(NSString *)address1
{
    return @"Võ Văn Kiệt\nHồ Chí Minh";
}

-(NSString *)desc1
{
    return @"Lorem ipsum dolor sit amet, consectetuer adipiscing  ";
}

-(NSArray *)promotionNewObjects
{
    NSArray *array=[super promotionNewObjects];
    if(array.count>0)
        return [array sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:PromotionNews_SortOrder ascending:true]]];
    return [NSArray array];
}

@end