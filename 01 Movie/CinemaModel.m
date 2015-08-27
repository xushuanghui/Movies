//
//  CinemaModel.m
//  01 Movie
//
//  Created by lyb on 14-10-17.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "CinemaModel.h"

@implementation CinemaModel

- (void)setAttributes:(NSDictionary *)jsonDic {

    [super setAttributes:jsonDic];
    
    self.cinemaID = [jsonDic objectForKey:@"id"];
    
}

@end
