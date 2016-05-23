//
//  HomeCell.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/22.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "HomeCell.h"
#import "UIImage+Extension.h"
#import "UIView+FrameExtension.h"
#import "Item.h"
#import "UIImageView+WebCache.h"


@interface HomeCell ()

@property (weak, nonatomic) IBOutlet UILabel *likesNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *likesBtn;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *coverImgView;


@end

@implementation HomeCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    [self.likesBtn addTarget:self action:@selector(likesBtnCliked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setItem:(Item *)item
{
    _item = item;
    self.title.text = item.title;
   [self.coverImgView sd_setImageWithURL:item.cover_image_url placeholderImage:[UIImage imageNamed:@"placeholderimage_big"]];
    self.likesNumLabel.text = [NSString stringWithFormat:@"%d",item.likes_count];
}

- (void)likesBtnCliked
{
    if (self.likesBtn.selected) {
        self.likesNumLabel.text = [NSString stringWithFormat:@"%d",--self.item.likes_count];
    }else {
        self.likesNumLabel.text = [NSString stringWithFormat:@"%d",++self.item.likes_count];
    }
    self.likesBtn.selected = !self.likesBtn.isSelected;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values   = @[@0.95,@1.2,@1];
    animation.keyTimes = @[@0.1,@0.6,@1];
    [self.likesBtn.layer addAnimation:animation forKey:nil];
}

@end
