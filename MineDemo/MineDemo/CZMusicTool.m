//
//  CZMusicTool.m
//  qq音乐播放器
//
//  Created by 凉凉 on 16/4/5.
//  Copyright © 2016年 凉凉. All rights reserved.
//

#import "CZMusicTool.h"
#import <AVFoundation/AVFoundation.h>

@interface CZMusicTool ()
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, copy) NSString *currentName;
@property (nonatomic, assign) CGFloat musicProgre;

@end

@implementation CZMusicTool
// 单例
+(instancetype)shareMusicTool {
    static CZMusicTool *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CZMusicTool alloc]init];
        
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
    });
    return instance;
}
// 播放
-(void)playMusicWithMusicName:(NSString *)name {
    
    if (name == nil) {
        return;
    }
    
    NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:nil];
    
    if (path == nil) {
        return;
    }
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    if (![self.currentName isEqualToString:name]) {
        
        self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    }
    self.currentName = name;
    [self.player prepareToPlay];
    [self.player play];
}
// 暂停
-(void) pause {

    if (self.player.playing) {
        
        [self.player pause];
    }
}
/// 总时长字符串
-(NSString *)durationMusicString {
    
    return [NSString stringWithFormat:@"%02d:%02d",(int)self.player.duration / 60, (int)self.player.duration % 60];

}
/// 总时长
-(NSTimeInterval)durationMusic {

    return self.player.duration;
}
/// 返回当前时长字符串
-(NSString *)currentTimeString {
    
    return [NSString stringWithFormat:@"%02d:%02d",(int)self.player.currentTime / 60, (int)self.player.currentTime % 60];

}
/// 返回当前时长
-(NSTimeInterval)currentTime {

    return self.player.currentTime;

}

/// 当前进度
-(CGFloat)musicProgress {

    return self.player.currentTime / self.player.duration;
}

@end
