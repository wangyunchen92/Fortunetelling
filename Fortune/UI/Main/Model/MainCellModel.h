//
//  MainCellModel.h
//  Fortune
//
//  Created by Sj03 on 20@property (nonatomic, assign)NSInteger8/6/20.
//  Copyright © 20@property (nonatomic, assign)NSInteger8年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainCellModel : NSObject
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *mainPic;
@property (nonatomic, copy)NSString *redirect_url;
@property (nonatomic, copy)NSString *title;

@property (nonatomic, assign)NSInteger position;
@property (nonatomic, assign)NSInteger cellID;
@property (nonatomic, assign)NSInteger sort;
@property (nonatomic, assign)NSInteger status;
@property (nonatomic, assign)NSInteger type;

- (void)getDateForServer:(NSDictionary *)dic;


@end
