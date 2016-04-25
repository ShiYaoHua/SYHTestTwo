//
//  SVProgressHUDView.m
//  MineDemo
//
//  Created by shiyaohua on 16/4/25.
//  Copyright © 2016年 shiyaohua. All rights reserved.
//

#import "SVProgressHUDView.h"
#import "SVProgressHUD.h"

@implementation SVProgressHUDView

- (id)init {
    self = [super init];
    if (!self) return nil;
        
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:SVProgressHUDWillAppearNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:SVProgressHUDDidAppearNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:SVProgressHUDWillDisappearNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:)                                                 name:SVProgressHUDDidDisappearNotification object:nil];
    
    return self;
    
}
- (void)handleNotification:(NSNotification *)notification {
    NSLog(@"Notification recieved: %@", notification.name);
    NSLog(@"Status user info key: %@", notification.userInfo[SVProgressHUDStatusUserInfoKey]);
}


#pragma mark - Show Methods Sample

- (IBAction)show{
    [SVProgressHUD show];
}

- (IBAction)showWithStatus{
    [SVProgressHUD showWithStatus:@"Doing Stuff"];
}

static float progress = 0.0f;

- (IBAction)showWithProgress:(id)sender {
    progress = 0.0f;
    [SVProgressHUD showProgress:0 status:@"Loading"];
    [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.3f];
}

- (void)increaseProgress {
    progress += 0.1f;
    [SVProgressHUD showProgress:progress status:@"Loading"];
    
    if(progress < 1.0f){
        [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.3f];
    } else {
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.4f];
    }
}


#pragma mark - Dismiss Methods Sample

- (IBAction)dismiss {
    [SVProgressHUD dismiss];
}

- (IBAction)showInfoWithStatus {
    [SVProgressHUD showInfoWithStatus:@"Useful Information."];
}

- (IBAction)showSuccessWithStatus {
    [SVProgressHUD showSuccessWithStatus:@"Great Success!"];
}

- (IBAction)showErrorWithStatus {
    [SVProgressHUD showErrorWithStatus:@"Failed with Error"];
}


#pragma mark - Styling

//加载背景颜色
- (IBAction)changeStyle:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl*)sender;
    if(segmentedControl.selectedSegmentIndex == 0){
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    } else {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    }
}

//加载动画
- (IBAction)changeAnimationType:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl*)sender;
    if(segmentedControl.selectedSegmentIndex == 0){
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    } else {
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    }
}
//加载mask Nont可操作 其他加载时不可操作
- (IBAction)changeMaskType:(id)sender {
    
    UISegmentedControl *segmentedControl = (UISegmentedControl*)sender;
    
    if(segmentedControl.selectedSegmentIndex == 0){
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    } else if(segmentedControl.selectedSegmentIndex == 1){
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    } else if(segmentedControl.selectedSegmentIndex == 2){
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    } else if(segmentedControl.selectedSegmentIndex == 3){
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    } else {
        [SVProgressHUD setBackgroundLayerColor:[[UIColor redColor] colorWithAlphaComponent:0.4]];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    }
}
@end
