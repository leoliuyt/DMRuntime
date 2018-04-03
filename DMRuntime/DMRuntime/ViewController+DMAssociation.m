//
//  ViewController+DMAssociation.m
//  DMRuntime
//
//  Created by lbq on 2018/4/2.
//  Copyright © 2018年 lbq. All rights reserved.
//

#import "ViewController+DMAssociation.h"
#import <objc/runtime.h>

@implementation ViewController (DMAssociation)


- (void)setAssociatedObject_assign:(NSString *)associatedObject_assign
{
    objc_setAssociatedObject(self, @selector(associatedObject_assign), associatedObject_assign, OBJC_ASSOCIATION_ASSIGN);
}

- (NSString *)associatedObject_assign
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAssociatedObject_retain:(NSString *)associatedObject_retain
{
    objc_setAssociatedObject(self, @selector(associatedObject_retain), associatedObject_retain, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)associatedObject_retain
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAssociatedObject_copy:(NSString *)associatedObject_copy
{
    objc_setAssociatedObject(self, @selector(associatedObject_copy), associatedObject_copy, OBJC_ASSOCIATION_COPY);
}

- (NSString *)associatedObject_copy
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAssociatedPerson_assign:(Person *)associatedPerson_assign
{
    objc_setAssociatedObject(self, @selector(associatedPerson_assign), associatedPerson_assign, OBJC_ASSOCIATION_ASSIGN);
}

- (void)setAssociatedPerson_retain:(Person *)associatedPerson_retain
{
    objc_setAssociatedObject(self, @selector(associatedPerson_retain), associatedPerson_retain, OBJC_ASSOCIATION_RETAIN);
}

- (void)setAssociatedPerson_copy:(Person *)associatedPerson_copy
{
    objc_setAssociatedObject(self, @selector(associatedPerson_copy), associatedPerson_copy, OBJC_ASSOCIATION_COPY);
}

- (Person *)associatedPerson_assign
{
    return objc_getAssociatedObject(self, _cmd);
}

- (Person *)associatedPerson_retain
{
    return objc_getAssociatedObject(self, _cmd);
}

- (Person *)associatedPerson_copy
{
    return objc_getAssociatedObject(self, _cmd);
}
@end
