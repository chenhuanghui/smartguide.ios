#import "Shop.h"
#import "PromotionDetail.h"
#import "PromotionRequire.h"
#import "Utility.h"

@implementation Shop
@synthesize selected,showPinType,isUserCollection,isShopDetail;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    self.isNeedReloadData=false;
    self.shop_lat=[NSNumber numberWithDouble:-1];
    self.shop_lng=[NSNumber numberWithDouble:-1];
    self.showPinType=0;
    
    return self;
}

+(Shop *)shopWithIDShop:(int)idShop
{
    return [Shop queryShopObject:[NSPredicate predicateWithFormat:@"%K == %i",Shop_IdShop,idShop]];
}

-(CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(self.shop_lat.doubleValue, self.shop_lng.doubleValue);
}

-(int)score
{
    if(self.promotionDetail)
        return [self.promotionDetail.sgp doubleValue];
    
    return 0;
}

-(int)minRank
{
    return self.promotionDetail.min_score.integerValue;
    int rank=0;
    if(self.promotionDetail && [self.promotionDetail.promotionType integerValue]!=-1 && self.promotionDetail.requiresObjects.count>0)
    {
        double sgp=self.promotionDetail.sgp.doubleValue;
        
        NSArray *ranks=[[self.promotionDetail.requiresObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K <= %f",PromotionRequire_SgpRequired,sgp]] valueForKey:PromotionRequire_SgpRequired];

        if(ranks.count>0)
            rank=(int)([[ranks objectAtIndex:0] doubleValue]);
        else
            rank=(int)([[[self.promotionDetail.requiresObjects valueForKey:PromotionRequire_SgpRequired] objectAtIndex:0] doubleValue]);
    }
    
    return rank;
}

-(NSArray *)ranks
{
    if(self.promotionDetail)
    {
        double sgp=self.promotionDetail.sgp.doubleValue;

        return [self.promotionDetail.requiresObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K <= %f",PromotionRequire_SgpRequired,sgp]];
    }
    
    return [NSArray array];
}

+(NSArray *)queryShop:(NSPredicate *)predicate
{
    NSArray *array=[super queryShop:predicate];
    
    if(array.count>0)
        return [array sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:Shop_Name ascending:true]]];
    
    return array;
}

-(PromotionDetail *)promotionDetail
{
    if([self.promotionStatus boolValue])
        return [super promotionDetail];
    
    return nil;
}

+(Shop *)makeShopWithDictionaryUserCollection:(NSDictionary *)data
{
    Shop *shop=[Shop makeShopWithDictionaryShopInGroup:data];
    
    shop.updated_at=[NSString stringWithStringDefault:[data objectForKey:@"updated_at"]];
    shop.isUserCollection=true;
    
    return shop;
}

+(Shop *)makeShopWithDictionaryShopInGroup:(NSDictionary *)dict
{
    int idShop=[dict integerForKey:@"id"];
    Shop *shop = [Shop shopWithIDShop:idShop];
    if(!shop)
    {
        shop=[Shop insert];
        shop.idShop=[NSNumber numberWithInt:idShop];
    }
    
    shop.isUserCollection=false;
    shop.isShopDetail=@(false);
    
    shop.name=[dict objectForKey:@"name"];
    shop.shop_lat=[dict objectForKey:@"shop_lat"];
    shop.shop_lng=[dict objectForKey:@"shop_lng"];
    shop.distance=[dict objectForKey:@"distance"];
    shop.logo=[NSString stringWithStringDefault:[dict objectForKey:@"logo"]];
    shop.desc=[NSString stringWithStringDefault:[dict objectForKey:@"description"]];
    shop.address=[NSString stringWithStringDefault:[dict objectForKey:@"address"]];
    shop.promotionStatus=[dict objectForKey:@"promotion_status"];
    shop.like_status=[dict objectForKey:@"like_status"];
    shop.like=[dict objectForKey:@"like"];
    shop.dislike=[dict objectForKey:@"dislike"];
    shop.numOfVisit=[dict objectForKey:@"num_of_visit"];
    shop.numOfLike=[dict objectForKey:@"num_of_like"];
    shop.numGetPromotion=[dict objectForKey:@"num_get_promotion"];
    shop.numGetReward=[dict objectForKey:@"num_get_reward"];
    shop.idGroup=[dict objectForKey:@"group_shop"];
    shop.selected=false;
    
    if(shop.promotionStatus.boolValue)
    {
        NSDictionary *dicInner=[dict objectForKey:@"promotion_detail"];
        
        PromotionDetail *promotion=shop.promotionDetail;
        
        if(!promotion)
        {
            promotion=[PromotionDetail insert];
            promotion.shop=shop;
            shop.promotionDetail=promotion;
        }
        
        promotion.promotionType=[dicInner objectForKey:@"promotion_type"];
        promotion.sgp=[dicInner objectForKey:@"sgp"];
        promotion.sp=[dicInner objectForKey:@"sp"];
        promotion.cost=[dicInner objectForKey:@"cost"];
        promotion.duration=[NSString stringWithStringDefault:[dicInner objectForKey:@"duration"]];
        promotion.money=[dicInner objectForKey:@"money"];
        promotion.idAwardType2=[dicInner objectForKey:@"id"];
        promotion.desc=[NSString stringWithStringDefault:[dicInner objectForKey:@"description"]];
        
        [promotion removeRequires:promotion.requires];
        
        dicInner=[dicInner objectForKey:@"array_required"];
        
        for(NSDictionary *childDicInner in dicInner)
        {
            PromotionRequire *require=[PromotionRequire insert];
            
            require.idRequire=[childDicInner objectForKey:@"id"];
            require.promotion=promotion;
            require.sgpRequired=[childDicInner objectForKey:@"required"];
            require.content=[NSString stringWithStringDefault:[childDicInner objectForKey:@"content"]];
        }
    }
    else
    {
        if(shop.promotionDetail)
        {
            [shop setPromotionDetail:nil];
        }
    }
    
    return shop;
}

-(NSString *)time
{
    if(self.updated_at.length>0)
    {
        NSArray *array=[self.updated_at componentsSeparatedByString:@" "];
        if(array.count>0)
            return [array objectAtIndex:0];
    }
    
    return @"";
}

-(NSString *)day
{
    if(self.updated_at.length>0)
    {
        NSArray *array=[self.updated_at componentsSeparatedByString:@" "];
        if(array.count>1)
            return [array objectAtIndex:1];
    }
    
    return @"";
}

-(double)SGP
{
    if(self.promotionDetail && self.promotionDetail.promotionType.integerValue==1)
    {
        return self.promotionDetail.sgp.doubleValue;
    }
    
    return 0;
}

-(double)SP
{
    if(self.promotionDetail && self.promotionDetail.promotionType.integerValue==1)
    {
        return self.promotionDetail.sp.doubleValue;
    }
    
    return 0;
}

@end