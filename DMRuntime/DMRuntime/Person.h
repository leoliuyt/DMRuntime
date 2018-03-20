//
//  Person.h
//  DMRuntime
//
//  Created by lbq on 2018/3/20.
//  Copyright © 2018年 lbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *age;
@property (nonatomic, assign) NSInteger sex;


- (void)testInstance1;
- (void)testInstance2;

+ (void)testClass1;
+ (void)testClass2;
@end
