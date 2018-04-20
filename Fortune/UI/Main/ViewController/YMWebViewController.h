//
//  YMWebViewController.h
//  CloudPush
//
//  Created by YouMeng on 2017/3/7.
//  Copyright © 2017年 YouMeng. All rights reserved.
//

#import "BaseViewController.h"
#import "YMWebProgressLayer.h"

@interface YMWebViewController : BaseViewController


//网页链接 -- 标题
@property(nonatomic,copy)NSString* titleStr;
@property(nonatomic,copy)NSString* urlStr;
@property (nonatomic, copy)NSString *webfile;
@property (nonatomic, copy)void (^complete)(void);
@property (nonatomic, assign)NSInteger isloadweb;

@end
