//
//  CZLabel.m
//  qq音乐播放器
//
//  Created by 凉凉 on 16/4/7.
//  Copyright © 2016年 凉凉. All rights reserved.
//

#import "CZLabel.h"

@implementation CZLabel

-(void)setProgress:(CGFloat)progress {

    _progress = progress;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
//    CGFloat labelHeight = [self sizeThatFits:CGSizeMake(self.frame.size.width, MAXFLOAT)].height;
//    int count = (int)(labelHeight / self.font.lineHeight);

    [[UIColor greenColor] setFill];
    UIRectFillUsingBlendMode(CGRectMake(0, 0, _progress * rect.size.width, rect.size.height), kCGBlendModeSourceIn);
}


@end
