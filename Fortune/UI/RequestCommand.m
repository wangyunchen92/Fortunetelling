
//
//  RequestCommand.m
//  Fortune
//
//  Created by Sj03 on 2018/4/26.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "RequestCommand.h"
@interface RequestCommand ()


@end

@implementation RequestCommand
static RequestCommand *command = nil;

+ (RequestCommand *)shareCommand {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (command == nil) {
            command = [[RequestCommand alloc] init];
        }
    });
    return command;
}

- (void)GetFortuneInfo:(NSDictionary *)program success:(block_success )success faild:(block_faild )faild {
    HttpRequestMode *model = [[HttpRequestMode alloc]init];
    model.name= @"测算历史";
    model.parameters = program;
    model.url = GetFortuneInfo;
    [[HttpClient sharedInstance] requestApiWithHttpRequestMode:model Success:^(HttpRequest *request, HttpResponse *response) {
        if (success) {
            success(response.result);
        }
    } Failure:^(HttpRequest *request, HttpResponse *response) {
        if (faild) {
            faild(response.errorMsg);
        }
    }];
    
}

@end
