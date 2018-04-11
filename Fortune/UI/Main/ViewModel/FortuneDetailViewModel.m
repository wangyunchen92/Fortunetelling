//
//  FortuneDetailViewModel.m
//  Fortune
//
//  Created by Sj03 on 2018/4/10.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "FortuneDetailViewModel.h"
#import "WSDatePickerView.h"

@implementation FortuneDetailViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _sex = @"男";
        _firstName = @"";
        _lastName = @"";
        [self getNowday:[NSDate date]];
    }
    return self;
}

- (void)getNowday:(NSDate *)selectDate {
    
    self.year = [selectDate stringWithFormat:@"yyyy"];
    self.month = [selectDate stringWithFormat:@"MM"];
    self.day = [selectDate stringWithFormat:@"dd"];
    self.hour = [selectDate stringWithFormat:@"HH"];
    self.min = [selectDate stringWithFormat:@"mm"];
}

- (void)initSigin {
    
    [self.subject_getDate subscribeNext:^(id x) {
        if (!(self.firstName.length > 0)) {
            [BasePopoverView showFailHUDToWindow:@"请填写姓氏"];
        }
        if (!(self.lastName.length > 0)) {
            [BasePopoverView showFailHUDToWindow:@"请填写名子"];
        }
        if (!(self.year.length > 0)) {
            [BasePopoverView showFailHUDToWindow:@"请选择生日"];
        }
        HttpRequestMode *model = [[HttpRequestMode alloc]init];
        NSMutableDictionary *pram = [[NSMutableDictionary alloc] init];
        model.url = GetCurlInfo;
        [pram addUnEmptyString:[ToolUtil dy_getDeviceUUID] forKey:@"imei"];
        [pram addUnEmptyString:[ToolUtil dy_getDeviceUUID] forKey:@"uuid"];
        [pram addUnEmptyString:self.firstName forKey:@"xing"];
        [pram addUnEmptyString:self.lastName forKey:@"ming"];
        [pram addUnEmptyString:self.sex forKey:@"sex"];
        [pram addUnEmptyString:self.year forKey:@"year"];
        [pram addUnEmptyString:self.month forKey:@"month"];
        [pram addUnEmptyString:self.day forKey:@"day"];
        [pram addUnEmptyString:self.hour forKey:@"hour"];
        [pram addUnEmptyString:self.min forKey:@"minute"];
        model.name= @"八字算命";
        model.parameters = pram;
        model.url = GetCurlInfo;
        
        [[HttpClient sharedInstance]requestApiWithHttpRequestMode:model Success:^(HttpRequest *request, HttpResponse *response) {
            PersonDetailViewModel *personViewModel = [[PersonDetailViewModel alloc] init];
            
            NSDictionary *dic = response.result;
            PersonTopDetailModel *model = [[PersonTopDetailModel alloc] init];
            [model getdateForServer:dic];
            personViewModel.topModel = model;
            personViewModel.boardArray = [dic arrayForKey:@"info"];
            if (self.block_personDetail) {
                self.block_personDetail(personViewModel);
            }
            
        } Failure:^(HttpRequest *request, HttpResponse *response) {
            [BasePopoverView hideHUDForWindow:YES];
            [BasePopoverView showFailHUDToWindow:response.errorMsg];
            if (self.block_reloadDate) {
                self.block_reloadDate();
            }
            
        }];
    }];
}

@end
