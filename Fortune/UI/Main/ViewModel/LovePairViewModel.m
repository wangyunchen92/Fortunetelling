//
//  LovePairViewModel.m
//  Fortune
//
//  Created by Sj03 on 2018/5/9.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "LovePairViewModel.h"
#import "WSDatePickerView.h"
#import "PersonDateModel.h"



@interface LovePairViewModel ()
@property (nonatomic, strong)PersonDateModel *updateMaleDate;
@property (nonatomic, strong)PersonDateModel *updateFemaleDate;


@end
@implementation LovePairViewModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _selMaleDate = [NSDate date];
        _selFemaleDate = [NSDate date];
        _updateMaleDate = [[PersonDateModel alloc] init];
        _updateFemaleDate = [[PersonDateModel alloc] init];
    }
    return self;
}

- (void)initSigin {
    
    [self.subject_getDate subscribeNext:^(id x) {
        if (!(self.maleName.length > 0)) {
            [BasePopoverView showFailHUDToWindow:@"请输入男方姓名"];
            return ;
        }
        if (!(self.updateMaleDate.year.length > 0)) {
            [BasePopoverView showFailHUDToWindow:@"请选择男方出生日期"];
            return ;
        }
        if (!(self.updateFemaleDate.year.length > 0)) {
            [BasePopoverView showFailHUDToWindow:@"请选择女方出生日期"];
            return ;
        }
        if (!(self.femaleName.length > 0)) {
            [BasePopoverView showFailHUDToWindow:@"请输入女方姓名"];
            return ;
        }
        if (2 > self.femaleName.length  & 2 > self.maleName.length  ) {
            [BasePopoverView showFailHUDToWindow:@"姓名不能少于2个字符"];
            return;
        }
        if ( self.femaleName.length >= 5 & self.maleName.length >= 5) {
            [BasePopoverView showFailHUDToWindow:@"姓名不能大于5个字符"];
            return;
        }
        HttpRequestMode *model = [[HttpRequestMode alloc]init];
        
        NSMutableDictionary *program = [[NSMutableDictionary alloc] init];
        [program addUnEmptyString:[ToolUtil dy_getDeviceUUID] forKey:@"uuid"];
        [program addUnEmptyString:[ToolUtil dy_getDeviceUUID] forKey:@"imei"];
        [program addUnEmptyString:self.femaleName forKey:@"bz_name_w"];
        [program addUnEmptyString:self.maleName forKey:@"bz_name_m"];
        [program addUnEmptyString:self.updateFemaleDate.year forKey:@"bz_year_w"];
        [program addUnEmptyString:self.updateMaleDate.year forKey:@"bz_year_m"];
        [program addUnEmptyString:self.updateFemaleDate.month forKey:@"bz_month_w"];
        [program addUnEmptyString:self.updateMaleDate.month forKey:@"bz_month_m"];
        [program addUnEmptyString:self.updateFemaleDate.day forKey:@"bz_day_w"];
        [program addUnEmptyString:self.updateMaleDate.day forKey:@"bz_day_m"];
        [program addUnEmptyString:self.updateFemaleDate.hour forKey:@"bz_hour_w"];
        [program addUnEmptyString:self.updateMaleDate.hour forKey:@"bz_hour_m"];
        model.name= @"八字合婚";
        model.parameters = program;
        model.url = GetActionApi;
        [[HttpClient sharedInstance] requestApiWithHttpRequestMode:model Success:^(HttpRequest *request, HttpResponse *response) {
            ResultLovePairModel *model = [[ResultLovePairModel alloc] init];
            [model getmodelForServer: response.result];
            self.model = model;
            if (self.block_reloadDate) {
                self.block_reloadDate();
            }
        } Failure:^(HttpRequest *request, HttpResponse *response) {
            
        }];
    }];
}


- (void)getmaleDateForSele:(NSDate *)selectDate {
    [self.updateMaleDate getdateForYear:[selectDate stringWithFormat:@"yyyy"] month:[selectDate stringWithFormat:@"MM"] day:[selectDate stringWithFormat:@"dd"] hour:[selectDate stringWithFormat:@"HH"] min: @"00"];
    self.selMaleDate = selectDate;
}

- (void)getfemaleDateForSele:(NSDate *)selectDate {
    [self.updateFemaleDate getdateForYear:[selectDate stringWithFormat:@"yyyy"] month:[selectDate stringWithFormat:@"MM"] day:[selectDate stringWithFormat:@"dd"] hour:[selectDate stringWithFormat:@"HH"] min: @"00"];
    self.selFemaleDate = selectDate;
    
}
@end
