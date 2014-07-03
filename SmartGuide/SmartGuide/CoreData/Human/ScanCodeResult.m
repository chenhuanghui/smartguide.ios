#import "ScanCodeResult.h"

@implementation ScanCodeResult

+(ScanCodeResult *)makeWithCode:(NSString *)code
{
    ScanCodeResult *obj=[ScanCodeResult insert];
    
    obj.code=code;
    
    return obj;
}

@end
