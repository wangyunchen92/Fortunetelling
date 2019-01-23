 //
//  ProductListViewModel.m
//  Fortune
//
//  Created by Sj03 on 2018/6/26.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "ProductListViewModel.h"
#import "ProductModel.h"

@implementation ProductListViewModel

- (void)initSigin {
    self.secendListArray = [[NSMutableArray alloc] init];
    self.titleArray = [[NSMutableArray alloc] init];
    [self.subject_getDate subscribeNext:^(id x) {
        [self.secendListArray removeAllObjects];
        [self.dataArray removeAllObjects];
        [self.titleArray removeAllObjects];
        HttpRequestMode *model = [[HttpRequestMode alloc]init];
        NSMutableDictionary *program = [[NSMutableDictionary alloc] init];
        model.name= @"商品列表";
        model.parameters = program;
        model.url = GetProductList;
        [BasePopoverView showHUDToWindow:YES withMessage:@"加载中..."];
        [[HttpClient sharedInstance] requestApiWithHttpRequestMode:model Success:^(HttpRequest *request, HttpResponse *response) {
            [BasePopoverView hideHUDForWindow:YES];
            NSArray *arr = response.result[@"object"];
            [arr enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx == 0) {
                    NSArray *objarr = [obj arrayForKey:@"content"];
                    [objarr enumerateObjectsUsingBlock:^(id  _Nonnull objs, NSUInteger idx, BOOL * _Nonnull stop) {
                        ProductModel *model = [[ProductModel alloc] init];
                        [model getModelForServer:objs];
                        [self.dataArray addObject:model];
                    }];
                } else {
                    [self.titleArray addObject:[obj stringForKey:@"title"]];
                    NSArray *objarr = [obj arrayForKey:@"content"];
                    NSMutableArray *mutarr = [[NSMutableArray alloc] init];
                    [objarr enumerateObjectsUsingBlock:^(id  _Nonnull objs, NSUInteger idx, BOOL * _Nonnull stop) {
                        ProductModel *model = [[ProductModel alloc] init];
                        [model getModelForServer:objs];
                        [mutarr addObject:model];
                    }];
                    [self.secendListArray addObject:mutarr];
                }
            }];
            if (self.block_reloadDate) {
                self.block_reloadDate();
            }
        } Failure:^(HttpRequest *request, HttpResponse *response) {
            [BasePopoverView hideHUDForWindow:YES];
            [BasePopoverView showFailHUDToWindow:response.errorMsg];
        }];

//        [self.dataArray addObject:@"1"];
//        [self.dataArray addObject:@"1"];
//        [self.dataArray addObject:@"1"];
//        [self.dataArray addObject:@"1"];
//
//        NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:@"1",@"1",@"1", nil];
//        NSMutableArray *arr1 = [[NSMutableArray alloc] initWithObjects:@"1",@"1",@"1", nil];
//        NSMutableArray *arr2 = [[NSMutableArray alloc] initWithObjects:@"1",@"1",@"1", nil];
//
//        NSArray *secearr = [[NSMutableArray alloc] initWithObjects:arr,arr1,arr2, nil];
//        self.secendListArray = [[NSMutableArray alloc] initWithArray:secearr];
//        self.block_reloadDate();
        
    }];

}

@end
