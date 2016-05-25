//
//  LoginView.m
//  MineDemo
//
//  Created by shiyaohua on 16/5/5.
//  Copyright © 2016年 shiyaohua. All rights reserved.
//

#import "LoginView.h"
//#import "WeiboSDK.h"
//#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "AppDelegate.h"
#import "NSString+Trim.h"
#import "ThirdAccountUserInformation.h"


/**验证码倒计时*/
int registerCountDown = 59;

@interface LoginView()
{

    NSArray * permissions;
    
}
/**手机号输入框*/
@property (weak, nonatomic) IBOutlet UITextField *telephoneNumberTextField;
/**验证码输入框*/
@property (weak, nonatomic) IBOutlet UITextField *identifyingCodeTextField;
/**倒计时显示*/
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;
/**请求得到的验证码*/
@property (strong,nonatomic) NSString *identifyingCode;
/**获取验证码按钮*/
@property (weak, nonatomic) IBOutlet UIButton *identifyingCodeButton;
/**登录按钮*/
@property (weak, nonatomic) IBOutlet UIButton *commitButton;
/**获取验证码事件*/
- (IBAction)identifyingCode:(id)sender;
/**登录按钮事件*/
- (IBAction)commit:(id)sender;
/**勾选按钮*/
@property (weak, nonatomic) IBOutlet UIButton *selectedButton;
/**倒计时计时器*/
@property (strong,nonatomic) NSTimer *timer;
/**勾选服务条款事件*/
- (IBAction)selectedButtonPressed:(UIButton *)sender;


@end

@implementation LoginView

- (id)init
{
    self = [super init];
    if (self) {
        
        [self initView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
        
        //微信登录成功后的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weixinDidSuccessLogin:) name:WeiXinSuccessLoginNotification object:nil];

    }
    return self;
}


/**程序从后台回到前台*/
- (void)EnterForeground
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSTimeInterval time = [[userDefault objectForKey:@"EnterBgTime"] integerValue];
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval subTime = nowTime - time;
    if (subTime > registerCountDown) {
        registerCountDown = 0;
    } else {
        registerCountDown = registerCountDown - subTime;
    }
}
/**初始化界面*/
- (void)initView
{
    self.selectedButton.selected = YES;
    self.commitButton.layer.cornerRadius = 5;
    
    UITapGestureRecognizer *reconizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardDismiss)];
    [self addGestureRecognizer:reconizer];
}

/**键盘取消事件*/
- (void)keyboardDismiss
{
    [self.telephoneNumberTextField resignFirstResponder];
    [self.identifyingCodeTextField resignFirstResponder];
}

/**键盘收回*/
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)dismissKeyboard{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

/**获取验证码事件*/
- (IBAction)identifyingCode:(id)sender {
    /** 键盘消失*/
    [self dismissKeyboard];
    
    /**手机号不能为空*/
    if ([NSString trimWhitespace:self.telephoneNumberTextField.text].length == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    /**判断手机号是否符合*/
    else if([self isValidPhoneNum:self.telephoneNumberTextField.text])
    {
        /**不是正确的手机号*/
        [SVProgressHUD showErrorWithStatus:@"手机号输入有误，请重新输入"];
        return;
    }
    self.telephoneNumberTextField.enabled = NO;
    
    registerCountDown = 59;
    
}

/**计时器初始化*/
- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:nil  repeats:YES];
}

/**倒计时60S*/
- (void)countDown:(NSTimer *)timer
{
    if (registerCountDown <= 0)
    {
        registerCountDown = 59;
        
        self.identifyingCodeButton.enabled = YES;
        self.telephoneNumberTextField.enabled = YES;
        
        self.countDownLabel.text = @"重新获取";
        
        [self.timer invalidate];
        self.timer = nil;
        
    }else
    {
        self.countDownLabel.text = [NSString stringWithFormat:@"%d%@",registerCountDown,@"秒"];
        registerCountDown --;
    }
}

- (BOOL)checkFrom {
    /**手机号或验证码不能为空*/
    if (([NSString trimWhitespace:self.telephoneNumberTextField.text].length == 0) || ([NSString trimWhitespace:self.identifyingCodeTextField.text].length == 0))
    {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号/验证码"];
        return NO;
    }
    
    /** 判断手机号是否符合*/
    if([self isValidPhoneNum:self.telephoneNumberTextField.text])
    {
        /** 不是正确的手机号*/
        [SVProgressHUD showErrorWithStatus:@"手机号输入有误，请重新输入"];
        return NO;
    }
    
    return YES;
}

/**登录按钮事件*/
- (IBAction)commit:(id)sender {
    [self dismissKeyboard];
    /** 验证消息*/
    if (![self checkFrom]) return;
    
//    APIUserPlugin *ud = [API sharedInstance].user;
//    [ud loginWithPhone:self.telephoneNumberTextField.text andCode:self.identifyingCodeTextField.text success:^{
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
}

/**勾选服务条款事件*/
- (IBAction)selectedButtonPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    self.commitButton.enabled = sender.selected;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)weixinLogin:(id)sender {
    
    
    // 如果手机没有安装微信或版本不支持，提示用户安装
//    if (![WXApi isWXAppInstalled] || ![WXApi isWXAppSupportApi])
//    {
//        [SVProgressHUD showErrorWithStatus:@"请先安装微信客户端"];
//        return;
//    }
    
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"wechat://"]]){
        [SVProgressHUD showErrorWithStatus:@"请先安装微信客户端"];
        return;
    }
    
    
    SendAuthReq *req = [[SendAuthReq alloc] init];
//    req.scope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact";
    /**
     snsapi_base:
     /sns/oauth2/access_token   通过code换取access_token、refresh_token和已授权scope
     /sns/oauth2/refresh_token	刷新或续期access_token使用
     /sns/auth                  检查access_token有效性
     
     snsapi_userinfo:
     /sns/userinfo              获取用户个人信息
     */
    req.scope = @"snsapi_base,snsapi_userinfo"; //接口作用域（scope）
    req.state = @"222"; // 用来回传
    [WXApi sendReq:req]; // 打开微信客户端
}

#pragma mark - weixin登陆成功调用
- (void)weixinDidSuccessLogin:(NSNotification *)noti
{
    
    ThirdAccountUserInformation *third = [ThirdAccountUserInformation sharedInformation];
    
    [self thirdLoginSuccesswithLoginSource:third.login_source openID:third.openid];
}


#pragma mark - 第三方登录成功后
/**第三方登陆服务*/
-(void)thirdLoginSuccesswithLoginSource:(NSString *)source openID:(NSString *)openID
{
    DLog(@"openID = %@ source = %@",openID,source);
    
}
/**判断手机号码，11位数并且以1开头*/
- (BOOL)isValidPhoneNum:(NSString *)sender {
    NSString *phoneNumber = sender;
    NSString *phoneRegex = @"^1\\d{10}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [test evaluateWithObject:phoneNumber];
}
@end
