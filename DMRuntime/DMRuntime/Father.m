//
//  Father.m
//  DMRuntime
//
//  Created by lbq on 2018/3/27.
//  Copyright © 2018年 lbq. All rights reserved.
//

#import "Father.h"

@implementation Father
- (NSString *)getSex
{
    return @"12";
}

+ (void)testClassFather
{
    
}

- (void)selectorname{
    NSLog(@"llll");
    SEL sel = @selector(selectorname);
    NSLog(@"Father = %p",sel);
}
@end
