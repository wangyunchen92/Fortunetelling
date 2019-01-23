//
//  ProductDetailViewModel.m
//  Fortune
//
//  Created by Sj03 on 2018/6/28.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "ProductDetailViewModel.h"


@implementation ProductDetailViewModel

-(void)initSigin {
    [self.subject_getDate subscribeNext:^(id x) {
        
        HttpRequestMode *model = [[HttpRequestMode alloc]init];
        NSMutableDictionary *program = [[NSMutableDictionary alloc] init];
        [program addUnEmptyString:self.key forKey:@"id"];
        model.name= @"商品列表";
        model.parameters = program;
        model.url = GetProductDetai;
        [BasePopoverView showHUDToWindow:YES withMessage:@"加载中..."];
        [[HttpClient sharedInstance] requestApiWithHttpRequestMode:model Success:^(HttpRequest *request, HttpResponse *response) {
            [BasePopoverView hideHUDForWindow:YES];
            NSDictionary *dic = response.result;
            ProductDetailModel *model = [[ProductDetailModel alloc] init];
            [model getModelForServer:dic];
            self.model = model;
            if (self.block_reloadDate) {
                self.block_reloadDate();
            }
        } Failure:^(HttpRequest *request, HttpResponse *response) {
            [BasePopoverView hideHUDForWindow:YES];
            [BasePopoverView showFailHUDToWindow:response.errorMsg];
        }];
        
    }];
}

@end
