//
//  AliPayObject.m
//  支付宝支付Demo
//
//  Created by aaa on 16/2/25.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import "AliPayObject.h"
#import "Order.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"


@implementation AliPayObject

+ (void)CreateALiPayWithOrderID:(NSString *)orderID orderName:(NSString *)orderName orderDescription:(NSString *)orderDescription orderPrice:(NSString *)orderPrice andpartner:(NSString *)partner seller:(NSString *)seller privateKey:(NSString *)privateKey  appScheme:(NSString *)appScheme backurl:(NSString *)backurl andScallback:(Callback)scallback
{
    //商家信息
    /**
     *  解决不能跳转的问题
     */
    NSArray *array = [[UIApplication sharedApplication] windows];
    UIWindow* win=[array objectAtIndex:0];
    [win setHidden:NO];
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        return;
    }
    
    //生成商品信息
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    
    order.tradeNO = orderID; //订单ID（由商家自行制定）
    order.productName = orderName; //商品标题
    order.productDescription = orderDescription; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",[orderPrice floatValue]]; //商品价格
//    order.notifyURL = @"";

      order.notifyURL =  backurl; //回调URL
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    

   
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            //支付之后 返回的参数
            NSLog(@"reslut = %@",resultDic);
            
            //block返回支付完成之后的字典文件
            scallback(resultDic);
            [win setHidden:YES];
            
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
