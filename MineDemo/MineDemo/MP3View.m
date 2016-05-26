//
//  MP3View.m
//  MineDemo
//
//  Created by gutrip on 16/5/26.
//  Copyright © 2016年 shiyaohua. All rights reserved.
//

#import "MP3View.h"
#import <MediaPlayer/MediaPlayer.h>
#import "YYModel.h"
#import "MJExtension.h"

#import "CZMusicModel.h"
#import "CZMusicTool.h"
#import "CZLyricTool.h"
#import "CZLrcModel.h"
#import "CZLabel.h"

#define kLrcLineHeight 44

@interface MP3View ()

@property (weak, nonatomic) IBOutlet UIButton *play;

@property (weak, nonatomic) IBOutlet UIButton *pause;

@property (nonatomic, strong) NSArray *allMusics;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) NSInteger currentLrcIndex;

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
/** 顶部的分组视图 */
@property (weak, nonatomic) IBOutlet UIView *groupView;
// 专辑
@property (weak, nonatomic) IBOutlet UILabel *zhuanjiNameLabel;
// 歌手
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;
// 歌词
@property (weak, nonatomic) IBOutlet CZLabel *lrcLabel;
/** 当前播放时间的label */
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
/** 专辑图片的View */
@property (weak, nonatomic) IBOutlet UIImageView *zhuanjiImageView;
/** 进度条的视图 */
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
/** 总时间的Label */
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *lrcScrollView;

//一首歌的所有行的歌词
@property (nonatomic, strong) NSArray *allLrcLines;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MP3View

-(NSArray *)allMusics {
    
    if (_allMusics == nil) {
        _allMusics = [CZMusicModel mj_objectArrayWithFilename:@"mlist.plist"];
    }
    return _allMusics;
}
- (void)awakeFromNib{
    
    //UI界面的 玻璃效果
    UIToolbar *bar = [[UIToolbar alloc]init];
    bar.barStyle = UIBarStyleBlack;
    bar.translucent = YES;
    //禁止掉 Autoresizing
    bar.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.backImageView addSubview:bar];
    
    NSArray *consH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bar]-0-|" options:0 metrics:nil views:@{@"bar" : bar}];
    NSArray *consV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[bar]-0-|" options:0 metrics:nil views:@{@"bar" : bar}];
    
    //添加约束原则?
    [self.backImageView addConstraints:consH];
    [self.backImageView addConstraints:consV];
    //设置导航栏
//    self.superview.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//    self.superview.navigationController.navigationBar.translucent = YES;
    
    [self clickPlay];
    // 锁屏
    [[UIApplication sharedApplication] becomeFirstResponder];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];  
}
- (instancetype)init
{
    self = [super init];
    if (self) {
              
    }
    return self;
}
-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)viewDidLayoutSubviews {
    
    self.scrollView.contentSize = CGSizeMake(self.groupView.bounds.size.width * 2, 0);
    
    self.scrollView.pagingEnabled = YES;
    
    [self.lrcScrollView setContentSize:CGSizeMake(0, self.allLrcLines.count *kLrcLineHeight)];
    [self.lrcScrollView setContentInset:UIEdgeInsetsMake(100, 0, self.lrcScrollView.bounds.size.height * 0.5 , 0)];
}
#pragma mark - 播放器操作
// 点击播放
- (IBAction)clickPlay {
    // 界面逻辑
    self.play.hidden = YES;
    self.pause.hidden = NO;
    
    CZMusicModel *model = self.allMusics[self.index];
    
    [[CZMusicTool shareMusicTool] playMusicWithMusicName:model.mp3];
    
//    self.superview.navigationItem.title = model.name;
    self.singerLabel.text = model.singer;
    self.zhuanjiNameLabel.text = model.zhuanji;
    self.zhuanjiImageView.image = [UIImage imageNamed:model.image];
    self.backImageView.image = [UIImage imageNamed:model.image];
    self.totalTimeLabel.text = [[CZMusicTool shareMusicTool] durationMusicString];
    self.allLrcLines = [CZLyricTool lyricListWithName:model.lrc];
    
    // 设置全屏歌词
    [self updateLrcLineLabelForScrollView];
    [self addMusicTimer];
}

// 点击暂停
- (IBAction)clickPause {
    self.play.hidden = NO;
    self.pause.hidden = YES;
    
    [[CZMusicTool shareMusicTool] pause];
    [self.timer invalidate];
    self.timer = nil;
    
}
// 点击上一曲
- (IBAction)clickPer {
    
    self.index = self.index == 0 ? self.allMusics.count - 1 : self.index - 1;
    [self clickPause];
    [self clickPlay];
    
}
// 点击下一曲
- (IBAction)clickNext {
    
    self.index = self.index == self.allMusics.count - 1 ? 0 : self.index + 1;
    [self clickPause];
    [self clickPlay];
}
// 定时器
-(void)addMusicTimer {
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0/30.0 target:self selector:@selector(updatePerSecond) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}
// 每秒执行一次
-(void)updatePerSecond{
    
    self.lrcLabel.text = @"音乐播放器";
    
    self.currentTimeLabel.text = [[CZMusicTool shareMusicTool] currentTimeString];
    
    self.progressView.progress = [[CZMusicTool shareMusicTool] musicProgress];
    
    NSTimeInterval currentTime = [[CZMusicTool shareMusicTool] currentTime];
    
    for (int i = 0; i < self.allLrcLines.count; i++) {
        
        CZLrcModel *cureetModel = self.allLrcLines[i];
        
        CZLrcModel *nextModel = nil;
        if (i == self.allLrcLines.count - 1) {
            nextModel = self.allLrcLines[i];
        }else {
            nextModel = self.allLrcLines[i+1];
        }
        if (currentTime >= cureetModel.time && currentTime < nextModel.time ) {
            
            self.lrcLabel.text = cureetModel.text;
            
            self.currentLrcIndex = i;
            
            self.lrcLabel.progress =  (currentTime-cureetModel.time)/(nextModel.time - cureetModel.time);
            
            for (id objec in self.lrcScrollView.subviews) {
                
                if ([objec isKindOfClass:[CZLabel class]]) {
                    CZLabel *Label = (CZLabel *)objec;
                    if (Label.currentIndex == i ) {
                        Label.progress = self.lrcLabel.progress;
                        Label.font = [UIFont systemFontOfSize:18];
                    }else {
                        Label.progress = 0;
                        Label.font = [UIFont systemFontOfSize:15];
                    }
                }
            }
        }
    }
    //锁屏界面 显示歌曲基本信息    每一行歌词
    //锁屏显示每一行歌词信息 实时更新
    [self updateScreenMusicInfo];
    
    [self.lrcScrollView setContentOffset:CGPointMake(0, -100 + kLrcLineHeight * self.currentLrcIndex)];
}
// 更新全屏歌词
-(void)updateLrcLineLabelForScrollView {
    
    for (id obje in self.lrcScrollView.subviews) {
        if ([obje isKindOfClass:[CZLabel class]]) {
            
            [obje removeFromSuperview];
        }
    }
    
    for (int i = 0; i < self.allLrcLines.count; i++) {
        
        CZLrcModel *lrcModel = self.allLrcLines[i];
        
        CZLabel *label = [[CZLabel alloc]init];
        
        label.currentIndex = i;
        
        label.text = lrcModel.text;
        
        label.textColor = [UIColor whiteColor];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        [self.lrcScrollView addSubview:label];
        
        // 设置约束
        label.translatesAutoresizingMaskIntoConstraints = NO;
        NSArray *labelH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[label]" options:0 metrics:nil views:@{@"label" : label}];
        NSArray *labelV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[label]" options:0 metrics:@{@"margin" : @(kLrcLineHeight * i)} views:@{@"label" : label}];
        NSLayoutConstraint *labelW = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.lrcScrollView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
        
        [self.lrcScrollView addConstraints:labelH];
        [self.lrcScrollView addConstraints:labelV];
        [self.lrcScrollView addConstraint:labelW];
        
    }
}
//锁屏界面 显示歌曲基本信息
-(void)updateScreenMusicInfo {
    
    MPNowPlayingInfoCenter *infoCenter = [MPNowPlayingInfoCenter defaultCenter];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    CZMusicModel *music = self.allMusics[_index];
    
    //初始化   给他 专辑图片  播放时间进度
    //歌手名称
    dict[MPMediaItemPropertyAlbumTitle]= music.zhuanji;
    dict[MPMediaItemPropertyArtist]= music.singer;
    dict[MPMediaItemPropertyTitle]= music.name;
    //设置当前时间
    dict[MPNowPlayingInfoPropertyElapsedPlaybackTime]=@([[CZMusicTool shareMusicTool] currentTime]);
    
    //总时间
    dict[MPMediaItemPropertyPlaybackDuration]= @([[CZMusicTool shareMusicTool]durationMusic]);
    
    // 开启上下文
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 20, [UIScreen mainScreen].bounds.size.width - 20);
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, [UIScreen mainScreen].scale);
    
    UIImage *sourceImage = [UIImage imageNamed:music.image];
    
    [sourceImage drawInRect:rect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    dict[MPMediaItemPropertyArtwork] = [[MPMediaItemArtwork alloc]initWithImage:newImage];
    
    infoCenter.nowPlayingInfo = dict;
}

-(void)remoteControlReceivedWithEvent:(UIEvent *)event {
    
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlPlay:
            [self clickPlay];
            break;
        case UIEventSubtypeRemoteControlPause:
            [self clickPause];
            break;
        case UIEventSubtypeRemoteControlPreviousTrack:
            [self clickPer];
            break;
        case UIEventSubtypeRemoteControlNextTrack:
            [self clickNext];
            break;
            
        default:
            break;
    }
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    [self clickNext];
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.scrollView) {
        
        self.groupView.alpha = 1 - self.scrollView.contentOffset.x / self.groupView.bounds.size.width;
    }
}

@end
