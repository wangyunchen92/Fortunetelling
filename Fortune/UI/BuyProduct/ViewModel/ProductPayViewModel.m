//
//  ProductPayViewModel.m
//  Fortune
//
//  Created by Sj03 on 2018/6/29.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "ProductPayViewModel.h"

@implementation ProductPayViewModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _productID = @"";
        _num = 0;
        _name = @"";
        _phone = @"";
        _address = @"";
        _note = @"";
        _choseAddress = @"";
        _subject_pay = [[RACSubject alloc] init];
        [self initPaySubject];
    }
    return self;
}

- (void)initPaySubject {
    
    [self.subject_pay subscribeNext:^(id x) {
        HttpRequestMode *model = [[HttpRequestMode alloc]init];
        NSMutableDictionary *program = [[NSMutableDictionary alloc] init];
//        [program addUnEmptyString:self.key forKey:@"id"];
        model.name= @"预支付订单";
        model.parameters = program;
        [program addUnEmptyString:[ToolUtil dy_getDeviceUUID] forKey:@"imei"];
        [program addUnEmptyString:[ToolUtil dy_getDeviceUUID] forKey:@"uuid"];
        [program addUnEmptyString:self.productID forKey:@"product_id"];
        [program addUnEmptyString:self.name forKey:@"name"];
        [program addUnEmptyString:self.phone forKey:@"mobile"];
        [program addUnEmptyString:[NSString stringWithFormat:@"%@%@",self.choseAddress,self.address] forKey:@"address"];
        if (self.payState == 1) {
            [program addUnEmptyString:@"wx" forKey:@"pay_type"];
        } else if (self.payState == 2) {
            [program addUnEmptyString:@"ali" forKey:@"pay_type"];
        }

        [program addUnEmptyString:[NSString stringWithFormat:@"%ld",self.num] forKey:@"num"];
        [program addUnEmptyString:self.note forKey:@"remark"];
        model.url = SaveShopOrder;
        [BasePopoverView showHUDToWindow:YES withMessage:@"加载中..."];
        [[HttpClient sharedInstance] requestApiWithHttpRequestMode:model Success:^(HttpRequest *request, HttpResponse *response) {
            [BasePopoverView hideHUDForWindow:YES];
            NSDictionary *dic = response.result;
            ProductDetailModel *model = [[ProductDetailModel alloc] init];
            [model getModelForServer:dic];
            if (self.block_alipay && self.payState == 2) {
                self.block_alipay(response.result[@"object"]);
            }
            if (self.block_weixinpay && self.payState == 1) {
                self.block_weixinpay(response.result);
            }
            self.model = model;
            
        } Failure:^(HttpRequest *request, HttpResponse *response) {
            [BasePopoverView hideHUDForWindow:YES];
            [BasePopoverView showFailHUDToWindow:response.errorMsg];
        }];
    }];
    
}

@end
