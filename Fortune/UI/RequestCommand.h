//
//  RequestCommand.h
//  Fortune
//
//  Created by Sj03 on 2018/4/26.
//  Copyright © 2018年 Sj03. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^block_success)(NSDictionary *);
typedef void(^block_faild)(NSString *);
@interface RequestCommand : NSObject

+ (RequestCommand *)shareCommand;

- (void)GetFortuneInfo:(NSDictionary *)program success:(block_success )success faild:(block_faild )faild;

@end
