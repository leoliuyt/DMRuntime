//
//  MyClass+Test1.h
//  DMRuntime
//
//  Created by leoliu on 2018/5/20.
//  Copyright © 2018年 lbq. All rights reserved.
//

#import "MyClass.h"

@interface MyClass (Test1)

@property (nonatomic, strong, class,readonly) NSString *classProperty;

- (void)privateMethod;
- (void)methodA;
@end
