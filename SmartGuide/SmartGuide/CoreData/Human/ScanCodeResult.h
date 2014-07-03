#import "_ScanCodeResult.h"
#import "ScanCodeRelated.h"

enum SCAN_CODE_RESULT_TYPE
{
    SCAN_CODE_RESULT_TYPE_IDENTIFYING=0,
    SCAN_CODE_RESULT_TYPE_INFORY=1,
    SCAN_CODE_RESULT_TYPE_NON_INFORY=2,
    SCAN_CODE_RESULT_TYPE_ERROR=3,
};

@interface ScanCodeResult : _ScanCodeResult 
{
}

+(ScanCodeResult*) resultWithCode:(NSString*) code;
+(ScanCodeResult*) makeWithCode:(NSString*) code;
-(enum SCAN_CODE_RESULT_TYPE) enumType;

-(ScanCodeRelatedContain*) relatedContaintWithIndex:(int) index;

@end
