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

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSString *weixinToken;
@property (nonatomic, strong) NSString *weixinOpenID;


@end

