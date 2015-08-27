//
//  PhotoScrollView.m
//  01 Movie
//
//  Created by lyb on 14-10-14.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "PhotoScrollView.h"
#import "UIImageView+WebCache.h"

@implementation PhotoScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _initView];
    }
    return self;
}

//初始化视图
- (void)_initView {

    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    //设置图片的显示样式
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
//    _imageView.backgroundColor = [UIColor redColor];
    [self addSubview:_imageView];
    
    //设置代理
    self.delegate = self;
    self.bounces = NO;
    
    //隐藏滚动条
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    //设置最数
    self.maximumZoomScale = 2;
    self.minimumZoomScale = 1;
    
    //双击手势
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1Action)];
    //设置点击的次数
    tap1.numberOfTapsRequired = 2;
    [self addGestureRecognizer:tap1];
    
    //单击手势
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2Action)];
    [self addGestureRecognizer:tap2];
    
    //当存在tap1的时候取消tap2
    [tap2 requireGestureRecognizerToFail:tap1];
    
}

//双击响应的事件
- (void)tap1Action {
    
    if (self.zoomScale > 1) {
        //缩小
        [self setZoomScale:1 animated:YES];
    }else {
        //双击放大
        [self setZoomScale:2 animated:YES];
    }
    
}

//单击响应的事件
- (void)tap2Action {

    NSLog(@"单击了");
    
    //发送单击了通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ClickImage" object:self];
}

- (void)setImageURL:(NSString *)imageURL {

    _imageURL = imageURL;
    //加载数据
    [_imageView setImageWithURL:[NSURL URLWithString:_imageURL]];
    
}

#pragma mark - UIScrollView delegate
//指定缩放的图片
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {

    return _imageView;

}


@end
