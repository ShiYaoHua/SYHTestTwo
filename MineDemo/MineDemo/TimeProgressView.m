//
//  TimeProgressView.m
//  MineDemo
//
//  Created by shiyaohua on 16/4/26.
//  Copyright © 2016年 shiyaohua. All rights reserved.
//

#import "TimeProgressView.h"
#import "CircleProgressView.h"

int countDown;

@interface TimeProgressView ()
{
     CircleProgressView *progressView;
}
/**倒计时计时器*/
@property (strong,nonatomic) NSTimer *timer;
/**倒计时*/
@property (strong, nonatomic) UILabel *timeLab;

@end

@implementation TimeProgressView

- (id)init
{
    self = [super init];
    if (self) {
        [self showProgress];
        
        [self startTimer];
    }
    return self;
}
/**时间进度圈*/
- (void)showProgress{
    
    UIView *superview = self;
    int padding = 100;
    
    //进度圈
    progressView = [[CircleProgressView alloc]initWithFrame:CGRectMake(70, 50, 100, 100)];
    progressView.progressColor = [UIColor redColor];
    progressView.progressStrokeWidth = 10.f;
    progressView.progressTrackColor = [UIColor orangeColor];
    [self addSubview:progressView];
    
    //倒计时
    self.timeLab = UILabel.new;
    self.timeLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.timeLab];
    
    //倒计时约束
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.mas_top).with.offset(300);
        make.left.equalTo(superview.mas_left).offset(padding);
        make.right.equalTo(superview.mas_right).offset(-padding);

    }];
}
/**计时器初始化*/
- (void)startTimer{
    
    // 生成计时器/开始计时器并持有
    countDown = 3600;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeProgressValue:) userInfo:nil  repeats:YES];
    
}
/**倒计时*/
- (void)changeProgressValue:(NSTimer *)timer{
    
    if (countDown <= 0)
    {
        [self.timer invalidate];
        //答题结束
        
        // 如果计时器在运行
        if ([self.timer isValid])
        {
            //停止并置为空
            [self.timer invalidate];
            self.timer = nil;
        }
        
    }else
    {
        int hour = countDown %  60 /  60;
        int second = countDown %  60;
        int mini = countDown / 60;
        self.timeLab.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hour, mini, second];
        progressView.progressValue = 1-countDown/3600.0;
        countDown--;
    }
}


@end
