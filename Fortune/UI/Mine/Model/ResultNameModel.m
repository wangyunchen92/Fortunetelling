//
//  ResultNameModel.m
//  Fortune
//
//  Created by Sj03 on 2018/5/15.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "ResultNameModel.h"

@implementation ResultNameInfo
- (instancetype)init {
    self = [super init];
    if (self) {
        _type = 1;
        _title = @"";
        _subhead = @"";
        _contentArray = [[NSArray alloc] init];
    }
    return self;
}

- (void)getDateForServer:(NSDictionary *)dic {
    self.type = [[dic stringForKey:@"type"] integerValue];
    self.subhead = [dic stringForKey:@"subhead"];
    self.title = [dic stringForKey:@"title"];
    self.contentArray = [dic arrayForKey:@"content"];
}

@end

@implementation ResultNameModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _jixiongArray = [[NSArray alloc] init];
        _fonnameArray = [[NSArray alloc] init];
        _nameArray = [[NSArray alloc] init];
        _spellArray = [[NSArray alloc] init];
        _wuxingArray = [[NSArray alloc] init];
        _strokesArray = [[NSArray alloc] init];
        _lifeArray = [[NSArray alloc] init];
        _infoArray = [[NSArray alloc] init];
    }
    return self;
}

- (void)getModelForServer:(NSDictionary *)dic {
    self.jixiongArray = [dic arrayForKey:@"jixiong"];
    self.fonnameArray = [dic arrayForKey:@"fon_name"];
    self.nameArray = [dic arrayForKey:@"name"];
    self.spellArray = [dic arrayForKey:@"spell"];
    self.wuxingArray = [dic arrayForKey:@"wuxing"];
    self.strokesArray = [dic arrayForKey:@"strokes"];
    self.lifeArray = [dic arrayForKey:@"life"];
    NSArray *arr = [dic arrayForKey:@"info"];
    NSMutableArray *mutarray = [[NSMutableArray alloc] init];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ResultNameInfo *model = [[ResultNameInfo alloc] init];
        [model getDateForServer:obj];
        [mutarray addObject:model];
    }];
    self.infoArray = [NSArray arrayWithArray:mutarray];
}

@end
