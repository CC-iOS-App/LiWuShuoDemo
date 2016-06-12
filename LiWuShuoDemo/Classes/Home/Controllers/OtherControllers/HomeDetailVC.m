//
//  DetailVC.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/6/2.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "HomeDetailVC.h"
#import "DetailRequest.h"
#import "DetailItem.h"
#import "MJExtension.h"
#import "UIView+FrameExtension.h"
#import "HomeDetailPageToolBar.h"
#import "DetailPageTopView.h"
#import "UIColor+CustomColor.h"

static CGFloat const kToolBarHeight = 44.0;
static CGFloat const kTopViewHeight = 160.0;

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface HomeDetailVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, weak) HomeDetailPageToolBar *toolBar;
@property (nonatomic, strong) DetailPageTopView *topView;
@property (nonatomic, strong) UIButton *leftSideBtn;
@property (nonatomic, strong) UIView *naviView;


@end

@implementation HomeDetailVC

- (UIWebView *)webView
{
    if (!_webView) {
        UIWebView *webView = [[UIWebView alloc] init];
        webView.frame = CGRectMake(0, 0, self.view.width, self.view.height - kToolBarHeight);
        webView.backgroundColor = [UIColor whiteColor];
        webView.scrollView.showsVerticalScrollIndicator = NO;
        webView.scrollView.contentInset = UIEdgeInsetsMake(kTopViewHeight, 0, 0, 0);
        _webView = webView;
    }
    return _webView;
}

- (HomeDetailPageToolBar *)toolBar
{
    if (!_toolBar) {
        HomeDetailPageToolBar *toolBar = [[HomeDetailPageToolBar alloc] initWithFrame:CGRectMake(0, self.view.height - kToolBarHeight, [UIScreen mainScreen].bounds.size.width, kToolBarHeight)];
        [self.view addSubview:toolBar];
        _toolBar = toolBar;
    }
    return _toolBar;
}

- (DetailPageTopView *)topView
{
    if (!_topView) {
        _topView = [DetailPageTopView detailTopView];
        _topView.frame = CGRectMake(0, 0, kScreenWidth, kTopViewHeight);
    }
    return _topView;
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

- (UIView *)naviView
{
    if (!_naviView) {
        UIView *naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
        naviView.backgroundColor = [UIColor themeColor];
        naviView.alpha = 0;
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"攻略详情";
        titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightThin];
        titleLabel.textColor = [UIColor whiteColor];
        [titleLabel sizeToFit];
        titleLabel.center = CGPointMake(kScreenWidth * 0.5, 40);
        [naviView addSubview:titleLabel];
        _naviView = naviView;
    }
    return _naviView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.webView];
    NSLog(@"lalalala%@",NSStringFromCGRect(self.webView.frame));
    [self.view addSubview:self.topView];
    [self.view addSubview:self.naviView];
    [self.view addSubview:self.leftSideBtn];
    self.webView.scrollView.delegate = self;
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)setItemId:(NSString *)itemId
{
    _itemId = itemId;
    DetailRequest *request = [[DetailRequest alloc] init];
    request.itemId = itemId;
    [request starWithFinishedBlock:^(NSError *error, id result) {
        if (!error) {
            DetailItem *item = [DetailItem mj_objectWithKeyValues:result[@"data"]];
            [self.webView loadHTMLString:item.content_html baseURL:nil];
            self.toolBar.item = item;
            self.topView.item = item;
        }
    }];
}

- (void)leftSideBtnDidClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY>-180) {
        self.topView.y = 0 - 180 - offsetY;
        
        self.naviView.alpha = (offsetY+180) / 100;
        if (self.naviView.alpha >= 1) {
            self.naviView.alpha = 1;
        }
    }
    if (offsetY <= -180 && offsetY > -240) {
        self.topView.y = 0;
        self.topView.height = kTopViewHeight - 180 - offsetY;
        self.naviView.alpha = 0;
    }
    
}

@end
