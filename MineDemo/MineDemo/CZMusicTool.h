//
//  CZMusicTool.h
//  qq音乐播放器
//
//  Created by 凉凉 on 16/4/5.
//  Copyright © 2016年 凉凉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CZMusicTool : NSObject

+(instancetype)shareMusicTool;
/// 播放
/// @param name 歌曲名称
-(void)playMusicWithMusicName:(NSString *)name;
/// 暂停
-(void)pause;
/// 歌曲总时长字符串
-(NSString *)durationMusicString;
/// 总时长
-(NSTimeInterval)durationMusic;
/// 当前播放时长
-(NSString *)currentTimeString;
/// 当前时长
-(NSTimeInterval)currentTime;
/// 进度
-(CGFloat)musicProgress;

@end
