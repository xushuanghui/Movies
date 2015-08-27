//
//  NewsDetailViewController.m
//  01 Movie
//
//  Created by lyb on 14-10-14.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "WXDataService.h"

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.hidesBottomBarWhenPushed = YES;
        self.title = @"新闻详情";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //创建视图
    [self _initView];
   
    //请求网站
//    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
//    [webView loadRequest:request];
    //加载数据
    [self _loadData];
}

//创建视图
- (void)_initView {

    //创建网页视图
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-44-20)];
    //缩放网页以适合屏幕大小显示
    _webView.scalesPageToFit = YES;
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    //添加网络加载提示
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _activityView.frame = CGRectMake(0, 0, 44, 44);
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:_activityView];
    self.navigationItem.rightBarButtonItem = rightItem;

}

//加载数据
- (void)_loadData {

    //请求的数据
    NSDictionary *result = [WXDataService requestData:NEWS_WEB];
    
    //获取数据
    NSString *title = [result objectForKey:@"title"];
    NSString *content = [result objectForKey:@"content"];
    NSString *source = [result objectForKey:@"source"];
    NSString *time = [result objectForKey:@"time"];
    NSString *author = [NSString stringWithFormat:@"作者：%@",[result objectForKey:@"author"]];
    
    
    //加载html数据
    //获取文件
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"news" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    @"%@%@%@%@%@"
    
    //拼接数据
    NSString *html = [NSString stringWithFormat:htmlString,title,time,author,content,source];
    
    //获取资源包的基地址
    NSURL *baseURL = [NSBundle mainBundle].resourceURL;
    [_webView loadHTMLString:html baseURL:baseURL];
}

#pragma mark - UIWebView delegate
//加载开始
- (void)webViewDidStartLoad:(UIWebView *)webView {

    [_activityView startAnimating];
}
//加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {

    [_activityView stopAnimating];
}

@end
