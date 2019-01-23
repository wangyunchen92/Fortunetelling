//
//  weixingmanage.m
//  weixingdemo
//
//  Created by 王云晨 on 16/4/6.
//  Copyright © 2016年 王云晨. All rights reserved.
//

#import "weixingmanage.h"
#import "WXApi.h"
#import "payRequsestHandler.h"
@implementation weixingmanage



+ (weixingmanage *)sharedWixing
{
    static dispatch_once_t onceToken;
    static weixingmanage *Weixingmanage;
    dispatch_once(&onceToken ,^{
      Weixingmanage=[[weixingmanage alloc]init];
        [Weixingmanage initialize];
    });
    return Weixingmanage;
}

- (void)initialize{
    NSURLSessionConfiguration *congiguration=[NSURLSessionConfiguration defaultSessionConfiguration];
    self.session=[NSURLSession sessionWithConfiguration:congiguration delegate:self delegateQueue:nil ];
    
}

- (void)paystar:(NSString *)payurl
{
//    /**
//     *  页面跳转
//     */
//    NSArray *array = [[UIApplication sharedApplication] windows];
//    UIWindow* win=[array objectAtIndex:0];
//    [win setHidden:NO];
    
    
    //解析服务端返回json数据
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:payurl]];
    //将请求的url数据放到NSData对象中
    NSURLSessionDataTask *downtest=[self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        if ( data != nil) {
            NSMutableDictionary *dict = NULL;
            //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
            dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            
            NSLog(@"url:%@",payurl);
            if(dict != nil){
                NSMutableString *retcode = [dict objectForKey:@"retcode"];
                if (retcode.intValue == 0){
                    NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                    
                    //调起微信支付
                    PayReq* req             = [[PayReq alloc] init];
                    req.partnerId           = [dict objectForKey:@"partnerid"];
                    /** 商家向财付通申请的商家id */
                    req.prepayId            = [dict objectForKey:@"prepayid"];
                    /** 预支付订单 */
                    req.nonceStr            = [dict objectForKey:@"noncestr"];
                    /** 随机串，防重发 */
                    req.timeStamp           = stamp.intValue;
                    /** 时间戳，防重发 */
                    req.package             = [dict objectForKey:@"package"];
                    /** 商家根据财付通文档填写的数据和签名 */
                    req.sign                = [dict objectForKey:@"sign"];
                    /** 商家根据微信开放平台文档对数据做的签名 */
                    [WXApi sendReq:req];
                    //日志输出
                    NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
                    
                    
                }
            }
        }
        
    }];
    
    [downtest resume];
}


- (void)paystarForDic:(NSDictionary *)dict {
    
        NSMutableString *retcode = [dict objectForKey:@"retcode"];
        if (retcode.intValue == 0){
            NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
            
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.partnerId           = [dict objectForKey:@"partnerid"];
            /** 商家向财付通申请的商家id */
            req.prepayId            = [dict objectForKey:@"prepayid"];
            /** 预支付订单 */
            req.nonceStr            = [dict objectForKey:@"noncestr"];
            /** 随机串，防重发 */
            req.timeStamp           = stamp.intValue;
            /** 时间戳，防重发 */
            req.package             = [dict objectForKey:@"package_val"];
            /** 商家根据财付通文档填写的数据和签名 */
            req.sign                = [dict objectForKey:@"sign"];
            /** 商家根据微信开放平台文档对数据做的签名 */
            [WXApi sendReq:req];
            //日志输出
            NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
            
            
        }
    
}


/**
 *  前端支付
 *
 *  @param WXappid     微信id
 *  @param WXkey       weixkey
 *  @param prise       价格
 *  @param orderName   商品名称
 *  @param withOrderId 商品id
 */
- (void)paystarwithApp:(NSString *)WXappid WXkey:(NSString *)WXkey mch_id:(NSString *)mch_id prise:(NSString *)prise orderName:(NSString *)orderName withOrderId:(NSString *)OrderId;
{
    payRequsestHandler *req = [payRequsestHandler alloc];

    //初始化支付签名对象
    [req init:WXappid mch_id:@"1282197501"];
    //设置密钥
    [req setKey:WXkey];
    
    //}}}
    
    //获取到实际调起微信支付的参数后，在app端调起支付
    //    NSString *priseStr = [NSString stringWithFormat:@"%.2f",0.01]; //商品价格
    //    NSString *prise = [NSString stringWithFormat:@"%.0f", priseStr.doubleValue*100]; //商品价格
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    dict = [req sendPay_demoWith:orderName withOrderId:OrderId withPrise:prise];
    
    if(dict == nil){
        
        // 错误提示
        NSString *debug = [req getDebugifo];
        
        
    }else{
        
        
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        
        // 调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = [dict objectForKey:@"appid"];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [dict objectForKey:@"package_val"];
        req.sign                = [dict objectForKey:@"sign"];
        
        [WXApi sendReq:req];
        //日志输出
        NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
    }
    
    

    
}


@end


