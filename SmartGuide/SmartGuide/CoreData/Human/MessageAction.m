#import "MessageAction.h"
#import "Enums.h"

@implementation MessageAction
@synthesize actionTitleWidth;

+(MessageAction *)makeWithData:(NSDictionary *)action
{
    MessageAction *obj=[MessageAction insert];
    
    obj.actionTitle=[NSString makeString:action[@"actionTitle"]];
    obj.actionType=[NSNumber makeNumber:action[@"actionType"]];
    
    switch (obj.enumActionType) {
        case MESSAGE_ACTION_TYPE_UNKNOW:
            
            break;
            
        case MESSAGE_ACTION_TYPE_CALL_API:
            obj.url=[NSString makeString:action[@"url"]];
            obj.method=[NSNumber makeNumber:action[@"method"]];
            obj.params=[NSString makeString:action[@"params"]];
            break;
            
        case MESSAGE_ACTION_TYPE_CALL_GO_SHOP:
            obj.idShop=[NSNumber makeNumber:action[@"idShop"]];
            break;
            
        case MESSAGE_ACTION_TYPE_CALL_GO_SHOP_LIST:
            if(action[@"idPlacelist"])
                obj.idPlacelist=[NSNumber makeNumber:action[@"idPlacelist"]];
            else
            {
                NSString *str=[NSString makeString:action[@"keywords"]];
                
                if(str.length>0)
                    obj.keywords=str;
                else
                {
                    str=[NSString makeString:action[@"idShops"]];
                    
                    if(str.length>0)
                        obj.idShops=str;
                }
            }
            break;
            
        case MESSAGE_ACTION_TYPE_CALL_POPUP_WEBVIEW:
            obj.url=[NSString makeString:action[@"url"]];
            break;
    }

    return obj;
}

-(enum MESSAGE_ACTION_TYPE)enumActionType
{
    switch ((enum MESSAGE_ACTION_TYPE)self.actionType) {
        case MESSAGE_ACTION_TYPE_CALL_API:
            return MESSAGE_ACTION_TYPE_CALL_API;
            
        case MESSAGE_ACTION_TYPE_CALL_GO_SHOP:
            return MESSAGE_ACTION_TYPE_CALL_GO_SHOP;
            
        case MESSAGE_ACTION_TYPE_CALL_GO_SHOP_LIST:
            return MESSAGE_ACTION_TYPE_CALL_GO_SHOP_LIST;
            
        case MESSAGE_ACTION_TYPE_CALL_POPUP_WEBVIEW:
            return MESSAGE_ACTION_TYPE_CALL_POPUP_WEBVIEW;
            
        case MESSAGE_ACTION_TYPE_UNKNOW:
            return MESSAGE_ACTION_TYPE_UNKNOW;
    }
    
    return MESSAGE_ACTION_TYPE_UNKNOW;
}

@end