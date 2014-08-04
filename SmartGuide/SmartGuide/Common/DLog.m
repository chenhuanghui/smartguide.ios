//
//  DLog.m
//  Infory
//
//  Created by XXX on 6/27/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "DLog.h"

typedef NS_OPTIONS(NSUInteger, DLOG_LEVEL)
{
    DLOG_LEVEL_EMERG = 1 << 0,
    DLOG_LEVEL_ALERT = 1 << 1,
    DLOG_LEVEL_CRIT = 1 << 2,
    DLOG_LEVEL_ERR = 1 << 3,
    DLOG_LEVEL_WARNING = 1 << 4,
    DLOG_LEVEL_NOTICE = 1 << 5,
    DLOG_LEVEL_INFO = 1 << 6,
    DLOG_LEVEL_DEBUG = 1 << 7,
    DLOG_LEVEL_DOWNLOAD = 1 << 8,
};

const DLOG_LEVEL DLOG_CURRENT_LEVEL=DLOG_LEVEL_DEBUG | DLOG_LEVEL_INFO | DLOG_LEVEL_DOWNLOAD;

NSString* STRING_FORMAT(NSString* format, ...)
{
    va_list args;
    va_start(args, format);
    
    NSString *str=[[NSString alloc] initWithFormat:format arguments:args];
    
    va_end(args);
    
    return str;
}

void DLog(DLOG_LEVEL logLevel, NSString*(^logString)())
{
#if DEBUG
    if(DLOG_CURRENT_LEVEL & logLevel)
    {
        NSLog(@"%@",logString());
    }
#endif
    
    logString=nil;
}

void DLogDebug(NSString*(^logString)())
{
    DLog(DLOG_LEVEL_DEBUG, logString);
}

void DLogError(NSString*(^logString)())
{
    DLog(DLOG_LEVEL_ERR, logString);
}

void DLogDownload(NSString*(^logString)())
{
    DLog(DLOG_LEVEL_DOWNLOAD, logString);
}