//
//  PayViewModel.m
//  Fortune
//
//  Created by Sj03 on 2018/4/13.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "PayViewModel.h"

@implementation PayViewModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _payMoney = @"限时优惠价:￥18";
        _money = @"原价:￥18";
        _subject_getPaySigin = [[RACSubject alloc] init];
        [self initSigin];
    }
    return self;
}

-(void)initSigin {
    [self.subject_getDate subscribeNext:^(id x) {
        HttpRequestMode *model = [[HttpRequestMode alloc]init];
        NSMutableDictionary *program = [[NSMutableDictionary alloc] init];
        model.name= @"支付金额";
        model.parameters = program;
        model.url = GetMoneyListe;
        [[HttpClient sharedInstance] requestApiWithHttpRequestMode:model Success:^(HttpRequest *request, HttpResponse *response) {
            self.payMoney = [NSString stringWithFormat:@"限时优惠价:￥%.2f",[[response.result objectForKey:@"prefer_price"] doubleValue]];
            self.money = [NSString stringWithFormat:@"原价:￥%.2f",[[response.result objectForKey:@"original_price"] doubleValue]];
            if (self.block_reloadDate) {
                self.block_reloadDate();
            }
        } Failure:^(HttpRequest *request, HttpResponse *response) {
            
        }];
    }];
    
    [self.subject_getPaySigin subscribeNext:^(id x) {
        HttpRequestMode *model = [[HttpRequestMode alloc]init];
        NSMutableDictionary *program = [[NSMutableDictionary alloc] init];
        [program addUnEmptyString:[ToolUtil dy_getDeviceUUID] forKey:@"uuid"];
        [program addUnEmptyString:[ToolUtil dy_getDeviceUUID] forKey:@"imei"];
        [program addUnEmptyString:self.programId forKey:@"fortune_id"];
        model.name= @"支付签名";
        model.parameters = program;
        model.url = GetAliPaySign;
        [[HttpClient sharedInstance] requestApiWithHttpRequestMode:model Success:^(HttpRequest *request, HttpResponse *response) {
            if (self.block_canPay) {
                self.block_canPay([response.result stringForKey:@"object"]);
            }
        } Failure:^(HttpRequest *request, HttpResponse *response) {
            
        }];

    }];
}
@end
