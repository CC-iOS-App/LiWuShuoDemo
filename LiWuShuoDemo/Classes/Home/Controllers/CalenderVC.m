//
//  CalenderVC.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/25.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "CalenderVC.h"

@interface CalenderVC ()
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation CalenderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [self loadCanlenderView];
    self.webview.scrollView.bounces = NO;
}

- (void)loadCanlenderView
{
    NSString *js = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"calendar" ofType:@"js" ]encoding:NSUTF8StringEncoding error:nil];

//    [self.webview loadHTMLString:js baseURL:nil];
    [self.webview stringByEvaluatingJavaScriptFromString:js];
}

- (IBAction)backBtnClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
