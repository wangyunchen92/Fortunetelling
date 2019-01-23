//
//  ProductPayViewModel.h
//  Fortune
//
//  Created by Sj03 on 2018/6/29.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductDetailModel.h"

@interface ProductPayViewModel : NSObject
@property (nonatomic, strong)ProductDetailModel *model;
@property (nonatomic, copy)NSString *productID;
@property (nonatomic, assign)NSInteger num;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *phone;
@property (nonatomic, copy)NSString *address;
@property (nonatomic, copy)NSString *note;
@property (nonatomic, assign)NSInteger payState; // 1微信 2 支付宝
@property (nonatomic, copy)NSString *choseAddress;
@property (nonatomic, strong)RACSubject *subject_pay;

@property (nonatomic, copy)void (^block_alipay)(NSString *sigin);
@property (nonatomic, copy)void (^block_weixinpay)(NSDictionary *str);



@end
