//
//  PopularCell.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/23.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "PopularCell.h"
#import "PopularItem.h"
#import "UIImageView+WebCache.h"

@interface PopularCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;

@end

@implementation PopularCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 0.2;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    // Initialization code
}

- (void)setItem:(PopularItem *)item
{
    _item = item;
    [self.coverImgView sd_setImageWithURL:item.cover_image_url placeholderImage:[UIImage imageNamed:@"popplace"]];
    self.nameLabel.text = item.name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",item.price];
    self.favoriteLabel.text = [NSString stringWithFormat:@"%d",item.favorites_count];
}

@end
