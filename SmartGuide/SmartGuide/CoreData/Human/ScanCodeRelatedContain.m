#import "ScanCodeRelatedContain.h"
#import "ScanCodeRelated.h"

@implementation ScanCodeRelatedContain

-(NSArray *)relatiesObjects
{
    NSArray *array=[super relatiesObjects];
    
    if(array.count>0)
        return [array sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:ScanCodeRelated_Page ascending:true],[NSSortDescriptor sortDescriptorWithKey:ScanCodeRelated_Order ascending:true]]];
    
    return array;
}

@end
