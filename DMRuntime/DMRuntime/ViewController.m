//
//  ViewController.m
//  DMRuntime
//
//  Created by lbq on 2018/3/20.
//  Copyright © 2018年 lbq. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Father.h"
#import <objc/runtime.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, strong) Person *ps;

@property (nonatomic, strong) Father *father;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ps = [Person new];
    self.ps.name = @"Leoliu";
    self.ps.age = @(30);
    self.ps.sex = 1;
    
    self.father = [Father new];
    self.father.sons = @[@"son1",@"son2"];
    
    self.title = self.list[self.index];
    switch (self.index) {
        case 0:
            [self ivarListAction];
            break;
        case 1:
            [self propertyListAction];
            break;
        case 2:
            [self propertyAttributeListAction];
            break;
        case 3:
            [self methodListAction];
            break;
        case 4:
            [self classMethodListAction];
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//获取成员变量列表
- (void)ivarListAction {
    unsigned int count;
    Ivar *list = class_copyIvarList([self.ps class], &count);
    NSMutableString *str = [NSMutableString stringWithString:@""];
    for (unsigned int i = 0; i < count; i++) {
        Ivar ivar = list[i];
        const char * ivarName = ivar_getName(ivar);
        NSString *ivarStr = [NSString stringWithUTF8String:ivarName];
        [str appendFormat:@"%@\n",ivarStr];
    }
    self.textView.text = [str copy];
}

//获取属性列表
- (void)propertyListAction {
    unsigned int count;
    //只能获取到当前类的属性列表 获取不到父类的
    objc_property_t *propertyList = class_copyPropertyList([self.father class], &count);
    NSMutableString *str = [NSMutableString stringWithString:@""];
    for (unsigned int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *propertyName = property_getName(property);
        NSString *propertyStr = [NSString stringWithUTF8String:propertyName];
        [str appendFormat:@"%@\n",propertyStr];
    }
    self.textView.text = [str copy];
}

//获取属性的attribute
/**
 T@"NSArray",C,N,V_sons
 
 R The property is read-only (readonly).
 C The property is a copy of the value last assigned (copy).
 & The property is a reference to the value last assigned (retain).
 N The property is non-atomic (nonatomic).
 G<name> The property defines a custom getter selector name. The name follows the G (for example, GcustomGetter,).
 S<name> The property defines a custom setter selector name. The name follows the S (for example, ScustomSetter:,).
 D The property is dynamic (@dynamic).
 W The property is a weak reference (__weak).
 P The property is eligible for garbage collection.
 t<encoding> Specifies the type using old-style encoding.
 */
- (void)propertyAttributeListAction{
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList(self.father.class, &count);
    NSMutableString *str = [NSMutableString stringWithString:@""];
    for (unsigned int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
         const char *propertyAttributes = property_getAttributes(property);
        NSString *propertyAttributesStr = [NSString stringWithUTF8String:propertyAttributes];
        [str appendFormat:@"%@\n",propertyAttributesStr];
    }
    self.textView.text = [str copy];
}
//获取实例方法列表
- (void)methodListAction {
    unsigned int count;
    Method *mothodList = class_copyMethodList([self.ps class], &count);
    NSMutableString *str = [NSMutableString stringWithString:@""];
    for (unsigned int i = 0; i < count; i++) {
        Method method = mothodList[i];
        SEL sel = method_getName(method);
        [str appendFormat:@"%@\n",NSStringFromSelector(sel)];
    }
    self.textView.text = [str copy];
}


// 获取类方法列表
- (void)classMethodListAction {
    NSString *clsStr = NSStringFromClass(self.ps.class);
    Class metaClass = objc_getMetaClass(clsStr.UTF8String);
//    Class metaClass = object_getClass([self.ps class]);
    NSLog(@"%@",NSStringFromClass(metaClass));
    if (class_isMetaClass(metaClass)) {
        unsigned int count;
        Method *mothodList = class_copyMethodList(metaClass, &count);
        NSMutableString *str = [NSMutableString stringWithString:@""];
        for (unsigned int i = 0; i < count; i++) {
            Method method = mothodList[i];
            SEL sel = method_getName(method);
            [str appendFormat:@"%@\n",NSStringFromSelector(sel)];
        }
        self.textView.text = [str copy];
    }
}

@end
