//
//  WXDataService.m
//  01 Movie
//
//  Created by lyb on 14-10-10.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "WXDataService.h"

@implementation WXDataService

//加载数据
+ (id)requestData:(NSString *)fileName {

    /*
     JSON文件的解析：JSONKit.TouchJson.SBJson
     */
    //ios5以后有了系统的解析方法NSJSONSerialization
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    
    //获取JSON文件的数据
    NSData *data = [NSData dataWithContentsOfFile:filePath];
   
    /*
     NSJSONReadingMutableContainers  ：返回的是可变容器，NSMutableArray,NSMutableDic
     NSJSONReadingMutableLeaves :返回可变的字符串
     NSJSONReadingAllowFragments ：返回的数据最外层既不是数组也不是字典
     */
    
    id dataSource = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    return dataSource;
    
}

@end
