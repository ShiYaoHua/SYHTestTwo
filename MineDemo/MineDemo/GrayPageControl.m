//
//  GrayPageControl.m
//  MineDemo
//
//  Created by shiyaohua on 16/5/20.
//  Copyright © 2016年 shiyaohua. All rights reserved.
//

#import "GrayPageControl.h"

@implementation GrayPageControl


-(void)updateDots{
    
    self.pageIndicatorTintColor = [UIColor clearColor];
    self.currentPageIndicatorTintColor = [UIColor clearColor];
    
    for (int i=0; i<self.subviews.count; i++) {
        
        UIView* dot = [self.subviews objectAtIndex:i];
        
        CGSize size;
        
        size.height = 1;     //自定义圆点的大小
        
        size.width = 12;      //自定义圆点的大小
        
        [dot setFrame:CGRectMake(dot.frame.origin.x, dot.frame.origin.y, size.width, size.height)];
        
        if (i==self.currentPage){
            dot.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_lunbo_icon"]];
            
        }else {
            dot.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_lunbobai_icon"]];
        }
        
    }
    
    
}

-(void)setCurrentPage:(NSInteger)page{
    
    [super setCurrentPage:page];
    
    [self updateDots];
    
}

@end
