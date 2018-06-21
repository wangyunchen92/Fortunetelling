//
//  MainCellModel.m
//  Fortune
//
//  Created by Sj03 on 2018/6/20.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "MainCellModel.h"

@implementation MainCellModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _content = @"";
        _mainPic = @"";
        _redirect_url = @"";
        _title = @"";
        
        _position = 1;
        _cellID = 1;
        _sort = 1;
        _status = 1;
        _type = 1;
    }
    return self;
}

- (void)getDateForServer:(NSDictionary *)dic {
    _content = [dic stringForKey:@"content"];
    _mainPic = [dic stringForKey:@"pic"];
    _redirect_url = [dic stringForKey:@"redirect_url"];
    _title = [dic stringForKey:@"title"];
    
    
    _position = [dic integerForKey:@"position"];
    _cellID = [dic integerForKey:@"id"];;
    _sort = [dic integerForKey:@"sort"];;
    _status = [dic integerForKey:@"status"];;
    _type = [dic integerForKey:@"type"];;
}

@end
