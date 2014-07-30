#import "UserHomeSection.h"
#import "UserHome.h"
#import "Utility.h"

@implementation UserHomeSection

-(NSArray *)homeObjects
{
    return [[super homeObjects] sortedArrayUsingDescriptors:@[sortDesc(UserHome_Page, true), sortDesc(UserHome_SortOrder, true)]];
}

@end
