//
//  ViewController.m
//  KCTabBarExample
//
//  Created by knowchatMac01 on 2019/5/14.
//  Copyright © 2019年 Hangzhou knowchat Information Technology Co., Ltd. All rights reserved.
//

#import "ViewController.h"
#import "KCTabBarController.h"

static NSString *cellID = @"cellID";

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *classNameAry;
@property (nonatomic, strong) UITableView *showTbv;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.classNameAry = @[@"KCMidBtnTabBar", @"KCNormalTabBar"];
    
    self.showTbv = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.showTbv.delegate = self;
    self.showTbv.dataSource = self;
    self.showTbv.tableFooterView = [UIView new];
    [self.showTbv registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [self.view addSubview:self.showTbv];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.classNameAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = self.classNameAry[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KCTabBarController *baseTBC = [[KCTabBarController alloc] initWithTabBarName:self.classNameAry[indexPath.row]];
    [self.navigationController pushViewController:baseTBC animated:YES];
}

@end
