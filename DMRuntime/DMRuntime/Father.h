//
//  Father.h
//  DMRuntime
//
//  Created by lbq on 2018/3/27.
//  Copyright © 2018年 lbq. All rights reserved.
//

#import "Person.h"

@interface Father : Person

@property (nonatomic, copy) NSArray *sons;
@property (nonatomic, strong) NSMutableArray *collections;

- (NSString *)getSex;

@end
