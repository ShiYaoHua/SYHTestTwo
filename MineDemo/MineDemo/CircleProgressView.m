//
//  CircleProgressView.m
//  MXY
//
//  Created by shiyaohua on 16/4/18.
//  Copyright © 2016年 Chinamobo. All rights reserved.
//

#import "CircleProgressView.h"

@interface CircleProgressView ()
{
    
    CAShapeLayer *backGroundLayer; //背景图层
    CAShapeLayer *frontFillLayer;      //用来填充的图层
    UIBezierPath *backGroundBezierPath; //背景贝赛尔曲线
    UIBezierPath *frontFillBezierPath;  //用来填充的贝赛尔曲线
    
    
}
@end

@implementation CircleProgressView
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUp];
        
    }
    return self;
    
}
/**
 *  初始化创建图层
 */
- (void)setUp
{
    //创建背景图层
    backGroundLayer = [CAShapeLayer layer];
    backGroundLayer.fillColor = nil;
    backGroundLayer.frame = self.bounds;
    
    //创建填充图层
    frontFillLayer = [CAShapeLayer layer];
    frontFillLayer.fillColor = nil;
    frontFillLayer.frame = self.bounds;
    
    
    [self.layer addSublayer:backGroundLayer];
    [self.layer addSublayer:frontFillLayer];
}

- (void)setProgressColor:(UIColor *)progressColor
{
    _progressColor = progressColor;
    frontFillLayer.strokeColor = progressColor.CGColor;
}

- (void)setProgressTrackColor:(UIColor *)progressTrackColor
{
    _progressTrackColor = progressTrackColor;
    backGroundLayer.strokeColor = progressTrackColor.CGColor;
    backGroundBezierPath = [UIBezierPath bezierPathWithArcCenter:self.center radius:(CGRectGetWidth(self.bounds)-self.progressStrokeWidth)/2.f startAngle:0 endAngle:M_PI*2
                                                       clockwise:YES];
    backGroundLayer.path = backGroundBezierPath.CGPath;
}

- (void)setProgressValue:(CGFloat)progressValue
{
    _progressValue = progressValue;
    frontFillBezierPath = [UIBezierPath bezierPathWithArcCenter:self.center radius:(CGRectGetWidth(self.bounds)-self.progressStrokeWidth)/2.f startAngle:-M_PI_4 endAngle:(2*M_PI)*progressValue-M_PI_4 clockwise:YES];
    frontFillLayer.path = frontFillBezierPath.CGPath;
}
- (void)setProgressStrokeWidth:(CGFloat)progressStrokeWidth
{
    _progressStrokeWidth = progressStrokeWidth;
    frontFillLayer.lineWidth = progressStrokeWidth;
    backGroundLayer.lineWidth = progressStrokeWidth;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
