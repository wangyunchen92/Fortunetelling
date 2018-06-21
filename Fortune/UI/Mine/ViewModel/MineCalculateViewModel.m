//
//  MineCalculateViewModel.m
//  Fortune
//
//  Created by Sj03 on 2018/4/10.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "MineCalculateViewModel.h"

@implementation MineCalculateViewModel

- (void)initSigin {
    [self.subject_getDate subscribeNext:^(id x) {
        [self.dataArray removeAllObjects];
        HttpRequestMode *model = [[HttpRequestMode alloc]init];
        NSMutableDictionary *program = [[NSMutableDictionary alloc] init];
        [program addUnEmptyString:[ToolUtil dy_getDeviceUUID] forKey:@"uuid"];
        [program addUnEmptyString:[ToolUtil dy_getDeviceUUID] forKey:@"imei"];
        model.name= @"测算历史";
        model.parameters = program;
        model.url = GetHistoryInfo;
        [[HttpClient sharedInstance] requestApiWithHttpRequestMode:model Success:^(HttpRequest *request, HttpResponse *response) {
            NSArray *array = [response.result arrayForKey:@"object"];
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MineCalculatModel *model = [[MineCalculatModel alloc] init];
                [model getDataForServer:obj];
                [self.dataArray addObject:model];
            }];
            if (self.block_reloadDate) {
                self.block_reloadDate();
            }
        } Failure:^(HttpRequest *request, HttpResponse *response) {
            if (self.block_reloadDate) {
                self.block_reloadDate();
            }
        }];
    }];

}
@end
