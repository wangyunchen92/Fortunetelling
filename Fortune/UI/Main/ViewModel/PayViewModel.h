//
//  PayViewModel.h
//  Fortune
//
//  Created by Sj03 on 2018/4/13.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayViewModel : BaseViewModel
@property (nonatomic, copy)NSString *payMoney;
@property (nonatomic, copy)NSString *money;
@property (nonatomic, copy)NSString *programId;
@property (nonatomic, copy)NSString *webPayRequestUrl;
@property (nonatomic, strong)RACSubject *subject_getPaySigin;
@property (nonatomic, copy)void (^block_canPay)(NSString *sigin);
@end
