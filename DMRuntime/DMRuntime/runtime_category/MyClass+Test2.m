//
//  MyClass+Test2.m
//  DMRuntime
//
//  Created by leoliu on 2018/5/20.
//  Copyright © 2018年 lbq. All rights reserved.
//

#import "MyClass+Test2.h"

@implementation MyClass (Test2)
+(void)load
{
    NSLog(@"MyClass+Test2:%s",__func__);
}
//+(void)initialize
//{
//    NSLog(@"MyClass+Test2:%s",__func__);
//}
- (void)methodA
{
    NSLog(@"MyClass+Test2:%s",__func__);
}
@end
