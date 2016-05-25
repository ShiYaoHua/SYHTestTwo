//
//  AppDelegate.h
//  MineDemo
//
//  Created by shiyaohua on 16/4/21.
//  Copyright © 2016年 shiyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>
/**
 刷新或续期access_token使用
 接口说明
 access_token是调用授权关系接口的调用凭证，由于access_token有效期（目前为2个小时）较短，当access_token超时后，可以使用refresh_token进行刷新，access_token刷新结果有两种：
 
 1.若access_token已超时，那么进行refresh_token会获取一个新的access_token，新的超时时间；
 
 2.若access_token未超时，那么进行refresh_token不会改变access_token，但超时时间会刷新，相当于续期access_token。
 
 refresh_token拥有较长的有效期（30天），当refresh_token失效的后，需要用户重新授权，所以，请开发者在refresh_token即将过期时（如第29天时），进行定时的自动刷新并保存好它。
 */
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSString *weixinToken;
@property (nonatomic, strong) NSString *weixinOpenID;
@property (nonatomic, strong) NSString *weixinRefreshToken;

@end

