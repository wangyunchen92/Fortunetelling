//
//  ProductDetailPicker.h
//  Fortune
//
//  Created by Sj03 on 2018/6/27.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailPicker : UIView

- (void)creatViewWithServer:(NSArray *)arr;
@property (nonatomic,copy)void (^block_changeHeight)(CGFloat folat);
@end
