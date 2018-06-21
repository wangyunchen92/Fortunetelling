//
//  ResultLockMoneyViewModel.m
//  Fortune
//
//  Created by Sj03 on 2018/5/21.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "ResultLuckMoneyViewModel.h"

@implementation ResultLuckMoneyViewModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _model = [[ResultLuckMoneyModel alloc] init];
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
            model.name= @"姓名测算历史";
            model.parameters = program;
            model.url = GetNameHistory;
            [[HttpClient sharedInstance] requestApiWithHttpRequestMode:model Success:^(HttpRequest *request, HttpResponse *response) {
            
                
            } Failure:^(HttpRequest *request, HttpResponse *response) {
                
            }];
        }];
    }
    
}
@end
