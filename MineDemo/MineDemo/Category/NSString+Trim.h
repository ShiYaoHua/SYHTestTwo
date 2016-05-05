//
//  NSString+Trim.h
//
//  Created by syh on 15/6/26.
//  Copyright (c) 2015年  All rights reserved.
//
//

#import <Foundation/Foundation.h>
/**
 * 去掉前后空格 换行符 特殊符号 表情 方法
 */
@interface NSString (Trim)
//去除特殊符号 characterSet包含特殊符号 应用于登录
+ (NSString *)trim:(NSString *)val trimCharacterSet:(NSCharacterSet *)characterSet;
//去掉空格
+ (NSString *)trimWhitespace:(NSString *)val;
//去掉换行符
+ (NSString *)trimNewline:(NSString *)val;
//去掉空格和换行符
+ (NSString *)trimWhitespaceAndNewline:(NSString *)val;
//过滤表情
//+ (NSString *)disable_emoji:(NSString *)text;

+ (NSString *)disable_emoji:(NSString *)string;

//如何使用
- (void)useExample;

@end
