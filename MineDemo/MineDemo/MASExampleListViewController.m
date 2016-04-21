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


@interface MASExampleListViewController ()

@property (nonatomic, strong) NSArray *exampleControllers;

@end

@implementation MASExampleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Examples";
    
    self.exampleControllers =
    @[[[MASExampleViewController alloc] initWithTitle:@"Masony代码约束" viewClass:MASExampleBasicView.class]
      ];
    

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
