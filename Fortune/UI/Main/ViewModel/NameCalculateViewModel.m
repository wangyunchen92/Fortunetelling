//
//  NameCalculateViewModel.m
//  Fortune
//
//  Created by Sj03 on 2018/5/15.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "NameCalculateViewModel.h"

@implementation NameCalculateViewModel
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
        
        model.name= @"姓名测算";
        model.parameters = program;
        model.url = GetNameActionApi;
        [[HttpClient sharedInstance] requestApiWithHttpRequestMode:model Success:^(HttpRequest *request, HttpResponse *response) {
            ResultNameModel *model = [[ResultNameModel alloc] init];
            [model getModelForServer: response.result];
            self.model = model;
            if (self.block_reloadDate) {
                self.block_reloadDate();
            }
        } Failure:^(HttpRequest *request, HttpResponse *response) {
            
        }];
    }];
}

@end
