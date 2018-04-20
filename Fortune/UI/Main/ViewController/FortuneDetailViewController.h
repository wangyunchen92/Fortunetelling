//
//  FortuneDetailViewController.h
//  Fortune
//
//  Created by Sj03 on 2018/4/10.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import "BaseViewController.h"
#import "RadioButton.h"

@interface FortuneDetailViewController : BaseViewController
@property (weak, nonatomic) IBOutlet RadioButton *radioButton;
@property (nonatomic, assign)BOOL isshowNavback;

@end
