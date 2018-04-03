//
//  ViewController+DMAssociation.h
//  DMRuntime
//
//  Created by lbq on 2018/4/2.
//  Copyright © 2018年 lbq. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController (DMAssociation)

@property (assign, nonatomic) NSString *associatedObject_assign;
@property (strong, nonatomic) NSString *associatedObject_retain;
@property (copy,   nonatomic) NSString *associatedObject_copy;

@property (nonatomic, assign) Person *associatedPerson_assign;
@property (nonatomic, strong) Person *associatedPerson_retain;
@property (nonatomic, copy) Person *associatedPerson_copy;

@end
