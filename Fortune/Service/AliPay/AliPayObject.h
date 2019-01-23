//
//  AliPayObject.h
//  支付宝支付Demo
//
//  Created by aaa on 16/2/25.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^Callback) (id obj);//一个返回值的Block
@interface AliPayObject : NSObject

//传入订单号orderID、商品名称、商品描述、商品价格
+ (void)CreateALiPayWithOrderID:(NSString *)orderID orderName:(NSString *)orderName orderDescription:(NSString *)orderDescription orderPrice:(NSString *)orderPrice andpartner:(NSString *)partner seller:(NSString *)seller privateKey:(NSString *)privateKey  appScheme:(NSString *)appScheme backurl:(NSString *)backurl andScallback:(Callback)scallback;

+ (void)CreateAliPayWithSigin:(NSString *)sigin appScheme:(NSString *)appScheme andScallback:(Callback)scallback;

@end
//
//
//#pragma -mark 支付宝回调
//- (BOOL)application:(UIApplication *)application
//openURL:(NSURL *)url
//sourceApplication:(NSString *)sourceApplication
//annotation:(id)annotation {
//    //跳转支付宝钱包进行支付，处理支付结果
//    if ([url.host isEqualToString:@"safepay"]) {
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            NSLog(@"result = %@",resultDic);
//        }];
//    }
//    return YES;
//    
//}
//
//// NOTE: 9.0以后使用新API接口
//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
//{
//    if ([url.host isEqualToString:@"safepay"]) {
//        // 支付跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            NSLog(@"result = %@",resultDic);
//        }];
//        
//        // 授权跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
//            NSLog(@"result = %@",resultDic);
//            // 解析 auth code
//            NSString *result = resultDic[@"result"];
//            NSString *authCode = nil;
//            if (result.length>0) {
//                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
//                for (NSString *subResult in resultArr) {
//                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
//                        authCode = [subResult substringFromIndex:10];
//                        break;
//                    }
//                }
//            }
//            NSLog(@"授权结果 authCode = %@", authCode?:@"");
//        }];
//    }
//    return YES;
//}
