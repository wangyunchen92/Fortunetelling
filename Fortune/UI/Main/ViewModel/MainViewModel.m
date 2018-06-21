//
//  MainViewModel.m
//  Fortune
//
//  Created by Sj03 on 2018/4/9.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "MainViewModel.h"
#import "MainCellModel.h"

@implementation MainViewModel
- (instancetype)init {
    self = [super init];
    if (self) {
        
        _bannerArray = [[NSMutableArray alloc] init];
        _bigBannerArray = [[NSArray alloc] init];
        _smallBannerArray = [[NSArray alloc] init];
        _subject_getServerData = [[RACSubject alloc] init];
        [self getServerDate];
    }
    return self;
}
- (void)getServerDate {
    
    [self.subject_getServerData subscribeNext:^(id x) {
        [self.bannerArray removeAllObjects];
        HttpRequestMode *model = [[HttpRequestMode alloc]init];
        NSMutableDictionary *program = [[NSMutableDictionary alloc] init];
        
        model.name= @"动态获取首页配置";
        model.parameters = program;
        model.url = GetBannerListpi;
        [[HttpClient sharedInstance] requestApiWithHttpRequestMode:model Success:^(HttpRequest *request, HttpResponse *response) {
            [[response.result arrayForKey:@"banner"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MainCellModel *model = [[MainCellModel alloc] init];
                [model getDateForServer:obj];
                [self.bannerArray addObject:model];
                
            }];
            
            NSComparator cmptr = ^(MainCellModel* obj1, MainCellModel* obj2){
                if (obj1.sort > obj2.sort) {
                    return (NSComparisonResult)NSOrderedAscending;
                }
                
                if (obj1.position < obj2.position) {
                    return (NSComparisonResult)NSOrderedDescending;
                }
                return (NSComparisonResult)NSOrderedSame;
            };
            
            {
                NSMutableArray *mutarr = [[NSMutableArray alloc] init];
                [[response.result arrayForKey:@"big"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MainCellModel *model = [[MainCellModel alloc] init];
                    [model getDateForServer:obj];
                    [mutarr addObject:model];
                    
                }];
                self.bigBannerArray = [mutarr sortedArrayUsingComparator:cmptr];
            }
            
            {
                NSMutableArray *mutarr = [[NSMutableArray alloc] init];
                
                [[response.result arrayForKey:@"small"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MainCellModel *model = [[MainCellModel alloc] init];
                    [model getDateForServer:obj];
                    [mutarr addObject:model];
                }];
                
                self.smallBannerArray = [mutarr sortedArrayUsingComparator:cmptr];
                
            }

            if (self.block_getServerData) {
                self.block_getServerData();
            }
        } Failure:^(HttpRequest *request, HttpResponse *response) {
            
        }];
    }];
}

- (void)initSigin {
    
    [self.subject_getDate subscribeNext:^(NSMutableArray *catchArray) {
        if (self.block_reloadDate) {
            self.block_reloadDate();
        }
        HttpRequestMode *model = [[HttpRequestMode alloc]init];
        NSMutableDictionary *program = [[NSMutableDictionary alloc] init];

        model.name= @"web过滤规则";
        model.parameters = program;
        model.url = GetRuleList;
        [[HttpClient sharedInstance] requestApiWithHttpRequestMode:model Success:^(HttpRequest *request, HttpResponse *response) {
            self.webfile = [response.result stringForKey:@"object"];
            if (self.block_reloadDate) {
                self.block_reloadDate();
            }
        } Failure:^(HttpRequest *request, HttpResponse *response) {
            
        }];
    }];
    
    
    
}
@end
