//
//  Person.m
//  DMRuntime
//
//  Created by lbq on 2018/3/20.
//  Copyright © 2018年 lbq. All rights reserved.
//

#import "Person.h"
#import <UIKit/UIKit.h>

@interface Person()
{
    CGFloat _height;
    NSString *_bigName;
}
@end

@implementation Person

- (instancetype)init
{
    self = [super init];
    _height = 170.;
    _bigName = @"Leo";
    return self;
}

- (void)testInstance1
{
    NSLog(@"%s",__func__);
}
- (void)testInstance2
{
    NSLog(@"%s",__func__);
}

+ (void)testClass1
{
    NSLog(@"%s",__func__);
}
+ (void)testClass2
{
   NSLog(@"%s",__func__);
}
@end
