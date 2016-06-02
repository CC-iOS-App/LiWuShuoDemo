//
//  HomeDetailPageToolBar.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/6/2.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "HomeDetailPageToolBar.h"
#import "UIView+FrameExtension.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface HomeDetailPageToolBar ()

@property (nonatomic, weak) UIButton *likesBtn;
@property (nonatomic, weak) UIButton *shareBtn;
@property (nonatomic, weak) UIButton *commentBtn;

@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *lines;

@end

@implementation HomeDetailPageToolBar

- (NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)lines
{
    if (!_lines) {
        _lines = [NSMutableArray array];
    }
    return _lines;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    
        [self addChildViews];
    }
    return self;
}

- (void)addChildViews
{
    UIButton *likesBtn = [self addButtonWithTitle:nil imageName:@"content-details_like" selectedImageName:@"content-details_like_selected"];
    _likesBtn = likesBtn;
    
    UIButton *shareBtn = [self addButtonWithTitle:nil imageName:@"content-details_share" selectedImageName:nil];
    _shareBtn = shareBtn;
    
    UIButton *commentBtn = [self addButtonWithTitle:nil imageName:@"content-details_comments" selectedImageName:nil];
    _commentBtn = commentBtn;
    
    for (int i = 0; i < 2; i++) {
        UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"content-details_line"]];
        [self addSubview:line];
        [self.lines addObject:line];
    }
}

- (UIButton *)addButtonWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selImgName
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selImgName] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = kScreenWidth / self.btns.count;
    CGFloat h = self.height;
    
    for (int i = 0; i < self.btns.count; i++) {
        UIButton *btn = self.btns[i];
        x = i * w;
        btn.frame = CGRectMake(x, y, w, h);
    }
    
    int j = 1;
    for (UIImageView *line in self.lines) {
        line.x = j * w;
        j++;
    }
}




@end
