//
//  ResultNameModel.h
//  Fortune
//
//  Created by Sj03 on 2018/5/15.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ResultNameInfo :NSObject
@property (nonatomic, assign)NSInteger type;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *subhead;
@property (nonatomic, copy)NSArray *contentArray;

@end

@interface ResultNameModel : NSObject

@property (nonatomic, strong)NSArray *jixiongArray;
@property (nonatomic, strong)NSArray *fonnameArray;
@property (nonatomic, strong)NSArray *nameArray;
@property (nonatomic, strong)NSArray *spellArray;
@property (nonatomic, strong)NSArray *wuxingArray;
@property (nonatomic, strong)NSArray *strokesArray;
@property (nonatomic, strong)NSArray *lifeArray;
@property (nonatomic, strong)NSArray <ResultNameInfo *>*infoArray;
- (void)getModelForServer:(NSDictionary *)dic;

@end
