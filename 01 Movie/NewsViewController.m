//
//  NewsViewController.m
//  01 Movie
//
//  Created by lyb on 14-10-8.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "NewsViewController.h"
#import "WXDataService.h"
#import "NewsModel.h"
#import "NewsCell.h"
#import "UIImageView+WebCache.h"
#import "NewsDetailViewController.h"
#import "ImageListViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initializatio
        self.title = @"新闻";
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //创建可变数据
    _data = [[NSMutableArray alloc] init];
    
    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main@2x"]];

    //创建表视图
    [self _initTableView];
    
    //创建头视图
    [self _initHeaderView];
    
    
    [self showHUD:@"正在玩命加载"];
    //加载数据
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.5];
    
}

#pragma mark - UI界面设计
//创建表视图
- (void)_initTableView {

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64-49) style:UITableViewStylePlain];
    //设置代理
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //设置背景颜色
    _tableView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:_tableView];
    
}

- (void)_initHeaderView {

    //创建第一个单元格显示的图片
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 150)];
    _imgView.backgroundColor = [UIColor redColor];
//    [self.view insertSubview:_imgView belowSubview:_tableView];
    
    //创建标题label
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 150-30, KScreenWidth, 30)];
    //设置背景
    _titleLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
    //设置字体颜色
    _titleLabel.textColor = [UIColor whiteColor];
//    [self.view insertSubview:_titleLabel belowSubview:_tableView];
    
}

#pragma mark - 加载数据

//第一个单元格的数据
- (void)loadHeadData {

    //获取数据
    NewsModel *model = _data[0];
    
    //给imgView加载图片
    [_imgView setImageWithURL:[NSURL URLWithString:model.image]];
    
    //设置标题
    _titleLabel.text = model.title;
    
}

- (void)loadData {

    //加载数据
    NSArray *newList = [WXDataService requestData:NEWS_List];
    for (NSDictionary *dic in newList) {
        NewsModel *model = [[NewsModel alloc] initContentWithDic:dic];
//        [model setAttributes:dic];
//        //将字典中的数据交给model
//        model.newsId = [dic objectForKey:@"id"];
//        model.type = [dic objectForKey:@"type"];
//        model.title = [dic objectForKey:@"title"];
//        model.summary = [dic objectForKey:@"summary"];
//        model.image = [dic objectForKey:@"image"];
        
        //添加model到数组中
        [_data addObject:model];
    }
    
    //刷新视图
    [_tableView reloadData];
    
    //加载第一个单元格的数据
    [self loadHeadData];
    
    //隐藏加载提示
    [self hiddenHUD];
    [self.view addSubview:_tableView];
    [self.view insertSubview:_imgView belowSubview:_tableView];
    [self.view insertSubview:_titleLabel belowSubview:_tableView];
}

#pragma mark - UITableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

   
    if (indexPath.row == 0) {
        static NSString *iden = @"cell_head";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
            cell.backgroundColor = [UIColor clearColor];
        }
        return cell;
    }
    
    static NSString *iden = @"cell_News";
    
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:self options:nil] lastObject];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    //取得model数据
    NewsModel *model = [_data objectAtIndex:indexPath.row];
    
    cell.model = model;
    
    return cell;
}

#pragma mark - UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        return 150;
    }
    
    return 80;
}

//点击单元格调用的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    //取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //获取新闻类型
    NewsModel *model = self.data[indexPath.row];
    int type = [model.type intValue];
    
    if (type == 0) {  //普通新闻
        //创建新闻详情视图控制器
        NewsDetailViewController *newsDetail = [[NewsDetailViewController alloc] init];
        
        [self.navigationController pushViewController:newsDetail animated:YES];
    } else if (type == 1) { //图片新闻
        //创建图片新闻的视图控制器
        ImageListViewController *imgList = [[ImageListViewController alloc] init];
        
        [self.navigationController pushViewController:imgList animated:YES];
    }else if (type == 2) {  //视屏新闻
        [self showHUD:@"没有数据"];
        
        [self performSelector:@selector(hiddenHUD) withObject:NULL afterDelay:1.5];
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //获取当前滑动视图的偏移量
    float offsetY = scrollView.contentOffset.y;
    if (scrollView.contentOffset.y > 0) {
        
        //向上滑动
        _imgView.top = -offsetY;
        
    } else {
        
        //向下滑动
        //1.获取图片放大之后的高度
        float height = 150 + ABS(offsetY);
        
        //原图宽度/原图的高度＝ 放大的宽度/放大的高度
        //2.获取图片放大之后的宽度
        float width = KScreenWidth/150.0 * height;
        
        //3.设置图片的坐标 x的坐标设置为增加的宽度的一半
        _imgView.frame = CGRectMake(-(width-KScreenWidth)/2, 0, width, height);
        
        
    }
    
    _titleLabel.bottom = _imgView.bottom;
    
}








@end
