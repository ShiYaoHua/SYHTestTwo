//
//  ThirdAccountUserInformation.h
//  soho
//
//  Created by liujian on 15/4/17.
//  Copyright (c) 2015年 Chinamobo. All rights reserved.
//

/**
 第三方帐号信息模型
 */
#define WB @"WB"
#define QQ @"QQ"
#define WX @"WX"

#import <Foundation/Foundation.h>

@interface ThirdAccountUserInformation : NSObject
@property (nonatomic, strong) NSString *user_name;
@property (nonatomic, strong) NSString *login_source;
@property (nonatomic, strong) NSString *openID;
@property (nonatomic, strong) NSString * user_img;

+ (id)sharedInformation;
@end
