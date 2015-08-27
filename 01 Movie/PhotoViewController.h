//
//  PhotoViewController.h
//  01 Movie
//
//  Created by lyb on 14-10-14.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "BaseViewController.h"

@interface PhotoViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {

    UICollectionView *_collectionView;
    
}

@property(nonatomic, retain)NSArray *data;  //存放显示的数据
@property(nonatomic, retain)NSIndexPath *selectedIndexPath;    //选中的下标
@property(nonatomic, assign)BOOL isHidden;

@end
