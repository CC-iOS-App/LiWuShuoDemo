//
//  CalenderVC.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/25.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "CalenderVC.h"

@interface CalenderVC ()

@end

@implementation CalenderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:YES];
    //self.navigationItem.leftBarButtonItem = nil;

    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtnClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
