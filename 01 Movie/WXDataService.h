//
//  WXDataService.h
//  01 Movie
//
//  Created by lyb on 14-10-10.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXDataService : NSObject

//加载数据
+ (id)requestData:(NSString *)fileName;

@end
