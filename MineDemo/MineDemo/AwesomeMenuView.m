//
//  AwesomeMenuView.m
//  MineDemo
//
//  Created by shiyaohua on 16/4/25.
//  Copyright © 2016年 shiyaohua. All rights reserved.
//

#import "AwesomeMenuView.h"
#import "AwesomeMenu.h"

@interface AwesomeMenuView ()<AwesomeMenuDelegate>

@end

@implementation AwesomeMenuView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
        UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
        
        UIImage *starImage = [UIImage imageNamed:@"icon-star.png"];
        
        // Default Menu
        
        AwesomeMenuItem *starMenuItem11 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage highlightedImage:storyMenuItemImagePressed ContentImage:starImage highlightedContentImage:nil];
        
        AwesomeMenuItem *starMenuItem22 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage highlightedImage:storyMenuItemImagePressed ContentImage:starImage highlightedContentImage:nil];
        
        AwesomeMenuItem *starMenuItem33 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage highlightedImage:storyMenuItemImagePressed ContentImage:starImage highlightedContentImage:nil];
        
        AwesomeMenuItem *starMenuItem44 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage highlightedImage:storyMenuItemImagePressed ContentImage:starImage highlightedContentImage:nil];
        
        AwesomeMenuItem *starMenuItem55 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage highlightedImage:storyMenuItemImagePressed ContentImage:starImage highlightedContentImage:nil];
        
        NSArray *menuItems = [NSArray arrayWithObjects:starMenuItem11, starMenuItem22, starMenuItem33, starMenuItem44, starMenuItem55, nil];
        
        AwesomeMenuItem *startItem_1 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg-addbutton.png"]
                                                             highlightedImage:[UIImage imageNamed:@"bg-addbutton-highlighted.png"]
                                                                 ContentImage:[UIImage imageNamed:@"icon-plus.png"]
                                                      highlightedContentImage:[UIImage imageNamed:@"icon-plus-highlighted.png"]];
        
        AwesomeMenu *menu_1 = [[AwesomeMenu alloc] initWithFrame:UIScreenBounds startItem:startItem_1 menuItems:menuItems];
        menu_1.delegate = self;
        
        [self addSubview:menu_1];
        
        
        
        
        // Path-like customization
        AwesomeMenuItem *starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:starImage
                                                        highlightedContentImage:nil];
        AwesomeMenuItem *starMenuItem2 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:starImage
                                                        highlightedContentImage:nil];
        AwesomeMenuItem *starMenuItem3 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:starImage
                                                        highlightedContentImage:nil];
        AwesomeMenuItem *starMenuItem4 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:starImage
                                                        highlightedContentImage:nil];
        
        NSArray *menus = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4, nil];
        
        AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg-addbutton.png"]
                                                           highlightedImage:[UIImage imageNamed:@"bg-addbutton-highlighted.png"]
                                                               ContentImage:[UIImage imageNamed:@"icon-plus.png"]
                                                    highlightedContentImage:[UIImage imageNamed:@"icon-plus-highlighted.png"]];
        
        AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:UIScreenBounds startItem:startItem menuItems:menus];
        menu.delegate = self;
        
        menu.menuWholeAngle = M_PI_2;
        menu.farRadius = 110.0f;
        menu.endRadius = 100.0f;
        menu.nearRadius = 90.0f;
        menu.animationDuration = 0.3f;
        menu.startPoint = CGPointMake(50.0, 410.0);
        
        [self addSubview:menu];
    }
    return self;
}
/* ⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇ */
/* ⬇⬇⬇⬇⬇⬇ GET RESPONSE OF MENU ⬇⬇⬇⬇⬇⬇ */
/* ⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇ */

- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    NSLog(@"Select the index : %ld",idx);
}
- (void)awesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu {
    NSLog(@"Menu was closed!");
}
- (void)awesomeMenuDidFinishAnimationOpen:(AwesomeMenu *)menu {
    NSLog(@"Menu is open!");
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
