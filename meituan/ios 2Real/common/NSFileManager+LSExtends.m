//
//  NSFileManager+LSExtends.m
//  LSBrowser
//
//  Created by Lessu on 13-6-10.
//  Copyright (c) 2013年 Lessu. All rights reserved.
//

#import "NSFileManager+LSExtends.h"

@implementation NSFileManager (LSExtends)
#ifdef __IPHONE_2_0

- (NSString *)documentPath{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDirectory = [paths objectAtIndex:0];
	return documentDirectory;
}

- (NSString *)documentPathWithFile:(NSString *)filename{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDirectory = [paths objectAtIndex:0];
	return [documentDirectory stringByAppendingPathComponent:filename];
}

#endif

@end
