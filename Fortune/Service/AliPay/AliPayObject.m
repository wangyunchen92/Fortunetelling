//
//  AliPayObject.m
//  支付宝支付Demo
//
//  Created by aaa on 16/2/25.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import "AliPayObject.h"
#import "APOrderInfo.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AlipaySDK/AlipaySDK.h>
#import "APRSASigner.h"


@implementation AliPayObject

+ (void)CreateALiPayWithOrderID:(NSString *)orderID orderName:(NSString *)orderName orderDescription:(NSString *)orderDescription orderPrice:(NSString *)orderPrice andpartner:(NSString *)partner seller:(NSString *)seller privateKey:(NSString *)privateKey  appScheme:(NSString *)appScheme backurl:(NSString *)backurl andScallback:(Callback)scallback
{

    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        return;
    }
    
    //生成商品信息
    APOrderInfo *order = [[APOrderInfo alloc] init];
    // NOTE: app_id设置
    order.app_id = partner;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    order.biz_content = [APBizContent new];
    
    order.biz_content.body = orderDescription;
    order.biz_content.subject = orderName;
    
    order.biz_content.out_trade_no = orderID; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f",[orderPrice floatValue]]; //商品价格
    order.return_url = backurl;
    order.charset = @"utf-8";
    order.notify_url = @"m.alipay.com";
    
    NSString *rsaPrivateKey = privateKey;
    NSString *rsa2PrivateKey = privateKey;
   
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    if (signedString != nil) {
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            //支付之后 返回的参数
            NSLog(@"reslut = %@",resultDic);
            
            //block返回支付完成之后的字典文件
            scallback(resultDic);
            
        }];
        
    }
}


+ (void)CreateAliPayWithSigin:(NSString *)sigin appScheme:(NSString *)appScheme andScallback:(Callback)scallback {
    //商家信息
    /**
     *  解决不能跳转的问题
     */
//    NSArray *array = [[UIApplication sharedApplication] windows];
//    UIWindow* win=[array objectAtIndex:0];
//    [win setHidden:NO];
//
//
    
    

    [[AlipaySDK defaultService] payOrder:sigin fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
        //支付之后 返回的参数
        NSLog(@"reslut = %@",resultDic);
        
        //block返回支付完成之后的字典文件
//                [win setHidden:YES];


        scallback(resultDic);

        
    }];
}



@end
