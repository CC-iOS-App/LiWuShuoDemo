//
//  ContainerVC.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/6/11.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "ContainerVC.h"
#import "UIColor+CustomColor.h"
#import "UIView+FrameExtension.h"
#import "HomeDetailPageToolBar.h"
#import "HomeDetailVC.h"

static CGFloat const kToolBarHeight = 44.0;

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width


@interface ContainerVC ()

@property (nonatomic, weak) HomeDetailPageToolBar *toolBar;

@property (nonatomic, strong) UIButton *leftSideBtn;
@property (nonatomic, strong) UIView *naviView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) HomeDetailVC *detailVC;

@end

@implementation ContainerVC

- (HomeDetailPageToolBar *)toolBar
{
    if (!_toolBar) {
        HomeDetailPageToolBar *toolBar = [[HomeDetailPageToolBar alloc] initWithFrame:CGRectMake(0, self.view.height - kToolBarHeight, [UIScreen mainScreen].bounds.size.width, kToolBarHeight)];
        [self.view addSubview:toolBar];
        _toolBar = toolBar;
    }
    return _toolBar;
}

- (UIButton *)leftSideBtn
{
    if (!_leftSideBtn) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(5, 25, 30, 30)];
        [btn setImage:[UIImage imageNamed:@"btnBack"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(backBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
        _leftSideBtn = btn;
    }
    return _leftSideBtn;
}

- (void)backBtnDidClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)naviView
{
    if (!_naviView) {
        UIView *naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
        naviView.backgroundColor = [UIColor themeColor];
        naviView.alpha = 0;
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"攻略详情";
        titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightThin];
        titleLabel.textColor = [UIColor whiteColor];
        [titleLabel sizeToFit];
        titleLabel.center = CGPointMake(self.view.width * 0.5, 40);
        [naviView addSubview:titleLabel];
        _naviView = naviView;
    }
    return _naviView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        scrollView.contentSize = CGSizeMake(kScreenWidth, 3 * kScreenHeight);
        scrollView.contentOffset = CGPointMake(0, kScreenHeight);
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.scrollEnabled = NO;
        _scrollView = scrollView;
    }
    return _scrollView;
}

//- (HomeDetailVC *)detailVC
//{
//    if (!_detailVC) {
//        HomeDetailVC *vc = [[HomeDetailVC alloc] init];
//        vc.view.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
//        vc.itemId = self.itemId;
//    }
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
