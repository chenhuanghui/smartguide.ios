#import "ScanCodeResult.h"
#import "ScanCodeRelatedContain.h"
#import "ScanCodeDecode.h"

@implementation ScanCodeResult

+(ScanCodeResult *)resultWithCode:(NSString *)code
{
    return [ScanCodeResult queryScanCodeResultObject:[NSPredicate predicateWithFormat:@"%K LIKE[c] %@", ScanCodeResult_Code, code]];
}

+(ScanCodeResult *)makeWithCode:(NSString *)code
{
    ScanCodeResult *obj=[ScanCodeResult insert];
    
    obj.type=@(SCAN_CODE_RESULT_TYPE_IDENTIFYING);
    obj.code=code;
    
    return obj;
}

-(enum SCAN_CODE_RESULT_TYPE)enumType
{
    switch ((enum SCAN_CODE_RESULT_TYPE)self.type.integerValue) {
        case SCAN_CODE_RESULT_TYPE_ERROR:
            return SCAN_CODE_RESULT_TYPE_ERROR;
            
        case SCAN_CODE_RESULT_TYPE_INFORY:
            return SCAN_CODE_RESULT_TYPE_INFORY;
            
        case SCAN_CODE_RESULT_TYPE_NON_INFORY:
            return SCAN_CODE_RESULT_TYPE_NON_INFORY;
            
        case SCAN_CODE_RESULT_TYPE_IDENTIFYING:
            return SCAN_CODE_RESULT_TYPE_IDENTIFYING;
    }
    
    return SCAN_CODE_RESULT_TYPE_IDENTIFYING;
}

-(NSArray *)relatedContainObjects
{
    return [[super relatedContainObjects] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:ScanCodeRelated_Order ascending:true]]];
}

-(ScanCodeRelatedContain *)relatedContaintWithIndex:(int)index
{
    return [[[[super relatedContain] filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"%K==%i",ScanCodeRelated_Order, index]] allObjects] firstObject];
}

-(NSArray *)decodeObjects
{
    return [[super decodeObjects] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:ScanCodeDecode_Order ascending:true]]];
}

@end
