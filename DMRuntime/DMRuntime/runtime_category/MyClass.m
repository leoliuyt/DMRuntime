//
//  MyClass.m
//  DMRuntime
//
//  Created by leoliu on 2018/5/20.
//  Copyright © 2018年 lbq. All rights reserved.
//

#import "MyClass.h"

@implementation MyClass

+(void)load
{
    NSLog(@"MyClass:%s",__func__);
}
//+(void)initialize
//{
//    NSLog(@"MyClass:%s",__func__);
//}
- (void)privateMethod{
    NSLog(@"%s",__func__);
}

- (void)methodA
{
    NSLog(@"MyClass:%s",__func__);
}
@end
