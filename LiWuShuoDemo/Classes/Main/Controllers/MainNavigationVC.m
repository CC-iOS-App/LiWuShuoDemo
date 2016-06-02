//
//  NavigationVC.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/22.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "MainNavigationVC.h"

@interface MainNavigationVC ()

@end

@implementation MainNavigationVC

+ (void)initialize
{
    UINavigationBar *naviBar = [UINavigationBar appearance];
    
    naviBar.translucent = NO;
    [naviBar setBackgroundImage:[UIImage imageNamed:@"barBackImg"] forBarMetrics:UIBarMetricsDefault];
    [naviBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                      NSFontAttributeName: [UIFont systemFontOfSize:17 weight:UIFontWeightThin]}];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
