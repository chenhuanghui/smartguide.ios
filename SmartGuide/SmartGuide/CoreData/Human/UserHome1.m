#import "UserHome1.h"
#import "Utility.h"

@implementation UserHome1

+(UserHome1 *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome1 *home=[UserHome1 insert];
    
    home.logo=[NSString stringWithStringDefault:dict[@"logo"]];
    home.content=[NSString stringWithStringDefault:dict[@"content"]];
    home.shopList=[NSString stringWithStringDefault:dict[@"shopList"]];
    
    return home;
}

-(NSArray *)idShops
{
    if(self.shopList.length>0)
    {
        if([self.shopList containsString:@","])
        {
            NSMutableArray *array=[[self.shopList componentsSeparatedByString:@","] mutableCopy];
            
            for(int i=0;i<array.count;i++)
            {
                [array replaceObjectAtIndex:i withObject:[NSNumber numberWithObject:array[i]]];
            }
            
            return array;
        }
        else
            return @[[NSNumber numberWithObject:self.shopList]];
    }
    
    return [NSArray array];
}

-(NSNumber *)idShop
{
    NSArray *array=[self idShops];
    
    if(array.count>0)
        return array[0];
    
    return nil;
}

@end
