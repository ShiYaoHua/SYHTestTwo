//
//  UIFontView.m
//  MineDemo
//
//  Created by shiyaohua on 16/4/26.
//  Copyright © 2016年 shiyaohua. All rights reserved.
//

#import "UIFontView.h"


@interface UIFontView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSArray *fontArr;

@end

@implementation UIFontView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
       self.fontArr = [UIFont familyNames];
        NSLog(@"字体集 %@",self.fontArr);
        
        UITableView *tableView = [[UITableView alloc]initWithFrame:UIScreenBounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self addSubview:tableView];
        
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.fontArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        
    }
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont fontWithName:[self.fontArr objectAtIndex:indexPath.row] size:15];
    cell.textLabel.text = [NSString stringWithFormat:@"综合课程 产品经理 企业培训: %@",[self.fontArr objectAtIndex:indexPath.row]];
    
    return cell;
    
}

@end
