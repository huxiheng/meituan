//
//  NSFileManager+LSExtends.h
//  LSBrowser
//
//  Created by Lessu on 13-6-10.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (LSExtends)
#ifdef __IPHONE_2_0
- (NSString *)documentPath;
- (NSString *)documentPathWithFile:(NSString *)filename;

#endif
@end
