//
//  CZMusicModel.h
//  qq音乐播放器
//
//  Created by 凉凉 on 16/4/5.
//  Copyright © 2016年 凉凉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZMusicModel : NSObject

@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *lrc;
@property (nonatomic, copy) NSString *mp3;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *singer;
@property (nonatomic, copy) NSString *zhuanji;
@property (nonatomic, assign) NSNumber *type;
@end
