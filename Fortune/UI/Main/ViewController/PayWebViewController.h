//
//  PayWebViewController.h
//  Fortune
//
//  Created by Sj03 on 2018/4/24.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "BaseViewController.h"

@interface PayWebViewController : BaseViewController
@property (nonatomic, strong)NSString *payurl;
@property (nonatomic, copy)void (^block_payResult)(BOOL );
@end
