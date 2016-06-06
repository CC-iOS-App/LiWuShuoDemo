//
//  DetailPageTopView.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/6/3.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "DetailPageTopView.h"
#import "UIImageView+WebCache.h"
#import "DetailItem.h"
#import "UIView+FrameExtension.h"



@interface DetailPageTopView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *labelView;

@end

@implementation DetailPageTopView

+ (instancetype)detailTopView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DetailPageTopView" owner:nil options:nil] lastObject];
}

- (void)setItem:(DetailItem *)item
{
    _item = item;
    [self.imageView sd_setImageWithURL:item.cover_image_url];
    self.labelView.text = item.title;
}


@end
