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
