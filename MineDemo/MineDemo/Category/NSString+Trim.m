//
//  NSString+Trim.m
//
//  Created by syh on 15/6/26.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "NSString+Trim.h"



@implementation NSString (Trim)

+ (NSString *)trim:(NSString *)val trimCharacterSet:(NSCharacterSet *)characterSet {
     NSString *returnVal = @"";
     if (val) {
         //在ios中 可以使用stringByTrimmingCharactersInSet函数过滤字符串中的特殊符号
         returnVal = [val stringByTrimmingCharactersInSet:characterSet];
     }
    return returnVal;
}

+ (NSString *)trimWhitespace:(NSString *)val {
     return [self trim:val trimCharacterSet:[NSCharacterSet whitespaceCharacterSet]]; //去掉前后空格
}

+ (NSString *)trimNewline:(NSString *)val {
    return [self trim:val trimCharacterSet:[NSCharacterSet newlineCharacterSet]]; //去掉前后回车符
}

+ (NSString *)trimWhitespaceAndNewline:(NSString *)val {
    return [self trim:val trimCharacterSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去掉前后空格和回车符
}

//+ (NSString *)disable_emoji:(NSString *)text // 过滤表情
//{
//    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
//    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
//                                                               options:0
//                                                                 range:NSMakeRange(0, [text length])
//                                                          withTemplate:@""];
//    return modifiedString;
//}


+ (NSString *)disable_emoji:(NSString *)string
{
    __block NSString *modifiedString = [NSString string];
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            return;
                                        } else {
                                            modifiedString = [modifiedString stringByAppendingString:substring];
                                        }
                                    }
                                    
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        return;
                                    } else {
                                        modifiedString = [modifiedString stringByAppendingString:substring];
                                    }
                                } else {
                                    
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        return;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        return;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        return;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        return;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        return;
                                    } else {
                                        modifiedString = [modifiedString stringByAppendingString:substring];
                                    }
                                }
                            }];
    return modifiedString;
}

- (void)useExample{
    //1  自己定义一个NSCharacterSet, 包含需要去除的特殊符号
     NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
    NSString *str = @"12414fg2qt%$^^";
    NSString *str2 = [NSString trim:str trimCharacterSet:set]; //注意调用时使用NSString调用
    NSLog(@"str:%@ str2:%@",str,str2);
    
    
}
@end
