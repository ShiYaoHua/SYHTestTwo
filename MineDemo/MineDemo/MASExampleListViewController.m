//
//  MASExampleListViewController.m
//  MineDemo
//
//  Created by shiyaohua on 16/4/21.
//  Copyright © 2016年 shiyaohua. All rights reserved.
//

#import "MASExampleListViewController.h"
#import "MASExampleViewController.h"
#import "MASExampleBasicView.h"
#import "ExampleTableViewCell.h"
#import "SVProgressHUDView.h"
#import "AwesomeMenuView.h"
#import "TimeProgressView.h"
#import "UIFontView.h"
#import "LoginView.h"
#import "GrayPageControl.h"
#import "TestView.h"
#import "MP3View.h"
#import "PayView.h"
#import "AnimationView.h"


static NSString * const kMASCellReuseIdentifier = @"kMASCellReuseIdentifier";

@interface MASExampleListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *exampleControllers;

@end

@implementation MASExampleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Examples";
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:kMASCellReuseIdentifier];
    
    //cell自适应高度
    tableView.estimatedRowHeight = 40;
    tableView.rowHeight = UITableViewAutomaticDimension;

    
    self.exampleControllers =
    @[[[MASExampleViewController alloc] initWithTitle:@"Masony代码约束" viewClass:MASExampleBasicView.class],
      [[MASExampleViewController alloc] initWithTitle:@"UITableViewCell的子类实现了左右滑动显示信息视图并调出按钮" viewClass:ExampleTableViewCell.class],
      [[MASExampleViewController alloc] initWithTitle:@"SVProgressHUD_SDK" viewClass:SVProgressHUDView.class],
      [[MASExampleViewController alloc] initWithTitle:@"炫酷放射弹出按钮菜单" viewClass:AwesomeMenuView.class],
      [[MASExampleViewController alloc] initWithTitle:@"倒计时进度圈" viewClass:TimeProgressView.class],
      [[MASExampleViewController alloc] initWithTitle:@"字体集" viewClass:UIFontView.class],
      [[MASExampleViewController alloc] initWithTitle:@"第三方登录" viewClass:LoginView.class],
      [[MASExampleViewController alloc] initWithTitle:@"自定义分页控制器" viewClass:GrayPageControl.class],
      [[MASExampleViewController alloc] initWithTitle:@"计算label的大小" viewClass:TestView.class],
      [[MASExampleViewController alloc] initWithTitle:@"mp3" viewClass:MP3View.class],
      [[MASExampleViewController alloc] initWithTitle:@"支付宝支付" viewClass:PayView.class],
      [[MASExampleViewController alloc] initWithTitle:@"弹出动画视图" viewClass:AnimationView.class]
      ];
    
    

    

}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = self.exampleControllers[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMASCellReuseIdentifier forIndexPath:indexPath];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = viewController.title;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.exampleControllers.count;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *viewController = self.exampleControllers[indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
