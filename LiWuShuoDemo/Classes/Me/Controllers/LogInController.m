//
//  LogInController.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/24.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "LogInController.h"

@interface LogInController ()

@end

@implementation LogInController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtnClicked:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
