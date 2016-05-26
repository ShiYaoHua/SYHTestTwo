//
//  MASExampleViewController.m
//  MineDemo
//
//  Created by shiyaohua on 16/4/21.
//  Copyright © 2016年 shiyaohua. All rights reserved.
//

#import "MASExampleViewController.h"
#import "SVProgressHUDView.h"
#import "LoginView.h"
#import "MP3View.h"

@interface MASExampleViewController ()

@property (nonatomic, strong) Class viewClass;

@end

@implementation MASExampleViewController

- (id)initWithTitle:(NSString *)title viewClass:(Class)viewClass {
    self = [super init];
    if (!self) return nil;
    
    self.title = title;
   
    self.viewClass = viewClass;

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
     if ([self.title isEqualToString:@"SVProgressHUD_SDK"]) {
         self.view = [[[NSBundle mainBundle]loadNibNamed:@"SVProgressHUDView" owner:self options:nil]lastObject];
     }else{
         self.view = self.viewClass.new;
     }
    
    if ([self.title isEqualToString:@"第三方登录"]) {
        self.view = [[[NSBundle mainBundle]loadNibNamed:@"LoginView" owner:self options:nil]lastObject];
    }else{
        self.view = self.viewClass.new;
    }
    
    if ([self.title isEqualToString:@"mp3"]) {
        self.view = [[[NSBundle mainBundle]loadNibNamed:@"MP3View" owner:self options:nil]lastObject];
    }else{
        self.view = self.viewClass.new;
    }
    self.view.backgroundColor = [UIColor whiteColor];
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
