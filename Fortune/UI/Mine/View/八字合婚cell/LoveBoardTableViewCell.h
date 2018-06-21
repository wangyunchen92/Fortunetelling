//
//  LoveBoardTableViewCell.h
//  Fortune
//
//  Created by Sj03 on 2018/5/10.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultLovePairModel.h"

@interface LoveBoardTableViewCell : UITableViewCell
- (void)getdateForModel:(ResultInfo *)model isshowSecendTitle:(BOOL)isshowSecendTitle  andsecendTitle:(NSString *)secendtitle;

@end
