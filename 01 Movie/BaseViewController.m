//
//  BaseViewController.m
//  01 Movie
//
//  Created by lyb on 14-10-8.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //设置背景颜色
    self.view.backgroundColor = [UIColor blackColor];
    
    //取得导航控制器的自控制器的个数
    NSArray *viewCtrls = self.navigationController.viewControllers;
    
    if (viewCtrls.count > 1 || _isModal == YES) {
        //创建返回按钮
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 44, 44);
        //设置图片
        [backButton setImage:[UIImage imageNamed:@"backItem@2x"] forState:UIControlStateNormal];
        //点击高亮
        backButton.showsTouchWhenHighlighted = YES;
        //添加点击事件
        [backButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
    
    
}

//按钮点击事件
- (void)buttonAction:(UIButton *)button {

    if (_isModal) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }else {
    
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

//加载提示
- (void)showHUD:(NSString *)title {

    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = title;
    
}

//隐藏提示
- (void)hiddenHUD {

    [self.hud hide:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
