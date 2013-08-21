#import "PromotionDetail.h"
#import "PromotionRequire.h"

@implementation PromotionDetail

-(NSArray *)requiresObjects
{
    NSArray *array=[super requiresObjects];
    
    if(array.count>0)
    {
        NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:PromotionRequire_SgpRequired ascending:true];
        return [array sortedArrayUsingDescriptors:@[sort]];
    }
    
    return array;
}

@end
