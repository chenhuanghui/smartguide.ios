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
    
    obj.code=code;
    obj.decodeType=@(SCAN_CODE_DECODE_TYPE_QUERYING);
    obj.relatedStatus=@(SCAN_CODE_RELATED_STATUS_QUERYING);
    
    return obj;
}

-(enum SCAN_CODE_DECODE_TYPE)enumDecodeType
{
    switch ((enum SCAN_CODE_DECODE_TYPE)self.decodeType.integerValue) {
        case SCAN_CODE_DECODE_TYPE_ERROR:
            return SCAN_CODE_DECODE_TYPE_ERROR;
            
        case SCAN_CODE_DECODE_TYPE_INFORY:
            return SCAN_CODE_DECODE_TYPE_INFORY;
            
        case SCAN_CODE_DECODE_TYPE_NON_INFORY:
            return SCAN_CODE_DECODE_TYPE_NON_INFORY;
            
        case SCAN_CODE_DECODE_TYPE_QUERYING:
            return SCAN_CODE_DECODE_TYPE_QUERYING;
            
        case SCAN_CODE_DECODE_TYPE_UNKNOW:
            return SCAN_CODE_DECODE_TYPE_UNKNOW;
            
    }
    
    return SCAN_CODE_DECODE_TYPE_UNKNOW;
}

-(enum SCAN_CODE_RELATED_STATUS)enumRelatedStatus
{
    switch ((enum SCAN_CODE_RELATED_STATUS)self.relatedStatus.integerValue) {
        case SCAN_CODE_RELATED_STATUS_UNKNOW:
            return SCAN_CODE_RELATED_STATUS_UNKNOW;
            
        case SCAN_CODE_RELATED_STATUS_QUERYING:
            return SCAN_CODE_RELATED_STATUS_QUERYING;
            
        case SCAN_CODE_RELATED_STATUS_DONE:
            return SCAN_CODE_RELATED_STATUS_DONE;
            
        case SCAN_CODE_RELATED_STATUS_ERROR:
            return SCAN_CODE_RELATED_STATUS_ERROR;
    }
    
    return SCAN_CODE_RELATED_STATUS_UNKNOW;
}

-(NSArray *)relatedContainObjects
{
    return [[super relatedContainObjects] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:ScanCodeRelated_Order ascending:true]]];
}

-(NSArray *)decodeObjects
{
    return [[super decodeObjects] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:ScanCodeDecode_Order ascending:true]]];
}

@end
