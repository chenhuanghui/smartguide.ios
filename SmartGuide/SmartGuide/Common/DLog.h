//
//  DLog.h
//  Infory
//
//  Created by XXX on 6/27/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#define DLOG_DEBUG(dFormat, ...) DLogDebug(^NSString *{ return STRING_FORMAT(dFormat, ##__VA_ARGS__);})
#define DLOG_ERROR(dFormat, ...) DLogError(^NSString *{ return STRING_FORMAT(dFormat, ##__VA_ARGS__);})
#define DLOG_DOWNLOAD(dFormat, ...) DLogDownload(^NSString *{ return STRING_FORMAT(dFormat, ##__VA_ARGS__);})

NSString* STRING_FORMAT(NSString* format, ...);
void DLogDebug(NSString*(^)());
void DLogError(NSString*(^)());
void DLogDownload(NSString*(^)());