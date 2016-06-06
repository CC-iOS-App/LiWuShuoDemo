//
//  PopularDetailVC.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/6/4.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "PopularDetailVC.h"
#import "PopularDetailRequest.h"
#import "PopularDetailItem.h"
#import "MJExtension.h"
#import "PopularToolBar.h"
#import "UIView+FrameExtension.h"
#import "UIColor+CustomColor.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
static CGFloat kToolBarHeight = 44;

@interface PopularDetailVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) PopularToolBar *toolBar;
@property (nonatomic, strong) UIButton *leftSideBtn;
@property (nonatomic, strong) UIButton *rightSideBtn;
@property (nonatomic, strong) UIView *naviView;

@end

@implementation PopularDetailVC

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height - kToolBarHeight)];
        _webView.scrollView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    }
    return _webView;
}

- (PopularToolBar *)toolBar
{
    if (!_toolBar) {
        _toolBar = [PopularToolBar toolBar];
        _toolBar.frame = CGRectMake(0, self.view.height - kToolBarHeight, self.view.width, kToolBarHeight);
    }
    return _toolBar;
}

- (UIView *)naviView
{
    if (!_naviView) {
        UIView *naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
        naviView.backgroundColor = [UIColor themeColor];
        naviView.alpha = 0;
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"礼物详情";
        titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightThin];
        titleLabel.textColor = [UIColor whiteColor];
        [titleLabel sizeToFit];
        titleLabel.center = CGPointMake(kScreenWidth * 0.5, 40);
        [naviView addSubview:titleLabel];
        _naviView = naviView;
    }
    return _naviView;
}

- (UIButton *)leftSideBtn
{
    if (!_leftSideBtn) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(5, 25, 30, 30)];
        [btn setImage:[UIImage imageNamed:@"btnBack"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(leftSideBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
        _leftSideBtn = btn;
    }
    return _leftSideBtn;
}

- (UIButton *)rightSideBtn
{
    if (!_rightSideBtn) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 40, 25, 30, 30)];
        [btn setImage:[UIImage imageNamed:@"shopitem_navigation_share"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(rightSideBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
        _rightSideBtn = btn;
    }
    return _rightSideBtn;
}

- (void)leftSideBtnDidClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightSideBtnDidClicked
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setUpNavigationItems];
    self.webView.scrollView.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)setUpNavigationItems
{
    [self.view addSubview:self.webView];
    [self.view addSubview:self.toolBar];
    [self.view addSubview:self.naviView];
    [self.view addSubview:self.leftSideBtn];
    [self.view addSubview:self.rightSideBtn];
}

- (void)setItemId:(NSString *)itemId
{
    _itemId = itemId;
    PopularDetailRequest *request = [[PopularDetailRequest alloc] init];
    request.itemId = itemId;
    [request starWithFinishedBlock:^(NSError *error, id result) {
        PopularDetailItem *item = [PopularDetailItem mj_objectWithKeyValues:result[@"data"]];
        [self.webView loadHTMLString:item.detail_html baseURL:nil];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY >= 0 && offsetY <= 64) {
        self.naviView.alpha = offsetY / 64.0;
    }
    if (offsetY > 64) {
        self.naviView.alpha = 1;
    }
}




@end
