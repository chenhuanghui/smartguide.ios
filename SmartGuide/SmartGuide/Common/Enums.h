//
//  Enums.h
//  Infory
//
//  Created by XXX on 8/28/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>

enum MESSAGE_VIEW_STATUS
{
    MESSAGE_VIEW_STATUS_UNREAD=0,
    MESSAGE_VIEW_STATUS_READ=1,
};

enum MESSAGE_ACTION_TYPE
{
    MESSAGE_ACTION_TYPE_UNKNOW=-1,
    MESSAGE_ACTION_TYPE_CALL_API=0,
    MESSAGE_ACTION_TYPE_CALL_GO_SHOP=1,
    MESSAGE_ACTION_TYPE_CALL_GO_SHOP_LIST=2,
    MESSAGE_ACTION_TYPE_CALL_POPUP_WEBVIEW=3,
//    MESSAGE_ACTION_TYPE_CALL_GO_USER_SETTING=4,
//    MESSAGE_ACTION_TYPE_CALL_GO_EVENTS=5,
};

enum COMMENT_AGREE_STATUS
{
    COMMENT_AGREE_STATUS_NONE = 0,
    COMMENT_AGREE_STATUS_AGREED = 1
};

enum PLACE_SORT_TYPE
{
    PLACE_SORT_TYPE_DISTANCE=0,
    PLACE_SORT_TYPE_VIEWS=1,
    PLACE_SORT_TYPE_LOVES=2,
    PLACE_SORT_TYPE_DEFAULT=3,
};

enum SHOP_LIST_SORT_TYPE
{
    SHOP_LIST_SORT_TYPE_DISTANCE=0,
    SHOP_LIST_SORT_TYPE_VIEWS=1,
    SHOP_LIST_SORT_TYPE_LOVES=2,
    SHOP_LIST_SORT_TYPE_DEFAULT=3,
};