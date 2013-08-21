#import "Group.h"

@implementation Group

+(Group *)groupWithIDGroup:(int)idGroup
{
    return [Group queryGroupObject:[NSPredicate predicateWithFormat:@"%K == %i",Group_IdGroup,idGroup]];
}

-(bool)isActived
{
    return self.count && self.count.integerValue>0;
}

+(NSArray *)allObjects
{
    NSArray *array=[super allObjects];
    
    if(array.count>0)
        return [array sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:Group_Name ascending:true]]];
    
    return array;
}

-(NSString *)imageName
{
    switch (self.idGroup.integerValue) {
            
        case 1:
            return @"icon12.png";
            
        case 2:
            return @"icon13.png";
            
        case 3:
            return @"icon14.png";
            
        case 4:
            return @"icon15.png";
            
        case 5:
            return @"icon16.png";
            
        case 6:
            return @"icon17.png";
            
        case 7:
            return @"icon18.png";
            
        case 8:
            return @"icon19.png";
            
        default:
            return @"icon14.png";
    }
}

+(Group *)groupAll
{
    return [Group groupWithIDGroup:0];
}

-(NSString *)key
{
    if(self.idGroup.integerValue==0)
        return @"1,2,3,4,5,6,7,8";
    
    return [NSString stringWithFormat:@"%i",self.idGroup.integerValue];
}

-(UIImage *)iconPin
{
    switch (self.idGroup.integerValue) {
        case 1:
            return [UIImage imageNamed:@"iconpin_food.png"];

        case 2:
            return [UIImage imageNamed:@"iconpin_drink.png"];
            
        case 3:
            return [UIImage imageNamed:@"iconpin_healness.png"];
            
        case 4:
            return [UIImage imageNamed:@"iconpin_entertaiment.png"];
            
        case 5:
            return [UIImage imageNamed:@"iconpin_fashion.png"];
            
        case 6:
            return [UIImage imageNamed:@"iconpin_travel.png"];
            
        case 7:
            return [UIImage imageNamed:@"iconpin_shopping.png"];
            
        case 8:
            return [UIImage imageNamed:@"iconpin_education.png"];
            
        default:
            return nil;
    }
}

@end