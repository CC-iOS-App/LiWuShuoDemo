//
//  SearchVC.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/6/4.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "SearchVC.h"
#import "UIView+FrameExtension.h"

@interface SearchVC ()
@property (weak, nonatomic) IBOutlet UITextField *searchBar;


@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSearchBar];
    
    // Do any additional setup after loading the view.
}

- (void)setUpSearchBar
{
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchView"]];
    img.width = img.width + 10;
    img.contentMode = UIViewContentModeCenter;
    self.searchBar.leftView = img;
    
    self.searchBar.leftViewMode = UITextFieldViewModeAlways;
     [self.searchBar becomeFirstResponder];
}

- (IBAction)cancelBtnDidClicked:(UIButton *)sender {
    [self resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}



@end
