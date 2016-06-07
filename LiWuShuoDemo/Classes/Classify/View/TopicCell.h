//
//  TopicCell.h
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/6/6.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicCell : UITableViewCell

@property (nonatomic, strong) NSArray *firstItems;

@end




@class FirstItem;
@interface TopCollectionCell : UICollectionViewCell

@property (nonatomic, strong) FirstItem *item;

@end
