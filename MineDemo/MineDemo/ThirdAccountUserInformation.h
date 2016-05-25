//
//  ThirdAccountUserInformation.h
//  soho
//
//  Created by syh on 15/4/17.
//  Copyright (c) 2015年  All rights reserved.
//

/**
 第三方帐号信息模型
 */
#define WB @"WB"
#define QQ @"QQ"
#define WX @"WX"

#import <Foundation/Foundation.h>

@interface ThirdAccountUserInformation : NSObject

//微信

//普通用户的标识，对当前开发者帐号唯一
@property (nonatomic, strong) NSString *openid;
//普通用户昵称
@property (nonatomic, strong) NSString *nickname;
//普通用户性别，1为男性，2为女性
@property (nonatomic, strong) NSString *sex;
//普通用户个人资料填写的省份
@property (nonatomic, strong) NSString *province;
//普通用户个人资料填写的城市
@property (nonatomic, strong) NSString *city;
//国家，如中国为CN
@property (nonatomic, strong) NSString *country;
//用户头像，最后一个数值代表正方形头像大小（有0、46、64、96、132数值可选，0代表640*640正方形头像），用户没有头像时该项为空
@property (nonatomic, strong) NSString *headimgurl;
//用户特权信息，json数组，如微信沃卡用户为（chinaunicom）
@property (nonatomic, strong) NSString *privilege;
//用户统一标识。针对一个微信开放平台帐号下的应用，同一用户的unionid是唯一的。
@property (nonatomic, strong) NSString *unionid;

@property (nonatomic, strong) NSString *login_source;

+ (id)sharedInformation;

@end
