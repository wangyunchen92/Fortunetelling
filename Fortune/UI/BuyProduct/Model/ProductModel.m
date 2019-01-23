//
//  ProductModel.m
//  Fortune
//
//  Created by Sj03 on 2018/6/26.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel
- (instancetype)init {
    self = [super init];
    if (self) {
        self.key = @"";
        self.mainPic = @"";
        self.name = @"";
        self.subhead = @"";
    }
    return self;
}


- (void)getModelForServer:(NSDictionary *)dic {
    self.key = [dic stringForKey:@"id"];
    self.mainPic = [dic stringForKey:@"main_pic"];
    self.name = [dic stringForKey:@"name"];
    self.subhead = [dic stringForKey:@"subhead"];
}

@end
