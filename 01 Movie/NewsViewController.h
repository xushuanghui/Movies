//
//  NewsViewController.h
//  01 Movie
//
//  Created by lyb on 14-10-8.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "BaseViewController.h"

@interface NewsViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate> {

    UITableView *_tableView;    //表视图
    UIImageView *_imgView;
    UILabel *_titleLabel;
}

@property(nonatomic, retain)NSMutableArray *data;  //用于存放model对象

@end
