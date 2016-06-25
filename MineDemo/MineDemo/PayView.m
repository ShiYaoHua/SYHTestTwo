////
////  PayView.m
////  MineDemo
////
////  Created by gutrip on 16/6/19.
////  Copyright © 2016年 shiyaohua. All rights reserved.
////
//
#import "PayView.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"


@interface PayView ()

////支付宝支付按钮
//@property (weak, nonatomic) IBOutlet UIButton *zhifubao;
////微信支付按钮
//@property (weak, nonatomic) IBOutlet UIButton *weixinBtn;

@end

@implementation PayView
//
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        [self initMethod];
//        
//    }
//    return self;
//}
//
//- (void)initMethod{
//    
//    Order *order = [[Order alloc] init];
//    order.partner = partner;
//    order.seller = seller;
//    order.tradeNO = [self generateTradeNO]; //订单ID（由商家?自?行制定）
//    order.productName = product.subject; //商品标题
//    order.productDescription = product.body; //商品描述
//    order.amount = [NSString stringWithFormat:@"%.2f",product.price]; //商
//    品价格
//    order.notifyURL = @"http://www.test.com"; //回调URL
//    order.service = @"mobile.securitypay.pay";
//    order.paymentType = @"1";
//    order.inputCharset = @"utf-8";
//    order.itBPay = @"30m";
//    
//    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
//    NSString *appScheme = @"alisdkdemo";
//    
//    //将商品信息拼接成字符串
//    NSString *orderSpec = [order description];
//    NSLog(@"orderSpec = %@",orderSpec);
//    
//    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(privateKey);
//    NSString *signedString = [signer signString:orderSpec];
//    
//    //将签名成功字符串格式化为订单字符串,请严格按照该格式
//    NSString *orderString = nil;
//    if (signedString != nil) {
//        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                       orderSpec, signedString, @"RSA"];
//        
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            //【callback处理支付结果】
//            NSLog(@"reslut = %@",resultDic);
//        }];
//        
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    }
//
//}
@end
