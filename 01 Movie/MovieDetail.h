//
//  MovieDetail.h
//  01 Movie
//
//  Created by lyb on 14-10-11.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StarView;
@class MovieModel;

@interface MovieDetail : UIView {

    __weak IBOutlet UIImageView *imageView;
    
    __weak IBOutlet UILabel *titleLabel;
    
    __weak IBOutlet UILabel *enLabel;
    
    __weak IBOutlet UILabel *yearLabel;


    __weak IBOutlet StarView *starView;
}

@property(nonatomic, retain)MovieModel *model;

@end
