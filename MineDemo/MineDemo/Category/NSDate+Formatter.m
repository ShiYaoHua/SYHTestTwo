//
//  NSDate+Formatter.m
//
//  Created by syh on 15/6/10.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "NSDate+Formatter.h"


@implementation NSDate (Formatter)


/**根据日期计算星期几*/
- (NSString *)weekFromDate
{
    NSArray *weekArray = @[@"",@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *componets = [calendar components:NSCalendarUnitWeekday fromDate:self];
    
    return weekArray[componets.weekday];
}
- (void)useExample{
    
    NSDate *date = [NSDate date];
    NSString *week = [date weekFromDate];
    NSLog(@"今天%@",week);

}
@end
