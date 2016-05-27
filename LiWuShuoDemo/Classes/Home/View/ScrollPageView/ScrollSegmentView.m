//
//  ScrollSegmentView.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/25.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "ScrollSegmentView.h"
#import "UIColor+CustomColor.h"
#import "UIView+FrameExtension.h"

static CGFloat const kScrollLineHeight = 1.0;
static CGFloat const kTitleMargin      = 20.0;

@interface ScrollSegmentView ()


@property (nonatomic, weak) UIView *scrollLine;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIButton *extraBtn;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *titleLabels;
@property (nonatomic, strong) NSMutableArray *titleWidths;
@property (nonatomic, copy) TitleLabelClicked titleLabelClicked;

@end

@implementation ScrollSegmentView

{
    NSInteger _currentIndex;
    NSInteger _exIndex;
}

//懒加载
- (UIView *)scrollLine
{
    if (!_scrollLine) {
        UIView *scrollLine = [[UIView alloc] init];
        scrollLine.backgroundColor = [UIColor themeColor];
        
        [self.scrollView addSubview:scrollLine];
        _scrollLine = scrollLine;
    }
    return _scrollLine;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = NO;
        scrollView.bounces = NO;
        
        _scrollView = scrollView;
        [self addSubview:scrollView];
    }
    return _scrollView;
}

- (UIButton *)extraBtn
{
    if (!_extraBtn) {
        UIButton *extraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        extraBtn.backgroundColor = [UIColor whiteColor];
        
        [extraBtn setImage:[UIImage imageNamed:@"giftcategorydetail_arrow_down_gray"] forState:UIControlStateNormal];
        [extraBtn addTarget:self  action:@selector(extraBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        extraBtn.layer.shadowColor = [UIColor whiteColor].CGColor;
        extraBtn.layer.shadowOffset = CGSizeMake(-5, 0);
        extraBtn.layer.shadowOpacity = 1;
        
        [self addSubview: extraBtn];
        _extraBtn = extraBtn;
    }
    return _extraBtn;
}

- (void)extraBtnDidClicked:(UIButton *)button
{
    if (self.extraBtnClicked) {
        self.extraBtnClicked(button);
    }
}

- (NSArray *)titles
{
    if (!_titles) {
        _titles = [NSArray array];
    }
    return _titles;
}

- (NSMutableArray *)titleLabels
{
    if (!_titleLabels) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

- (NSMutableArray *)titleWidths
{
    if (!_titleWidths) {
        _titleWidths = [NSMutableArray array];
    }
    return _titleWidths;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles titleLabelClicked:(TitleLabelClicked)titleLabelClicked
{
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        self.titleLabelClicked = titleLabelClicked;
        _exIndex = 0;
        _currentIndex = 0;
        
        [self setUpTitles];
        [self setUpScrollViewAndExtraBtn];
        [self LabelsPositionAndFirstScrollLineAndScrollView];
    }
    return self;
}

- (void)setUpTitles
{
    int i = 0;
    for (NSString *title in self.titles) {
        UILabel *label = [[UILabel alloc] init];
        label.tag = i;
        label.text = title;
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelDidClicked:)];
        [label addGestureRecognizer:tap];
        
        CGFloat titleWidth = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.width;
        
        [self.titleWidths addObject:@(titleWidth)];
        [self.titleLabels addObject:label];
        [self.scrollView addSubview:label];
        
        i++;
    }
}

- (void)titleLabelDidClicked:(UITapGestureRecognizer *)tap
{
    UILabel *currentLabel = (UILabel *)tap.view;

    _currentIndex = currentLabel.tag;
    [self adjustUIwhenClickedLabel];
}

- (void)adjustUIwhenClickedLabel
{
    if (_currentIndex == _exIndex) {
        return;
    }
    UILabel *exLabel = self.titleLabels[_exIndex];
    UILabel *currentLabel = self.titleLabels[_currentIndex];
    
    [self updateTitleOffsetToCurrentIndex:_currentIndex];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        exLabel.textColor = [UIColor darkGrayColor];
        currentLabel.textColor = [UIColor themeColor];
        
        weakSelf.scrollLine.x = currentLabel.x;
        weakSelf.scrollLine.width = currentLabel.width;
    }];
    
    _exIndex = _currentIndex;
    if (self.titleLabelClicked) {
        self.titleLabelClicked(currentLabel,_currentIndex);
    }
}

- (void)updateTitleOffsetToCurrentIndex:(NSInteger)index
{
    UILabel *currentLabel = self.titleLabels[index];
    CGFloat offsetX = currentLabel.center.x - self.width * 0.5;
    if (offsetX < 0) {
        offsetX = 0;
    }
    CGFloat maxOffsetX = self.scrollView.contentSize.width - (self.width - self.extraBtn.width);
    
    if (maxOffsetX < 0) {
        maxOffsetX = 0;
    }
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    int i = 0;
    for (UILabel *label in self.titleLabels) {
        if (i == index) {
            label.textColor = [UIColor themeColor];
        }else {
            label.textColor = [UIColor darkGrayColor];
        }
        i++;
    }
}

- (void)setUpScrollViewAndExtraBtn
{
    CGFloat extraW = 44;
    self.scrollView.frame = CGRectMake(0, 0, self.width - self.extraBtn.width, self.height);
    self.extraBtn.frame = CGRectMake(self.width - extraW, 0, extraW, self.height);
    
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homechannel_matte_left"]];
    [self addSubview:imgV];
    imgV.x = 0;
    imgV.y = 0;
    
    NSLog(@"%@",NSStringFromCGRect(self.extraBtn.frame));
}

- (void)LabelsPositionAndFirstScrollLineAndScrollView
{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 0;
    CGFloat h = self.height - kScrollLineHeight;
    
    int i = 0;
    for (UILabel *label in self.titleLabels) {
        w = [self.titleWidths[i] floatValue];
        x = kTitleMargin;
        
        if (i != 0) {
            UILabel *exLabel = self.titleLabels[i - 1];
            x = CGRectGetMaxX(exLabel.frame) + kTitleMargin;
        }
           label.frame = CGRectMake(x, y, w, h);
        i++;
    }
    
    UILabel *firstLabel = self.titleLabels[0];
    firstLabel.textColor = [UIColor themeColor];
    self.scrollLine.frame = CGRectMake(firstLabel.x, self.height - kScrollLineHeight, firstLabel.width, kScrollLineHeight);
    
    UILabel *lastLabel = [self.titleLabels lastObject];
    self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame) + kTitleMargin, 0);
}

- (void)updateUIWithProgress:(CGFloat)progress exindex:(NSInteger)exIndex currentIndex:(NSInteger)currentIndex
{
    _exIndex = currentIndex;
    UILabel *exLabel = self.titleLabels[exIndex];
    UILabel *currentLabel = self.titleLabels[currentIndex];
    
    CGFloat deltaX = currentLabel.x - exLabel.x;
    CGFloat deltaW = currentLabel.width - exLabel.width;
    
    self.scrollLine.x = exLabel.x + deltaX * progress;
    self.scrollLine.width = exLabel.width + deltaW * progress;
}




@end
