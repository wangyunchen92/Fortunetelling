//
//  MainViewModel.m
//  Fortune
//
//  Created by Sj03 on 2018/4/9.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "MainViewModel.h"

@implementation MainViewModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _bannerArray = [[NSMutableArray alloc] init];
        [_bannerArray addObject:@"Banner1"];
        [_bannerArray addObject:@"Banner2"];
    }
    return self;
}

- (void)initSigin {
    [super initSigin];
    [self.subject_getDate subscribeNext:^(NSMutableArray *catchArray) {
        HttpRequestMode *model = [[HttpRequestMode alloc]init];
        model.name= @"产品列表";
        model.url = GetNews;
        
        [[HttpClient sharedInstance]requestApiWithHttpRequestMode:model Success:^(HttpRequest *request, HttpResponse *response) {

        } Failure:^(HttpRequest *request, HttpResponse *response) {
            [BasePopoverView hideHUDForWindow:YES];
            [BasePopoverView showFailHUDToWindow:response.errorMsg];
            if (self.block_reloadDate) {
                self.block_reloadDate();
            }
            
        } RequsetStart:^{
            
        } ResponseEnd:^{
            
        }];
    }];

}
@end
