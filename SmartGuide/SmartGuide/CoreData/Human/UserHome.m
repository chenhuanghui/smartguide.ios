#import "UserHome.h"
#import "Utility.h"

@implementation UserHome

+(UserHome *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome *home=[UserHome insert];
    
    home.type=[NSNumber makeNumber:dict[@"type"]];
    home.idPost=[NSNumber makeNumber:dict[@"idPost"]];
    
    return home;
}

-(NSArray *)makeHomeImage:(NSArray *)images
{
    if([images hasData])
    {
        int sort=0;
        
        NSMutableArray *array=[NSMutableArray array];
        for(NSString *image in images)
        {
            UserHomeImage *obj=[UserHomeImage insert];
            obj.image=[NSString makeString:image];
            obj.sortOrder=@(sort++);
            
            [self addImagesObject:obj];
            [array addObject:obj];
        }
        
        return array;
    }
    
    return @[];
}

-(enum USER_HOME_TYPE)enumType
{
    switch ((enum USER_HOME_TYPE)self.type.integerValue) {
        case USER_HOME_TYPE_1:
            return USER_HOME_TYPE_1;
            
        case USER_HOME_TYPE_2:
            return USER_HOME_TYPE_2;
            
        case USER_HOME_TYPE_3:
            return USER_HOME_TYPE_3;
            
        case USER_HOME_TYPE_4:
            return USER_HOME_TYPE_4;
            
        case USER_HOME_TYPE_6:
            return USER_HOME_TYPE_6;
            
        case USER_HOME_TYPE_8:
            return USER_HOME_TYPE_8;
            
        case USER_HOME_TYPE_9:
            return USER_HOME_TYPE_9;
            
        case USER_HOME_TYPE_UNKNOW:
            return USER_HOME_TYPE_UNKNOW;
    }
    
    return USER_HOME_TYPE_UNKNOW;
}

-(NSArray *)home3Objects
{
    NSArray *array=[super home3Objects];
    
    if(array.count>0)
        return [array sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:UserHome3_SortOrder ascending:true]]];
    
    return [NSArray array];
}

-(NSArray *)home4Objects
{
    NSArray *array=[super home4Objects];
    
    if(array.count>0)
        return [array sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:UserHome4_SortOrder ascending:true]]];
    
    return [NSArray array];
}

-(NSArray *)imagesObjects
{
    NSArray *array=[super imagesObjects];
    
    if(array.count>0)
        return [array sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:UserHomeImage_SortOrder ascending:true]]];
    
    return [NSArray array];
}

-(bool)isHome9Header
{
    return [self enumType]==USER_HOME_TYPE_9 && [self.title hasData];
}


@end
