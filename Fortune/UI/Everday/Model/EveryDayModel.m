//
//  EveryDayModel.m
//  Fortune
//
//  Created by Sj03 on 2018/4/16.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "EveryDayModel.h"

@implementation YiJiModel
-(instancetype)init {
    self = [super init];
    if (self) {
        _yi = @"";
        _ji = @"";
        _showTitle = @"";
        _chongsha = @"";
        _datetitle =@"";
    }
    return self;
}


- (void)getModelForServer:(NSString *)str andtag:(NSInteger )tag {

    NSArray *array = [str componentsSeparatedByString:@"\r\n"];
    if (!(array.count >=6)) {
        return;
    }
    {
        NSString *str = [array objectAtIndex:2];
        if (str.length >= 5) {
            self.datetitle = [str substringFromIndex:4] ;
        } else {
            self.datetitle = @"";
        }
    }
    {
        NSString *str = [array objectAtIndex:1];
        if (str.length >= 5) {
            NSString *firststr = [str substringFromIndex:4];
            self.showTitle = [firststr substringToIndex:1] ;
        } else {
            self.showTitle = @"";
        }
    }
    
    {
        NSString *str = [array objectAtIndex:5];
        if (str.length > 6) {
            self.yi = [str substringFromIndex:4];
        } else {
            self.yi = @"无";
        }
    }
    
    {
        NSString *str = [array objectAtIndex:6];
        if (str.length > 6) {
            self.ji = [str substringFromIndex:4];
        } else {
            self.ji = @"无";
        }
    }
    
    {
        NSString *str = [array objectAtIndex:3];
        if (str.length >= 6) {
               self.chongsha = [str substringFromIndex:3];
        } else {
            self.chongsha = @"无";
        }
    }
    
    {
        NSString *str = [[array objectAtIndex:4] substringFromIndex:4];
        str = [str substringToIndex:2];
        self.chongsha = [NSString stringWithFormat:@"%@(%@)",self.chongsha,str];
        
    }
    switch (tag) {
        case 0:
            self.chongsha  = [NSString stringWithFormat:@"23:00-00:59 %@",self.chongsha];
            break;
        case 1:
            self.chongsha  = [NSString stringWithFormat:@"01:00-02:59 %@",self.chongsha];
            break;
        case 2:
            self.chongsha  = [NSString stringWithFormat:@"03:00-04:59 %@",self.chongsha];
            break;
        case 3:
            self.chongsha  = [NSString stringWithFormat:@"05:00-06:59 %@",self.chongsha];
            break;
        case 4:
            self.chongsha  = [NSString stringWithFormat:@"07:00-08:59 %@",self.chongsha];
            break;
        case 5:
            self.chongsha  = [NSString stringWithFormat:@"09:00-10:59 %@",self.chongsha];
            break;
        case 6:
            self.chongsha  = [NSString stringWithFormat:@"11:00-12:59 %@",self.chongsha];
            break;
        case 7:
            self.chongsha  = [NSString stringWithFormat:@"13:00-14:59 %@",self.chongsha];
            break;
        case 8:
            self.chongsha  = [NSString stringWithFormat:@"15:00-16:59 %@",self.chongsha];
            break;
        case 9:
            self.chongsha  = [NSString stringWithFormat:@"17:00-18:59 %@",self.chongsha];
            break;
        case 10:
            self.chongsha  = [NSString stringWithFormat:@"19:00-20:59 %@",self.chongsha];
            break;
        case 11:
            self.chongsha  = [NSString stringWithFormat:@"21:00-22:59 %@",self.chongsha];
            break;
        default:
            break;
    }
}

@end

@implementation EveryDayModel

-(instancetype)init {
    self = [super init];
    if (self) {
        _topContent = @"";
        _topDate = @"";
        _boardJi = @"";
        _boardYi = @"";
        _boardtopArray = [[NSMutableArray alloc] init];
        _boardbottomArray = [[NSMutableArray alloc] init];
        _baizujinji = @"";
        _bottom = @"";
    }
    return self;
}

- (void)getModelForServer:(NSDictionary *)dic {
    if ([dic stringForKey:@"nongli"].length > 6) {
        self.topDate = [[dic stringForKey:@"nongli"] substringFromIndex:6];
    }

    self.topContent = [dic stringForKey:@"ganzhi"];
    self.boardYi = [dic stringForKey:@"yi"];
    self.boardJi = [dic stringForKey:@"ji"];
    {
        YiJiModel *model = [[YiJiModel alloc] init];
        [model getModelForServer:[dic stringForKey:@"t23"] andtag:0];
        [self.boardtopArray addObject:model];
    }
    {
        YiJiModel *model = [[YiJiModel alloc] init];
        [model getModelForServer:[dic stringForKey:@"t1"] andtag:1];
        [self.boardtopArray addObject:model];
    }
    {
        YiJiModel *model = [[YiJiModel alloc] init];
        [model getModelForServer:[dic stringForKey:@"t3"] andtag:2];
        [self.boardtopArray addObject:model];
    }
    {
        YiJiModel *model = [[YiJiModel alloc] init];
        [model getModelForServer:[dic stringForKey:@"t5"] andtag:3];
        [self.boardtopArray addObject:model];
    }
    {
        YiJiModel *model = [[YiJiModel alloc] init];
        [model getModelForServer:[dic stringForKey:@"t7"] andtag:4];
        [self.boardtopArray addObject:model];
    }
    {
        YiJiModel *model = [[YiJiModel alloc] init];
        [model getModelForServer:[dic stringForKey:@"t9"] andtag:5];
        [self.boardtopArray addObject:model];
    }
    {
        YiJiModel *model = [[YiJiModel alloc] init];
        [model getModelForServer:[dic stringForKey:@"t11"] andtag:6];
        [self.boardtopArray addObject:model];
    }
    {
        YiJiModel *model = [[YiJiModel alloc] init];
        [model getModelForServer:[dic stringForKey:@"t13"] andtag:7];
        [self.boardtopArray addObject:model];
    }
    {
        YiJiModel *model = [[YiJiModel alloc] init];
        [model getModelForServer:[dic stringForKey:@"t15"] andtag:8];
        [self.boardtopArray addObject:model];
    }
    {
        YiJiModel *model = [[YiJiModel alloc] init];
        [model getModelForServer:[dic stringForKey:@"t17"] andtag:9];
        [self.boardtopArray addObject:model];
    }
    {
        YiJiModel *model = [[YiJiModel alloc] init];
        [model getModelForServer:[dic stringForKey:@"t19"] andtag:10];
        [self.boardtopArray addObject:model];
    }
    {
        YiJiModel *model = [[YiJiModel alloc] init];
        [model getModelForServer:[dic stringForKey:@"t21"] andtag:11];
        [self.boardtopArray addObject:model];
    }
    
    self.baizujinji = [dic stringForKey:@"pzbj"];
    
    [self.boardbottomArray addObject:[dic stringForKey:@"sheng12"]];
    [self.boardbottomArray addObject:[dic stringForKey:@"zhiri"]];
    [self.boardbottomArray addObject:[dic stringForKey:@"chongsha"]];
    [self.boardbottomArray addObject:[dic stringForKey:@"tszf"]];
    [self.boardbottomArray addObject:[dic stringForKey:@"jsyq"]];
    self.bottom = [dic stringForKey:@"jrhh"];
}

@end
