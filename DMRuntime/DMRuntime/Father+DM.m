//
//  Father+DM.m
//  DMRuntime
//
//  Created by lbq on 2018/4/2.
//  Copyright © 2018年 lbq. All rights reserved.
//

#import "Father+DM.h"
#import <objc/runtime.h>

@implementation Father (DM)

- (void)setDes:(NSString *)des
{
    objc_setAssociatedObject(self, @selector(des), des, OBJC_ASSOCIATION_COPY);
}

- (NSString *)des
{
    return objc_getAssociatedObject(self, _cmd);
}

@end
