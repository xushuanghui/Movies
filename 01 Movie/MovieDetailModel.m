//
//  MovieDetailModel.m
//  01 WXMovie
//
//  Created by lyb on 14-8-24.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "MovieDetailModel.h"

@implementation MovieDetailModel

//- (NSDictionary *)attributesMapDictionary:(NSDictionary *)dic {
//
//    NSDictionary *mapDic = @{
//                             @"image" : @"image",
//                             @"titleCn" : @"titleCn",
//                             @"type" : @"type",
//                             @"directors" : @"directors",
//                             @"actors" : @"actors",
//                             @"release" : @"releaseDic",
//                             @"location" : @"location",
//                             @"date" : @"date",
//                             @"images" : @"images"
//                             };
//    return mapDic;
//}

// 目的：将JSON文件中key所对应的value交给model的属性
- (void)setAttributes:(NSDictionary *)jsonDic {

    //调用父类的方法
    [super setAttributes:jsonDic];
    
    //将不一样的属性特殊传值
    self.releaseDic = [jsonDic objectForKey:@"release"];
    
}

@end
