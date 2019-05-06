//
//  RequestURL.h
//  daikuanchaoshi
//
//  Created by Sj03 on 2017/11/22.
//  Copyright © 2017年 Sj03. All rights reserved.
//

#ifndef RequestURL_h
#define RequestURL_h

static  NSString *const GetCurlInfo = @"https://shenxingnet.com/Api/Index/curlInfo.html";

// 测算详情
static  NSString *const GetFortuneDetail = @"https://shenxingnet.com/Api/Index/getFortuneDetail.html";

static NSString *const GetApkUpdate = @"https://shenxingnet.com/Api/App/getApkUpdate.html";


// 获取金额
static NSString *const GetMoneyListe = @"https://shenxingnet.com/Api/Index/getMoneyList.html";

// 获取金额签名
static NSString *const GetAliPaySign = @"https://shenxingnet.com/Api/AliPay/getAliPaySign.html";

// 黄道吉日
static NSString *const GetFortuneList = @"https://shenxingnet.com/Api/Calendar/getCalendarInfo.html";

// web筛选规则
static NSString *const GetRuleList = @"https://shenxingnet.com/Api/Wap/ruleList";

#pragma -MARK 二期功能
// 八字合婚
static NSString *const GetActionApi = @"https://shenxingnet.com/Api/Marriage/actionApi.html";

static NSString *const GetNameActionApi = @"https://shenxingnet.com/Api/Name/actionApi.html";


static  NSString *const GetHistoryInfo = @"https://shenxingnet.com/Api/Index/getHistoryInfo.html";

// 姓名测算历史详情
static  NSString *const GetNameHistory = @"https://shenxingnet.com/Api/Name/getDetail.html";

// 八字合婚历史详情
static  NSString *const GetMarriageHistory = @"https://shenxingnet.com/Api/Marriage/getDetail.html";

//三生财运 测算
static NSString *const GetWealthActionApi = @"https://shenxingnet.com/Api/Wealth/actionApi.html";

//首页动态配置
static NSString *const GetBannerListpi = @"https://shenxingnet.com/Api/Banner/getBannerList.html";


//商品列表
static NSString *const GetProductList = @"https://luck.youmeng.com/Api/Product/getProductList";

//商品详情
static NSString *const GetProductDetai = @"https://luck.youmeng.com/Api/Product/getProductDetail";

// 预支付订单
static NSString *const SaveShopOrder = @"https://luck.youmeng.com/Api/Product/saveShopOrder.html";



#endif /* RequestURL_h */
