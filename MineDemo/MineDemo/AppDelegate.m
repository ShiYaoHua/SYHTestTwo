//
//  AppDelegate.m
//  MineDemo
//
//  Created by shiyaohua on 16/4/21.
//  Copyright © 2016年 shiyaohua. All rights reserved.
//

#import "AppDelegate.h"
#import "MASExampleListViewController.h"
#import "ThirdAccountUserInformation.h"
#import <AlipaySDK/AlipaySDK.h>

/**微信好友*/
#define SHARE_WECHAR_F @"SHARE_WECHAR_F"
/**微信朋友圈*/
#define SHARE_WECHAR_C @"SHARE_WECHAR_C"

@interface AppDelegate ()

@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:MASExampleListViewController.new];
    self.window.rootViewController = navigationController;
    
    //注册微信
    [WXApi registerApp:@"wx85ee056177fbe8a5" withDescription:@"demo 2.0"];
    
    return YES;
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation{
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;

}
// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)application handleOpenURL:(nonnull NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
    
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    
    
    if ([url.host isEqualToString:@"safepay"]) {
        
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        return YES;
    }
    
    return [WXApi handleOpenURL:url delegate:self];
    
    
}
#pragma mark 微信登录
//是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返回。在调用sendRsp返回时，会切回到微信终端程序界面。
-(void)onReq:(BaseReq*)reqonReq{
    
}
//如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终端程序界面。
-(void)onResp:(BaseResp*)resp{
    
    if ([resp isKindOfClass:[PayResp class]]) { // 微信支付
        PayResp *response = (PayResp *)resp;
        switch (response.errCode) {
            case WXSuccess:{
                //服务器端查询支付通知或查询API返回的结果再提示成功
                NSLog(@"支付成功");
                NSNotification *notification = [NSNotification notificationWithName:ORDER_PAY_NOTIFICATION object:@"success"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
            }
            default:{
                NSLog(@"支付失败， retcode=%d",resp.errCode);
                NSNotification *notification1 = [NSNotification notificationWithName:ORDER_PAY_NOTIFICATION object:@"fail"];
                [[NSNotificationCenter defaultCenter] postNotification:notification1];
                break;
            }
        }
    } else if ([resp isKindOfClass:[SendMessageToWXResp class]]) { // 微信分享
        SendMessageToWXResp *response = (SendMessageToWXResp *)resp;
        switch (response.errCode) {
            case WXSuccess:{
                [SVProgressHUD showErrorWithStatus:@"分享成功"];
                
                break;
            }
            default:
                [SVProgressHUD showErrorWithStatus:@"分享失败"];
                break;
        }
    }else if ([resp isKindOfClass:[SendAuthResp class]]) // 微信登陆回调
    {
        if (resp.errCode == 0)
        {
            SendAuthResp *aresp = (SendAuthResp *)resp;
            if (aresp.errCode== 0)
            {
                NSString *code = aresp.code;   //code:用户换取access_token的code，仅在ErrCode为0时有效
                [self getWeiXinToken:code];
            }
        }
    }

}
// 利用code获取token
- (void)getWeiXinToken:(NSString *)code{
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",KWeiXinID,KWeiXinSecret,code];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url1 = [NSURL URLWithString:url];
        NSData *data = [NSData dataWithContentsOfURL:url1];
        //        NSData *data = [NSData dataWithContentsOfURL:url1 options:NSDataReadingMappedIfSafe error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"%@",dic);
                self.weixinToken = dic[@"access_token"];
                self.weixinRefreshToken = dic[@"refresh_token"];
                self.weixinOpenID = dic[@"openid"];
                [self getWeiXinUserInfo];
            }
        });
    });
   
}
// 利用code获取Refreshtoken
- (void)getWeiXinRefreshToken:(NSString *)code{
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=%@&grant_type=refresh_token&refresh_token=%@",KWeiXinID,self.weixinRefreshToken];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url1 = [NSURL URLWithString:url];
        NSData *data = [NSData dataWithContentsOfURL:url1];
        // NSData *data = [NSData dataWithContentsOfURL:url1 options:NSDataReadingMappedIfSafe error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"%@",dic);
                self.weixinToken = dic[@"access_token"];
                self.weixinRefreshToken = dic[@"refresh_token"];
                self.weixinOpenID = dic[@"openid"];
                [self getWeiXinUserInfo];
            }
        });
    });
    
}

//获取用户个人信息（UnionID机制）
/**
此接口用于获取用户个人信息。开发者可通过OpenID来获取用户基本信息。特别需要注意的是，如果开发者拥有多个移动应用、网站应用和公众帐号，可通过获取用户基本信息中的unionid来区分用户的唯一性，因为只要是同一个微信开放平台帐号下的移动应用、网站应用和公众帐号，用户的unionid是唯一的。换句话说，同一用户，对同一个微信开放平台下的不同应用，unionid是相同的。请注意，在用户修改微信头像后，旧的微信头像URL将会失效，因此开发者应该自己在获取用户信息后，将头像图片保存下来，避免微信头像URL失效后的异常情况。
 */
-(void)getWeiXinUserInfo{
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",self.weixinToken,self.weixinOpenID];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                ThirdAccountUserInformation *third = [ThirdAccountUserInformation sharedInformation];
                third.openid = self.weixinOpenID;
                third.nickname = [dic objectForKey:@"nickname"];
                third.sex = [dic objectForKey:@"sex"];
                third.province = [dic objectForKey:@"province"];
                third.city = [dic objectForKey:@"city"];
                third.country = [dic objectForKey:@"country"];
                third.headimgurl = dic[@"headimgurl"];
                third.privilege = [dic objectForKey:@"privilege"];
                third.unionid = [dic objectForKey:@"unionid"];
                third.login_source = WX;

                [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:WeiXinSuccessLoginNotification object:nil]];
                
            }
        });
        
    });
}


// 如果你的程序要发消息给微信，那么需要调用WXApi的sendReq函数：其中req参数为SendMessageToWXReq类型 需要注意的是，SendMessageToWXReq的scene成员，如果scene填WXSceneSession，那么消息会发送至微信的会话内。如果scene填WXSceneTimeline，那么消息会发送至朋友圈。如果scene填WXSceneFavorite,那么消息会发送到“我的收藏”中。scene默认值为WXSceneSession。

-(BOOL)sendReq:(BaseReq*)req{
    NSLog(@"%@",req);

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
