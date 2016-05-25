//
//  TestView.m
//  MineDemo
//
//  Created by shiyaohua on 16/5/25.
//  Copyright © 2016年 shiyaohua. All rights reserved.
//

#import "TestView.h"

@implementation TestView


- (id)init {
    self = [super init];
    if (!self) return nil;
    [self initLabel];
    return self;
}
- (void)initLabel{
    
    // 字符串
    NSString *str = @"日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，从容幽静，自在安然。一直向往走进青的山，碧的水，体悟山水的绚丽多姿，领略草木的兴衰荣枯，倾听黄天厚土之声，探寻宇宙自然的妙趣。走进了山水，也就走出了喧嚣，给身心以清凉，给精神以沉淀，给灵魂以升华。";
    
    // 初始化label
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor whiteColor];
    [self addSubview:label];
    
    // label获取字符串
    label.text = str;
    
    // label获取字体
    label.font = [UIFont systemFontOfSize:15];
    
    // 根据获取到的字符串以及字体计算label需要的size
    CGSize retSize = [label.text boundingRectWithSize:CGSizeMake(UIScreenBounds.size.width, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:label.font} context:nil].size;
    // 设置无限换行
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    // 设置label的frame
    label.frame = CGRectMake(0.0f, 100.0f,retSize.width, retSize.height);
}

@end
