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

NSString* STRING_FORMAT(NSString* format, ...)
{
    va_list args;
    va_start(args, format);
    
    NSString *str=[[NSString alloc] initWithFormat:format arguments:args];
    
    va_end(args);
    
    return str;
}

void DLog(enum DLOG_LEVEL_TYPE logLevel, NSString*(^logString)())
{
#if DEBUG
    if(logLevel <= DLOG_LEVEL)
    {
        NSLog(@"%@",logString());
    }
#endif
    
    logString=nil;
}

void DLogDebug(NSString*(^logString)())
{
    DLog(DLOG_LEVEL_TYPE_DEBUG, logString);
}

void DLogError(NSString*(^logString)())
{
    DLog(DLOG_LEVEL_TYPE_ERR, logString);
}