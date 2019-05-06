//
//  EveryDayViewModel.m
//  Fortune
//
//  Created by Sj03 on 2018/4/16.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "EveryDayViewModel.h"


@implementation EveryDayViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _date = [NSDate date];
    }
    return self;
}


- (void)initSigin {
    
    [self.subject_getDate subscribeNext:^(id x) {
        [self.dataArray removeAllObjects];
        HttpRequestMode *model = [[HttpRequestMode alloc]init];
        NSMutableDictionary *program = [[NSMutableDictionary alloc] init];
        [program addUnEmptyString:[ToolUtil stringFromDate:self.date] forKey:@"cx_date"];
        model.name= @"每日宜忌";
        model.parameters = program;
        model.url = GetFortuneList;
        [BasePopoverView showHUDToWindow:YES withMessage:@"加载中..."];
        [[HttpClient sharedInstance] requestApiWithHttpRequestMode:model Success:^(HttpRequest *request, HttpResponse *response) {
            [BasePopoverView hideHUDForWindow:YES];
            EveryDayModel *model = [[EveryDayModel alloc] init];
            [model getModelForServer:response.result];
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
