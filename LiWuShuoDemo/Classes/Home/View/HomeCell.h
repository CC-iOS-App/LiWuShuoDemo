//
//  HomeCell.h
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/22.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Item;
@interface HomeCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *tagNewImageView;

@property (nonatomic, strong) Item *item;

@end
