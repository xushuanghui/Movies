//
//  PosterCell.h
//  01 Movie
//
//  Created by lyb on 14-10-11.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MovieModel;
@class MovieDetail;

@interface PosterCell : UICollectionViewCell {

    UIImageView *_imageView;    //正面显示的图片
    MovieDetail *_detailView;    //反面视图
    BOOL _left;
}

@property(nonatomic, retain)MovieModel *model;
@property(nonatomic, retain)UIImageView *imageView;

//返回的方法
- (void)flipCell;

@end
