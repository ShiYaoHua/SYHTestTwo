//
//  UIImage+Resize.h
//
//  Created by syh on 15/4/28.
//  Copyright (c) 2015年  All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
@end
