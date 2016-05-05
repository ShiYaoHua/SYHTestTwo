//
//  NSArray+keyedArchiver.h
//
//  Created by syh on 15/11/9.
//  Copyright © 2015年 All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 保存城市列表到本地 keyedArchiver是对NSArray的一个扩展
 */

@interface NSArray (keyedArchiver)
//归档
-(void)keyedArchiverCityList;
//解档
+(id)KeyedUnArchiverCityList;
//如何使用
- (void)userEg;


@end
