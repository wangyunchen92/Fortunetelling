//
//  LuckMoneyViewModel.m
//  Fortune
//
//  Created by Sj03 on 2018/5/21.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "LuckMoneyViewModel.h"
#import "PersonDateModel.h"
#import "WSDatePickerView.h"
#import "ResultLuckMoneyModel.h"


@interface LuckMoneyViewModel ()
@property (nonatomic, strong)PersonDateModel *updateDate;

@end

@implementation LuckMoneyViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _sex = @"男";
        _updateDate = [[PersonDateModel alloc] init];
        _selDate = [NSDate date];
    }
    return self;
}

- (void)initSigin {
    
    [self.subject_getDate subscribeNext:^(id x) {
        if (!(self.name.length > 0)) {
            [BasePopoverView showFailHUDToWindow:@"请输入男方姓名"];
            return ;
        }
        
        HttpRequestMode *model = [[HttpRequestMode alloc]init];
        
        NSMutableDictionary *program = [[NSMutableDictionary alloc] init];
        [program addUnEmptyString:[ToolUtil dy_getDeviceUUID] forKey:@"uuid"];
        [program addUnEmptyString:[ToolUtil dy_getDeviceUUID] forKey:@"imei"];
        [program addUnEmptyString:self.name forKey:@"name"];
        [program addUnEmptyString:self.sex forKey:@"sex"];
        [program addUnEmptyString:self.updateDate.year forKey:@"year"];
        [program addUnEmptyString:self.updateDate.month forKey:@"month"];
        [program addUnEmptyString:self.updateDate.day forKey:@"day"];
        [program addUnEmptyString:self.updateDate.hour forKey:@"hour"];
        [program addUnEmptyString:self.updateDate.min forKey:@"minute"];
        model.name= @"三生运势";
        model.parameters = program;
        model.url = GetWealthActionApi;
        [[HttpClient sharedInstance] requestApiWithHttpRequestMode:model Success:^(HttpRequest *request, HttpResponse *response) {
            ResultLuckMoneyModel *model = [[ResultLuckMoneyModel alloc] init];
            [model getModelForServer: response.result];
            self.model = model;
            if (self.block_reloadDate) {
                self.block_reloadDate();
            }
        } Failure:^(HttpRequest *request, HttpResponse *response) {
            [BasePopoverView showFailHUDToWindow:response.errorMsg];
        }];
    }];
}

- (void)getselDate:(NSDate *)selectDate {
    [self.updateDate getdateForYear:[selectDate stringWithFormat:@"yyyy"] month:[selectDate stringWithFormat:@"MM"] day:[selectDate stringWithFormat:@"dd"] hour:[selectDate stringWithFormat:@"HH"] min: @"00"];
    self.selDate = selectDate;
}
@end
