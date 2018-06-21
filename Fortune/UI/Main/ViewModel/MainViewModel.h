//
//  MainViewModel.h
//  Fortune
//
//  Created by Sj03 on 2018/4/9.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MainCellModel;

@interface MainViewModel : BaseViewModel
@property (nonatomic, strong)NSMutableArray <MainCellModel *>*bannerArray;
@property (nonatomic, strong)NSString *webfile;
@property (nonatomic, strong)RACSubject *subject_getServerData;
@property (nonatomic, strong)NSArray <MainCellModel *>*bigBannerArray;
@property (nonatomic, strong)NSArray <MainCellModel *>*smallBannerArray;

@property (nonatomic, copy)void (^block_getServerData)(void);


@end
