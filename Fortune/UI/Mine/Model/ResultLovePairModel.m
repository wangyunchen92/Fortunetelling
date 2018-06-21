//
//  ResultLovePairModel.m
//  Fortune
//
//  Created by Sj03 on 2018/5/10.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "ResultLovePairModel.h"


@implementation ResultInfo
- (instancetype)init {
    self = [super init];
    if (self) {
        _title = @"";
        _content = @"";
        _type = @"";
    }
    return self;
}

- (void)getmodelForServer:(NSDictionary *)dic {
    self.title = [dic stringForKey:@"title"];
    self.content = [dic stringForKey:@"content"];
    self.type = [NSString stringWithFormat:@"%ld",[dic integerForKey:@"type"]];
}

@end


@implementation ResultLovePairModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _manName = @"";
        _womeanName = @"";
        _manBazi = @"";
        _womanBazi = @"";
        _manBirth = @"";
        _womanBirth = @"";
        _manZodiac = @"";
        _womanZodiac = @"";
        _manPalace = @"";
        _womanPalace = @"";
        _manFirstborn = @"";
        _womanFirstborn = @"";
        _manInfo = @"";
        _womanInfo = @"";
        _pdResult = @"";
        _pdInfo = @"";
        _infoArray = [[NSArray alloc] init];
        _manFateArray = [[NSArray alloc] init];
        _womanFateArray = [[NSArray alloc] init];
        _manEmptyArray = [[NSArray alloc] init];
        _womanEmptyArray = [[NSArray alloc] init];
        _manGodArray = [[NSArray alloc] init];
        _womanGodArray = [[NSArray alloc] init];
    }
    return self;
}
- (void)getmodelForServer:(NSDictionary *)dic {
    self.manName = [dic stringForKey:@"man_name"];
    self.womeanName = [dic stringForKey:@"woman_name"];
    self.manBazi = [dic stringForKey:@"man_bazi"];
    self.womanBazi = [dic stringForKey:@"woman_bazi"];
    self.manBirth = [dic stringForKey:@"man_birth"];
    self.womanBirth = [dic stringForKey:@"woman_birth"];
    self.manZodiac = [dic stringForKey:@"man_zodiac"];
    self.womanZodiac = [dic stringForKey:@"woman_zodiac"];
    self.manPalace = [dic stringForKey:@"man_palace"];
    self.womanPalace = [dic stringForKey:@"woman_palace"];
    self.manFirstborn = [dic stringForKey:@"man_firstborn"];
    self.womanFirstborn = [dic stringForKey:@"woman_firstborn"];
    self.manInfo = [NSString stringWithFormat:@"您属于：%@",[dic stringForKey:@"man_info"]];
    self.womanInfo =[NSString stringWithFormat:@"您属于：%@",[dic stringForKey:@"woman_info"]] ;
    self.pdResult = [dic stringForKey:@"pd_result"];
    self.pdInfo = [dic stringForKey:@"pd_info"];
    self.infoArray = [self getmodelArray:[dic arrayForKey:@"info"]];
    self.manFateArray = [self getmodelArray:[dic arrayForKey:@"man_fate"]];
    self.womanFateArray = [self getmodelArray:[dic arrayForKey:@"woman_fate"]];
    self.manEmptyArray = [self deleString:[dic arrayForKey:@"man_empty"]];
    self.womanEmptyArray = [self deleString:[dic arrayForKey:@"woman_empty"]];
    self.manGodArray = [self deleString:[dic arrayForKey:@"man_god"]];
    self.womanGodArray = [self deleString:[dic arrayForKey:@"woman_god"]];
}

- (NSArray *)deleString:(NSArray *)serverArray {
    NSMutableArray *muarray = [[NSMutableArray alloc] init];
    [serverArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *str = [obj stringByReplacingOccurrencesOfString:@"：" withString:@""];
        [muarray addObject:str];
    }];
    return [NSArray arrayWithArray:muarray];
}

- (NSArray *)getmodelArray:(NSArray *)serverArray {
    NSMutableArray *muarray = [[NSMutableArray alloc] init];
    [serverArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ResultInfo *model = [[ResultInfo alloc] init];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [model getmodelForServer:obj];
        }
        [muarray addObject:model];
    }];
    return [NSArray arrayWithArray:muarray];
}

@end


