//
//  MyselfVC.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/6/7.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "MyselfVC.h"
#import "LogInController.h"

@interface MyselfVC ()

@end

@implementation MyselfVC

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (IBAction)messageBtnClicked:(UIButton *)sender
{
    LogInController *vc = [[LogInController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}



@end
