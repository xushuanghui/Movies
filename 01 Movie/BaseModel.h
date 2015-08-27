//
//  BaseModel.h
//  01 Movie
//
//  Created by lyb on 14-10-14.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>
//NSJSONSerialization
@interface BaseModel : NSObject

//自定义初始化方法
- (id)initContentWithDic:(NSDictionary *)dic;

- (NSDictionary *)attributesMapDictionary:(NSDictionary *)dic;

// 目的：将JSON文件中key所对应的value交给model的属性
- (void)setAttributes:(NSDictionary *)jsonDic;

@end
