//
//  MyClass+Test1.m
//  DMRuntime
//
//  Created by leoliu on 2018/5/20.
//  Copyright © 2018年 lbq. All rights reserved.
//

#import "MyClass+Test1.h"

@implementation MyClass (Test1)

+ (NSString *)classProperty
{
    return @"myclass class property";
}

+(void)load
{
    NSLog(@"MyClass+Test1:%s",__func__);
}

//+(void)initialize
//{
//    NSLog(@"MyClass+Test1:%s",__func__);
//}

- (void)methodA
{
    NSLog(@"MyClass+Test1:%s",__func__);
}
@end
