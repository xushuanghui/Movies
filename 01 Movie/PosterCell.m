//
//  PosterCell.m
//  01 Movie
//
//  Created by lyb on 14-10-11.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "PosterCell.h"
#import "MovieModel.h"
#import "UIImageView+WebCache.h"
#import "MovieDetail.h"

@implementation PosterCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.transform = CGAffineTransformMakeScale(.9, .9);
        
        //初始化视图
        [self _initView];
        
    }
    return self;
}

//初始化视图
- (void)_initView {

    //1.创建反面视图
    _detailView = [[[NSBundle mainBundle] loadNibNamed:@"MovieDetail" owner:self options:nil] lastObject];
#warning 适配4寸屏幕
    _detailView.frame = self.bounds;
    [self.contentView addSubview:_detailView];
    
    //2.创建正面显示的图片
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _imageView.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_imageView];
    
}

- (void)setModel:(MovieModel *)model {

    _model = model;
    
    //设置值
    NSString *stringURL = [self.model.images objectForKey:@"large"];
    //将字符串转换成url
    NSURL *url = [NSURL URLWithString:stringURL];
    [_imageView setImageWithURL:url];
    
    _detailView.model = self.model;
    
}

//返回的方法
- (void)flipCell {

    //定义翻转方向
    UIViewAnimationTransition transition = _left ? UIViewAnimationTransitionFlipFromLeft:UIViewAnimationTransitionFlipFromRight;
    
    //开始动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.35];
    
    [UIView setAnimationTransition:transition forView:self.contentView cache:YES];
    
    //结束动画
    [UIView commitAnimations];
    
    //取得视图的下表
    NSInteger index1 = [self.contentView.subviews indexOfObject:_imageView];
    NSInteger index2 = [self.contentView.subviews indexOfObject:_detailView];
    
    //交换两个视图的显示位置
    [self.contentView exchangeSubviewAtIndex:index1 withSubviewAtIndex:index2];
    _left = !_left;
}

@end
