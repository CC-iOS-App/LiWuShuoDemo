//
//  ClassifyVC.m
//  LiWuShuoDemo
//
//  Created by XUN WANG on 16/6/6.
//  Copyright © 2016年 XUN WANG. All rights reserved.
//

#import "ClassifyVC.h"
#import "TopicCell.h"
#import "OtherCell.h"
#import "ClassifyRequest.h"
#import "FirstItem.h"
#import "MJExtension.h"
#import "SearchVC.h"

static NSString * const kTopicCell = @"TopicCell";
static NSString * const kOtherCell = @"kOtherCell";

@interface ClassifyVC ()

@property (nonatomic, strong) NSArray *channelGroups;
@property (nonatomic, strong) NSArray *banners;

@end

@implementation ClassifyVC

- (NSArray *)channelGroups
{
    if (!_channelGroups) {
        _channelGroups = [NSArray array];
    }
    return _channelGroups;
}

- (NSArray *)banners
{
    if (!_banners) {
        _banners = [NSArray array];
    }
    return _banners;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    
//    self.tableView.estimatedRowHeight = 44.0;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"TopicCell" bundle:nil] forCellReuseIdentifier:kTopicCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"OtherCell" bundle:nil] forCellReuseIdentifier:kOtherCell];
    [self getDataBack];

//    [self.tableView setValue:@(UITableViewStyleGrouped) forKey:@"style"];
}

- (void)getDataBack
{
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    ClassifyRequest *firstRequest = [[ClassifyRequest alloc] init];
    [firstRequest starWithFinishedBlock:^(NSError *error, id result) {
        if (!error) {
            self.banners = [FirstItem mj_objectArrayWithKeyValuesArray:[result[@"data"] objectForKey:@"collections"
                                                                        ]];
            dispatch_group_leave(group);
        }
    }];
    
    dispatch_group_enter(group);
    ChannelsRequest *secondRequest = [[ChannelsRequest alloc] init];
    [secondRequest starWithFinishedBlock:^(NSError *error, id result) {
        if (!error) {
            self.channelGroups = [Channel mj_objectArrayWithKeyValuesArray:[result[@"data"] objectForKey:@"channel_groups"]];
            dispatch_group_leave(group);
        }
    }];
    

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.channelGroups.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:kTopicCell];
        cell.firstItems = self.banners;
        return cell;
    }else {
        OtherCell *cell = [tableView dequeueReusableCellWithIdentifier:kOtherCell];
        Channel *channel = self.channelGroups[indexPath.section - 1];
        cell.channel = channel;
        return cell;
    }   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 140;
    }else {
        Channel *channel = self.channelGroups[indexPath.section - 1];
        int row = (int)(channel.channels.count / 4.0 + 0.5);

        return 36 + row * 100 + (row - 1) * 20 + 2 * kMargin;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else {
        return 10;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = 10;
            if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
                scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    
            } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
                scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    
            }
}

- (IBAction)rightSideBtnClicked:(UIButton *)sender
{
    SearchVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
    [self.navigationController.navigationBar setHidden: YES];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
