#import "UserHome.h"
#import "Utility.h"

@implementation UserHome

+(UserHome *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome *home=[UserHome insert];
    
    home.type=[NSNumber numberWithObject:dict[@"type"]];
    
    NSArray *imgs=dict[@"images"];
    
    if(![imgs isNullData])
    {
        int count=0;
        for(NSString* img in imgs)
        {
            UserHomeImage *obj=[UserHomeImage insert];
            obj.image=[NSString stringWithStringDefault:img];
            obj.sortOrder=@(count++);
            
            [home addImagesObject:obj];
        }
    }
    
    return home;
}

-(enum USER_HOME_TYPE)enumType
{
    switch (self.type.integerValue) {
        case 1:
            return USER_HOME_TYPE_1;
            
        case 2:
            return USER_HOME_TYPE_2;
            
        case 3:
            return USER_HOME_TYPE_3;
            
        case 4:
            return USER_HOME_TYPE_4;
            
        case 5:
            return USER_HOME_TYPE_5;
            
        case 6:
            return USER_HOME_TYPE_6;
            
        case 7:
            return USER_HOME_TYPE_7;
            
        default:
            return USER_HOME_TYPE_UNKNOW;
    }
}

-(NSArray *)home2Objects
{
    NSArray *array=[super home2Objects];
    
    if(array.count>0)
        return [array sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:UserHome2_SortOrder ascending:true]]];
    
    return [NSArray array];
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

-(NSArray *)home5Objects
{
    NSArray *array=[super home5Objects];
    
    if(array.count>0)
        return [array sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:UserHome5_SortOrder ascending:true]]];
    
    return [NSArray array];
}

-(NSArray *)imagesObjects
{
    NSArray *array=[super imagesObjects];
    
    if(array.count>0)
        return [array sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:UserHomeImage_SortOrder ascending:true]]];
    
    return [NSArray array];
}

@end
