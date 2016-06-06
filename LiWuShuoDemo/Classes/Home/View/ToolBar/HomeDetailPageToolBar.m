//
//  HomeDetailPageToolBar.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/6/2.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "HomeDetailPageToolBar.h"
#import "UIView+FrameExtension.h"
#import "DetailItem.h"

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
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addChildViews
{
    UIButton *likesBtn = [self addButtonWithTitle:nil imageName:@"content-details_like" selectedImageName:@"content-details_like_selected"];
    [likesBtn addTarget:self action:@selector(likesBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
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
    
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    topLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:topLine];
}

- (UIButton *)addButtonWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selImgName
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selImgName] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
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
        line.y = 0.5 * (self.height - line.height);
        j++;
    }
    
    
}

- (void)setItem:(DetailItem *)item
{
    _item = item;

    [self.likesBtn setTitle:[NSString stringWithFormat:@"%d",item.likes_count] forState:UIControlStateNormal];
    [self.shareBtn setTitle:[NSString stringWithFormat:@"%d",item.shares_count] forState:UIControlStateNormal];
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%d",item.comments_count] forState:UIControlStateNormal];
}

- (void)likesBtnClicked:(UIButton *)sender
{

    
    if (sender.selected) {
        [sender setTitle:[NSString stringWithFormat:@"%d",--self.item.likes_count] forState:UIControlStateNormal];
 
    }else {
        [sender setTitle:[NSString stringWithFormat:@"%d",++self.item.likes_count] forState:UIControlStateNormal];
    }

    sender.selected = !sender.isSelected;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values   = @[@0.95,@1.2,@1];
    animation.keyTimes = @[@0.1,@0.6,@1];
    [sender.imageView.layer addAnimation:animation forKey:nil];
    
}



@end
