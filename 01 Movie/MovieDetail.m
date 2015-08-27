//
//  MovieDetail.m
//  01 Movie
//
//  Created by lyb on 14-10-11.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "MovieDetail.h"
#import "MovieModel.h"
#import "UIImageView+WebCache.h"
#import "StarView.h"

@implementation MovieDetail

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}


//当视图通过NIB文件加载的时候会调用这个方法，不会调用init方法
- (void)awakeFromNib {

    self.backgroundColor = [UIColor orangeColor];
    
}

- (void)setModel:(MovieModel *)model {

    _model = model;
    
    //让系统重新加载
    [self setNeedsLayout];
}

//填充数据
- (void)layoutSubviews {

    [super layoutSubviews];
    
    //1.加载电影的图片
    NSString *stringURL = [self.model.images objectForKey:@"medium"];
    //将字符串转换正URL
    NSURL *url = [NSURL URLWithString:stringURL];
    [imageView setImageWithURL:url];
    
    //2.显示中文的标题
    NSString *title = [NSString stringWithFormat:@"中文：%@",_model.title];
    titleLabel.text = title;
    
    //3.英文标题
    enLabel.text = [NSString stringWithFormat:@"English:%@",_model.original_title];
    
    //4.年份
    yearLabel.text = [NSString stringWithFormat:@"年份：%@",_model.year];
    
    //5.星星视图
    starView.score = [self.model.rating objectForKey:@"average"];
    
}

@end
