//
//  ThirdAccountUserInformation.m
//  soho
//
//  Created by liujian on 15/4/17.
//  Copyright (c) 2015年 Chinamobo. All rights reserved.
//

#import "ThirdAccountUserInformation.h"

@implementation ThirdAccountUserInformation
+ (id)sharedInformation
{
    static ThirdAccountUserInformation *information;
    
   static dispatch_once_t once;

    dispatch_once(&once, ^{
            information = [[ThirdAccountUserInformation alloc] init];
        });
    
    return information;
}
@end
