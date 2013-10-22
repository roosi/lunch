//
//  ExtendNSLog.h
//  Lunch
//
//  Created by Jouni Nurmi on 10/22/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifdef DEBUG
#define NSLog(args...) ExtendNSLog(__FILE__,__LINE__,__PRETTY_FUNCTION__,args);
#else
#define NSLog(x...)
#endif
void ExtendNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...);
