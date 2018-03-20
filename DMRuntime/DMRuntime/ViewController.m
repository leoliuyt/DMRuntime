//
//  ViewController.m
//  DMRuntime
//
//  Created by lbq on 2018/3/20.
//  Copyright © 2018年 lbq. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, strong) Person *ps;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ps = [Person new];
    self.ps.name = @"Leoliu";
    self.ps.age = @(30);
    self.ps.sex = 1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//获取成员变量列表
- (IBAction)ivarListAction:(id)sender {
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
- (IBAction)propertyListAction:(id)sender {
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([self.ps class], &count);
    NSMutableString *str = [NSMutableString stringWithString:@""];
    for (unsigned int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *propertyName = property_getName(property);
        NSString *propertyStr = [NSString stringWithUTF8String:propertyName];
        [str appendFormat:@"%@\n",propertyStr];
    }
    self.textView.text = [str copy];
}

//获取实例方法列表
- (IBAction)methodListAction:(id)sender {
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
- (IBAction)classMethodListAction:(id)sender {
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
