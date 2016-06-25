//
//  UIView+DegressCenter.m
//  ElasticViewAnimation
//
//  Created by xp_mac on 16/1/11.
//  Copyright © 2016年 xp_mac. All rights reserved.
//

#import "UIView+DegressCenter.h"

@implementation UIView (DegressCenter)

- (CGPoint) usePresentationLayerIfPossible:(BOOL)theBool
{
    if (theBool == YES) {
        
        CALayer *theLayer = self.layer;
        return [[theLayer presentationLayer] position];
    }
    
    return self.center;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com