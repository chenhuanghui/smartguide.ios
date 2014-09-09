#import "_ScanCodeResult.h"
#import "ScanCodeRelated.h"

enum SCAN_CODE_DECODE_TYPE
{
    SCAN_CODE_DECODE_TYPE_UNKNOW=-1,
    SCAN_CODE_DECODE_TYPE_QUERYING=0,
    SCAN_CODE_DECODE_TYPE_INFORY=1,
    SCAN_CODE_DECODE_TYPE_NON_INFORY=2,
    SCAN_CODE_DECODE_TYPE_ERROR=3,
};

enum SCAN_CODE_RELATED_STATUS
{
    SCAN_CODE_RELATED_STATUS_ERROR=-1,
    SCAN_CODE_RELATED_STATUS_UNKNOW=0,
    SCAN_CODE_RELATED_STATUS_QUERYING=1,
    SCAN_CODE_RELATED_STATUS_DONE=2,
};

@interface ScanCodeResult : _ScanCodeResult 
{
}

+(ScanCodeResult*) resultWithCode:(NSString*) code;
+(ScanCodeResult*) makeWithCode:(NSString*) code;
-(enum SCAN_CODE_DECODE_TYPE) enumDecodeType;
-(enum SCAN_CODE_RELATED_STATUS) enumRelatedStatus;


@end
