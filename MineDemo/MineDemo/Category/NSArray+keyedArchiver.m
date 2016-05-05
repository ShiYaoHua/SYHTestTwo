//
//  NSArray+keyedArchiver.m
//
//  Created by syh on 15/11/9.
//  Copyright © 2015年 All rights reserved.
//

#import "NSArray+keyedArchiver.h"

@implementation NSArray (keyedArchiver)

-(void)keyedArchiverCityList
{
    NSString *cityPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *pathName = [cityPath stringByAppendingPathComponent:@"cityList.db"];
    if (pathName) {
        [NSKeyedArchiver archiveRootObject:self toFile:pathName];
        
    }

}

+(id)KeyedUnArchiverCityList
{
    NSString *cityPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *pathName = [cityPath stringByAppendingPathComponent:@"cityList.db"];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:pathName]) {
        NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile:pathName];
        
        return arr;
    }else
    {
        return nil;
    }
    
}
- (void)userEg{
    
    NSArray *cities = @[@"北京",@"天津",@"上海",@"重庆"];
    
    // 城市列表存到本地
    [cities keyedArchiverCityList];
    
    //解档
    NSArray *listArr = [NSArray KeyedUnArchiverCityList];
    NSLog(@"%@",listArr);
    
}
@end
