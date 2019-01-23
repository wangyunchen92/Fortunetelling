//
//  ProductDetailModel.m
//  Fortune
//
//  Created by Sj03 on 2018/6/28.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "ProductDetailModel.h"

@implementation ProductDetailModel

-(instancetype)init {
    self = [super init];
    if (self) {
        _commentInfoArray = [[NSArray alloc] init];
        _detailPicArray = [[NSArray alloc] init];
        _recordInfoArray = [[NSArray alloc] init];
        _recommendArray = [[NSArray alloc] init];
        _detailPic= @"";
        _subhead = @"";
        _evaluate= @"";
        _intro= @"";
        _idkey= @"";
        _main_pic= @"";
        _name= @"";
        _original_price= @"";
        _prefer_price= @"";
        _isShu = NO;
    }
    return self;
}

- (void)getModelForServer:(NSDictionary *)dic {
    self.commentInfoArray = [dic arrayForKey:@"comment_info"];
    self.detailPicArray = [dic arrayForKey:@"detail_info"];
    self.recordInfoArray = [dic arrayForKey:@"record_info"];
    self.recommendArray = [dic arrayForKey:@"recommend"];
    self.detailPic = [dic stringForKey:@"detail_pic"];
    self.evaluate = [dic stringForKey:@"evaluate"];
    self.intro = [dic stringForKey:@"intro"];
    self.idkey = [dic stringForKey:@"id"];
    if ([[dic stringForKey:@"main_pic"] containsString:@"https://luck.youmeng.com/Uploads/Product/"]) {
        self.main_pic = [dic stringForKey:@"main_pic"];
    } else {
        self.main_pic = [NSString stringWithFormat:@"https://luck.youmeng.com/Uploads/Product/%@",[dic stringForKey:@"main_pic"]];
    }
    self.name = [dic stringForKey:@"name"];
    self.original_price = [dic stringForKey:@"original_price"];
    self.prefer_price = [dic stringForKey:@"prefer_price"];
    self.subhead = [dic stringForKey:@"subhead"];
    self.isShu = [dic integerForKey:@"evaluate"] == 0 ? NO : YES;
}

@end
