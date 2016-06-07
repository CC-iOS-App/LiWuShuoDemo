//
//  SecondCell.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/6/4.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "SecondCollectionCell.h"
#import "UIView+FrameExtension.h"
#import "FirstItem.h"
#import "UIImageView+WebCache.h"

@interface SecondCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation SecondCollectionCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.imageView.layer.cornerRadius = self.imageView.height * 0.5;
    self.imageView.layer.masksToBounds = YES;
}

- (void)setItem:(SecondItem *)item
{
    _item = item;
    [self.imageView sd_setImageWithURL:item.icon_url];
    self.titleLabel.text = item.name;
}

@end
