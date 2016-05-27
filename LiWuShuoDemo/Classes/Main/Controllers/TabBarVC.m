//
//  TabBarVC.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/22.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "TabBarVC.h"
#import "UIColor+CustomColor.h"
#import "BaseCollectionVC.h"
#import "PopularCollectionVC.h"
#import "ClassifyCollectionVC.h"
#import "MyselfCollectionVC.h"

@interface TabBarVC ()

@end

@implementation TabBarVC

+ (void)initialize
{
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor themeColor]} forState:UIControlStateSelected];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[UITabBar appearance] setTranslucent:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
