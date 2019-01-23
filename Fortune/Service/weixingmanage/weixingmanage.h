//
//  weixingmanage.h
//  weixingdemo
//
//  Created by 王云晨 on 16/4/6.
//  Copyright © 2016年 王云晨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface weixingmanage : NSObject<NSURLSessionDataDelegate,NSURLSessionDelegate>
@property (nonatomic, strong)NSURLSession *session;
+ (weixingmanage *)sharedWixing;
- (void)paystar:(NSString *)payurl;

- (void)paystarForDic:(NSDictionary *)dic;

- (void)paystarwithApp:(NSString *)WXappid WXkey:(NSString *)WXkey mch_id:(NSString *)mch_id prise:(NSString *)prise orderName:(NSString *)orderName withOrderId:(NSString *)withOrderId;
@end
