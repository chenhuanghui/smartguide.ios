#import "UserHome.h"
#import "Utility.h"

@implementation UserHome
@synthesize home9Size;

+(UserHome *)makeWithDictionary:(NSDictionary *)dict
{
    UserHome *home=[UserHome insert];
    
    home.type=[NSNumber numberWithObject:dict[@"type"]];
    home.idPost=[NSNumber numberWithObject:dict[@"idPost"]];
    home.imageWidth=[NSNumber numberWithObject:dict[@"imageWidth"]];
    home.imageHeight=[NSNumber numberWithObject:dict[@"imageHeight"]];
    
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
    
    if(home.enumType==USER_HOME_TYPE_9)
    {
        float frameWidthLayoutHome9=296;
        home.home9Size=CGSizeMake(frameWidthLayoutHome9, MAX(0,frameWidthLayoutHome9*home.imageHeight.floatValue/home.imageWidth.floatValue));
    }
    
    return home;
}

-(enum USER_HOME_TYPE)enumType
{
    switch (self.type.integerValue) {
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

-(NSArray *)imagesObjects
{
    NSArray *array=[super imagesObjects];
    
    if(array.count>0)
        return [array sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:UserHomeImage_SortOrder ascending:true]]];
    
    return [NSArray array];
}

@end
