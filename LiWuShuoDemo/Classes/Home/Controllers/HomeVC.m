//
//  HomeVC.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/25.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "HomeVC.h"
#import "UIImage+Extension.h"
#import "UIView+FrameExtension.h"
#import "ScrollPageView.h"
#import "BaseCollectionVC.h"
#import "HandPickrequest.h"
#import "OverseasRequest.h"
#import "GirlFriendRequest.h"
#import "CreativeLifeRequest.h"
#import "GayFriendRequest.h"
#import "ParentsRequest.h"
#import "ColleagueRequest.h"
#import "BabyRequest.h"
#import "DesignRequest.h"
#import "ArtRequest.h"
#import "UnusualRequest.h"
#import "TechRequest.h"
#import "CutyRequest.h"
#import "HomeCollectionVC.h"
#import "UIColor+CustomColor.h"

#import "CalenderVC.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface HomeVC ()

@property (nonatomic, strong) UIView *naviView;
@property (nonatomic, strong) UIButton *leftSideButton;
@property (nonatomic, strong) UIButton *rightSideButton;
@property (nonatomic, strong) UIImageView *titleView;


@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationItems];
    [self setUpScrollPageView];
  
}

- (void)setUpNavigationItems
{
    [self.view addSubview:self.naviView];
    [self.view addSubview:self.leftSideButton];
    [self.view addSubview:self.rightSideButton];
    [self.view addSubview:self.titleView];

}

- (void)setUpScrollPageView
{
    ScrollPageView *scrollPageView = [[ScrollPageView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height) childVCs:[self setupChildVcAndTitle] parentVC:self];
    [self.view addSubview:scrollPageView];
    scrollPageView.extraBtnClicked = ^(UIButton *extraBtn){
        NSLog(@"======");
    };
}

- (NSArray *)setupChildVcAndTitle {
    
    HomeCollectionVC *vc1 = [[HomeCollectionVC alloc] init];
    vc1.title = @"精选";
    
    BaseCollectionVC *vc2 = [[BaseCollectionVC alloc] init];
    vc2.baseRequest = [[OverseasRequest alloc] init];
    vc2.loadMoreRequest = [[LoadMoreOverseasRequest alloc] init];
    vc2.title = @"海淘";
    
    BaseCollectionVC *vc3 = [[BaseCollectionVC alloc] init];
    vc3.baseRequest = [[GirlFriendRequest alloc] init];
    vc3.loadMoreRequest = [[LoadMoreGirlFriendsRequest alloc] init];
    vc3.title = @"送女票";
    
    BaseCollectionVC *vc4 = [[BaseCollectionVC alloc] init];
    vc4.baseRequest = [[CreativeLifeRequest alloc] init];
    vc4.loadMoreRequest = [[LoadMoreCreativeLifeRequest alloc] init];
    vc4.title = @"创意生活";
    
    BaseCollectionVC *vc5 = [[BaseCollectionVC alloc] init];
    vc5.baseRequest = [[GayFriendRequest alloc] init];
    vc5.loadMoreRequest = [[LoadMoreGayFriendRequest alloc] init];
    vc5.title = @"送基友";
    
    BaseCollectionVC *vc6 = [[BaseCollectionVC alloc] init];
    vc6.baseRequest = [[ParentsRequest alloc] init];
    vc6.loadMoreRequest = [[LoadMoreParentsRequest alloc] init];
    vc6.title = @"送爸妈";
    
    BaseCollectionVC *vc7 = [[BaseCollectionVC alloc] init];
    vc7.baseRequest = [[ColleagueRequest alloc] init];
    vc7.loadMoreRequest = [[LoadMoreColleagueRequest alloc] init];
    vc7.title = @"送同事";
    
    BaseCollectionVC *vc8 = [[BaseCollectionVC alloc] init];
    vc8.baseRequest = [[BabyRequest alloc] init];
    vc8.loadMoreRequest = [[LoadMoreBabiesRequest alloc] init];
    vc8.title = @"送宝贝";
    
    BaseCollectionVC *vc9 = [[BaseCollectionVC alloc] init];
    vc9.baseRequest = [[DesignRequest alloc] init];
    vc9.loadMoreRequest = [[LoadMoreDesignRequest alloc] init];
    vc9.title = @"设计感";
    
    BaseCollectionVC *vc10 = [[BaseCollectionVC alloc] init];
    vc10.baseRequest = [[ArtRequest alloc] init];
    vc10.loadMoreRequest = [[LoadMoreArtRequest alloc] init];
    vc10.title = @"文艺风";
    
    BaseCollectionVC *vc11 = [[BaseCollectionVC alloc] init];
    vc11.baseRequest = [[UnusualRequest alloc] init];
    vc11.loadMoreRequest = [[LoadMoreUnusualRequest alloc] init];
    vc11.title = @"奇葩搞怪";
    
    BaseCollectionVC *vc12 = [[BaseCollectionVC alloc] init];
    vc12.baseRequest = [[TechRequest alloc] init];
    vc12.loadMoreRequest = [[LoadMoreTechRequest alloc] init];
    vc12.title = @"科技范";
    
    BaseCollectionVC *vc13 = [[BaseCollectionVC alloc] init];
    vc13.baseRequest = [[CutyRequest alloc] init];
    vc13.loadMoreRequest = [[LoadMoreCutyRequest alloc] init];
    vc13.title = @"萌萌哒";
    
    NSArray *childVcs = [NSArray arrayWithObjects:vc1, vc2, vc3, vc4, vc5, vc6, vc7, vc8, vc9 , vc10, vc11, vc12,vc13,nil];
    return childVcs;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)searchItemClicked
{
    
}

- (void)leftBarButtonItemClicked
{
    CalenderVC *vc = [[CalenderVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 懒加载
- (UIView *)naviView
{
    if (!_naviView) {
        UIView *naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
        naviView.backgroundColor = [UIColor themeColor];
        _naviView = naviView;
    }
    return _naviView;
}

- (UIButton *)leftSideButton
{
    if (!_leftSideButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15, 25, 30, 30)];
        [button setImage:[UIImage nonRenderingImageName:@"feed_signin"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(leftBarButtonItemClicked) forControlEvents:UIControlEventTouchUpInside];
        _leftSideButton = button;
    }
    return _leftSideButton;
}

- (UIButton *)rightSideButton
{
    if (!_rightSideButton) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 40, 25, 30, 30)];
        [button setImage:[UIImage nonRenderingImageName:@"icon_navigation_search"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(searchItemClicked) forControlEvents:UIControlEventTouchUpInside];
        _rightSideButton = button;
    }
    return _rightSideButton;
}

- (UIImageView *)titleView
{
    if (!_titleView) {
        UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage nonRenderingImageName:@"app_logo"]];
        titleView.centerX = kScreenWidth * 0.5;
        titleView.centerY = 40;
        _titleView = titleView;
    }
    return _titleView;
}

@end
