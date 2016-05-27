//
//  HomeCollectionVC.h
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/5/22.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseRequest;
@interface BaseCollectionVC : UICollectionViewController

@property (nonatomic, strong) BaseRequest *baseRequest;
@property (nonatomic, strong) BaseRequest *loadMoreRequest;

@end
