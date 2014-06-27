//
//  DLog.m
//  Infory
//
//  Created by XXX on 6/27/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "DLog.h"

#define DLOG_LEVEL DLOG_LEVEL_TYPE_DEBUG

enum DLOG_LEVEL_TYPE
{
    DLOG_LEVEL_TYPE_EMERG = 0,
    DLOG_LEVEL_TYPE_ALERT = 1,
    DLOG_LEVEL_TYPE_CRIT = 2,
    DLOG_LEVEL_TYPE_ERR = 3,
    DLOG_LEVEL_TYPE_WARNING = 4,
    DLOG_LEVEL_TYPE_NOTICE = 5,
    DLOG_LEVEL_TYPE_INFO = 6,
    DLOG_LEVEL_TYPE_DEBUG = 7
};

NSString* DLOG_STRING(enum DLOG_LEVEL_TYPE logType)
{
    switch (logType) {
        case DLOG_LEVEL_TYPE_ALERT:
            return @"ALERT";
        case DLOG_LEVEL_TYPE_INFO:
            return @"INFO";
        case DLOG_LEVEL_TYPE_DEBUG:
            return @"DEBUG";
        case DLOG_LEVEL_TYPE_CRIT:
            return @"CRITICAL";
        case DLOG_LEVEL_TYPE_EMERG:
            return @"EMERGENCY";
        case DLOG_LEVEL_TYPE_ERR:
            return @"ERROR";
        case DLOG_LEVEL_TYPE_NOTICE:
            return @"NOTICE";
        case DLOG_LEVEL_TYPE_WARNING:
            return @"WARNING";
    }
}

void DLog(NSString*(^log)(), enum DLOG_LEVEL_TYPE logLevel)
{
#if DEBUG
    if(logLevel<=DLOG_LEVEL)
        NSLog(@"%@ %@",DLOG_STRING(logLevel),log());
#endif
}

void DLogDebug(NSString*(^log)())
{
    DLog(log, DLOG_LEVEL_TYPE_DEBUG);
}

void DLogInfo(NSString*(^log)())
{
    DLog(log, DLOG_LEVEL_TYPE_INFO);
}