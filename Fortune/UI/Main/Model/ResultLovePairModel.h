//
//  ResultLovePairModel.h
//  Fortune
//
//  Created by Sj03 on 2018/5/10.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  ResultInfo :NSObject
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *type;
- (void)getmodelForServer:(NSDictionary *)dic;
@end


@interface ResultLovePairModel : NSObject
@property (nonatomic, copy)NSString *manName;
@property (nonatomic, copy)NSString *womeanName;
@property (nonatomic, copy)NSString *manBazi;
@property (nonatomic, copy)NSString *womanBazi;
@property (nonatomic, copy)NSString *manBirth;
@property (nonatomic, copy)NSString *womanBirth;
@property (nonatomic, copy)NSString *manZodiac;
@property (nonatomic, copy)NSString *womanZodiac;
@property (nonatomic, copy)NSString *manPalace;
@property (nonatomic, copy)NSString *womanPalace;
@property (nonatomic, copy)NSString *manFirstborn;
@property (nonatomic, copy)NSString *womanFirstborn;
@property (nonatomic, copy)NSString *manInfo;
@property (nonatomic, copy)NSString *womanInfo;
@property (nonatomic, copy)NSString *pdResult;
@property (nonatomic, copy)NSString *pdInfo;
@property (nonatomic, strong)NSArray <ResultInfo *>* infoArray;
@property (nonatomic, strong)NSArray <ResultInfo *>* manFateArray;
@property (nonatomic, strong)NSArray <ResultInfo *>* womanFateArray;
@property (nonatomic, strong)NSArray *manEmptyArray;
@property (nonatomic, strong)NSArray *womanEmptyArray;
@property (nonatomic, strong)NSArray *manGodArray;
@property (nonatomic, strong)NSArray *womanGodArray;
- (void)getmodelForServer:(NSDictionary *)dic;

@end



