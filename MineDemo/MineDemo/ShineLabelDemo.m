//
//  ShineLabelDemo.m
//  MineDemo
//
//  Created by gutrip on 16/6/26.
//  Copyright © 2016年 shiyaohua. All rights reserved.
//

#import "ShineLabelDemo.h"
#import "RQShineLabel.h"

@interface ShineLabelDemo ()

@property (strong, nonatomic) RQShineLabel *shineLabel;
@property (strong, nonatomic) NSArray *textArray;
@property (assign, nonatomic) NSUInteger textIndex;
@property (strong, nonatomic) UIImageView *wallpaper1;
@property (strong, nonatomic) UIImageView *wallpaper2;
@end

@implementation ShineLabelDemo


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _textArray = @[
                       @"For something this complicated, it’s really hard to design products by focus groups. A lot of times, people don’t know what they want until you show it to them.",
                       @"We’re just enthusiastic about what we do.",
                       @"We made the buttons on the screen look so good you’ll want to lick them."
                       ];
        _textIndex  = 0;
        
        [self initSetup];
        [self.shineLabel shine];

    }
    return self;
}
- (void)initSetup{
    
    self.wallpaper1 = ({
        UIImageView *imageView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wallpaper1"]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.frame = CGRectMake(0, 64, UIScreenBounds.size.width, CGRectGetHeight(UIScreenBounds) - 64);
        imageView;
    });
    [self addSubview:self.wallpaper1];
    
    self.wallpaper2 = ({
        UIImageView *imageView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wallpaper2"]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.frame =  CGRectMake(0, 64, UIScreenBounds.size.width, CGRectGetHeight(UIScreenBounds) - 64);
        imageView.alpha = 0;
        imageView;
    });
    [self addSubview:self.wallpaper2];
    
    self.shineLabel = ({
        RQShineLabel *label = [[RQShineLabel alloc] initWithFrame:CGRectMake(16, 200, UIScreenBounds.size.width - 32, CGRectGetHeight(UIScreenBounds) - 100)];
        label.numberOfLines = 0;
        label.text = [self.textArray objectAtIndex:self.textIndex];
        label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24.0];
        label.backgroundColor = [UIColor clearColor];
        [label sizeToFit];
        label;
    });
    [self addSubview:self.shineLabel];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (self.shineLabel.isVisible) {
        [self.shineLabel fadeOutWithCompletion:^{
            [self changeText];
            [UIView animateWithDuration:2.5 animations:^{
                if (self.wallpaper1.alpha > 0.1) {
                    self.wallpaper1.alpha = 0;
                    self.wallpaper2.alpha = 1;
                }
                else {
                    self.wallpaper1.alpha = 1;
                    self.wallpaper2.alpha = 0;
                }
            }];
            [self.shineLabel shine];
        }];
    }
    else {
        [self.shineLabel shine];
    }
}

- (void)changeText
{
    self.shineLabel.text = self.textArray[(++self.textIndex) % self.textArray.count];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
