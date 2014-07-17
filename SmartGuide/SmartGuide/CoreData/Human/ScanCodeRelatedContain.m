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

-(enum QRCODE_RELATED_TYPE)enumType
{
    switch ((enum QRCODE_RELATED_TYPE)self.type.integerValue) {
        case QRCODE_RELATED_TYPE_PLACELISTS:
            return QRCODE_RELATED_TYPE_PLACELISTS;
            
        case QRCODE_RELATED_TYPE_PROMOTIONS:
            return QRCODE_RELATED_TYPE_PROMOTIONS;
            
        case QRCODE_RELATED_TYPE_SHOPS:
            return QRCODE_RELATED_TYPE_SHOPS;
            
        case QRCODE_RELATED_TYPE_UNKNOW:
            return QRCODE_RELATED_TYPE_UNKNOW;
    }
    
    return QRCODE_RELATED_TYPE_UNKNOW;
}

-(NSString *)title
{
    switch (self.enumType) {
        case QRCODE_RELATED_TYPE_SHOPS:
            return @"Địa điểm";
            
        case QRCODE_RELATED_TYPE_UNKNOW:
            return @"";
            
        case QRCODE_RELATED_TYPE_PROMOTIONS:
            return @"Ưu đãi";
            
        case QRCODE_RELATED_TYPE_PLACELISTS:
            return @"Danh sách";
    }
    
    return @"";
}

@end
