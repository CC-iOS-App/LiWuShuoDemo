//
//  FristCell.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/6/4.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "FristCell.h"
#import "FirstItem.h"
#import "UIImageView+WebCache.h"

@interface  FristCell ()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation FristCell

- (UIImageView *)imageView
{
    if (!_imageView) {
        UIImageView *img = [[UIImageView alloc] init];
        [self.contentView addSubview:img];
    }
    return _imageView;
}

- (void)layoutSubviews
{
    self.imageView.frame = self.bounds;
}

- (void)setItem:(FirstItem *)item
{
    _item = item;
    [self.imageView sd_setImageWithURL:item.banner_image_url placeholderImage:[UIImage imageNamed:@"placeholderimage_small"]];
}

@end
