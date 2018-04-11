//
//  PersonTopDetailModel.h
//  Fortune
//
//  Created by Sj03 on 2018/4/11.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonTopDetailModel : NSObject
@property (nonatomic, copy)NSString *projectName;
@property (nonatomic, copy)NSString *brithDateY;
@property (nonatomic, copy)NSString *bazi;
@property (nonatomic, copy)NSString *wuxing;
@property (nonatomic, copy)NSString *nayin;
@property (nonatomic, copy)NSString *brithDateG;
@property (nonatomic, copy)NSString *title;
- (void)getdateForServer:(NSDictionary *)dic;
@end
