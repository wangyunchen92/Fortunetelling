//
//  PersonDetailViewModel.m
//  Fortune
//
//  Created by Sj03 on 2018/4/9.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "PersonDetailViewModel.h"
#import "PersonTopDetailModel.h"

@implementation PersonDetailViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _topModel = [[PersonTopDetailModel alloc] init];
        _boardArray = [[NSMutableArray alloc] init];
        _isgetDate = YES;
        [self initSigin];
    }
    return self;
}

- (void)initSigin {
    if (!self.isgetDate) {
        if (self.block_reloadDate) {
            self.block_reloadDate();
        }
    } else {
        [self.subject_getDate subscribeNext:^(id x) {
            [self.dataArray removeAllObjects];
            [self.boardArray removeAllObjects];
            HttpRequestMode *model = [[HttpRequestMode alloc]init];
            NSMutableDictionary *program = [[NSMutableDictionary alloc] init];
            [program addUnEmptyString:[ToolUtil dy_getDeviceUUID] forKey:@"uuid"];
            [program addUnEmptyString:[ToolUtil dy_getDeviceUUID] forKey:@"imei"];
            [program addUnEmptyString:self.programId forKey:@"id"];
            model.name= @"测算历史详情";
            model.parameters = program;
            model.url = GetFortuneDetail;
            [[HttpClient sharedInstance] requestApiWithHttpRequestMode:model Success:^(HttpRequest *request, HttpResponse *response) {
                
                NSDictionary *dic = response.result;
                PersonTopDetailModel *model = [[PersonTopDetailModel alloc] init];
                [model getdateForServer:dic];
                self.topModel = model;
                self.boardArray = [dic arrayForKey:@"info"];
                if (self.block_reloadDate) {
                    self.block_reloadDate();
                }
            } Failure:^(HttpRequest *request, HttpResponse *response) {
                
            }];
        }];
    }
    
}

@end
