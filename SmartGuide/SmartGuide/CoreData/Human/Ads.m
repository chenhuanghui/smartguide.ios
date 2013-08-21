#import "Ads.h"

@implementation Ads

+(Ads *)adsWithID:(int)idAds
{
    return [Ads queryAdsObject:[NSPredicate predicateWithFormat:@"%K == %i",Ads_IdAds,idAds]];
}

+(Ads *)adsWithURL:(NSString *)url
{
    return [Ads queryAdsObject:[NSPredicate predicateWithFormat:@"%K == %@",Ads_Image_url,url]];
}

@end
