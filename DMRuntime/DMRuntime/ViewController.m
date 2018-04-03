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
#import "ViewController+DMAssociation.h"

__weak NSString *string_weak_assign = nil;
__weak NSString *string_weak_retain = nil;
__weak NSString *string_weak_copy   = nil;

__weak Person *p_weak_assign = nil;
__weak Person *p_weak_retain = nil;
__weak Person *p_weak_copy   = nil;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, strong) Person *ps;

@property (nonatomic, strong) Father *father;

@property (nonatomic, assign) Person *assinP;

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
    
    NSDictionary *dic = self.list[self.indexPath.section];
    NSString *title = dic[@"data"][self.indexPath.row];
    self.title = title;
    if (self.indexPath.section == 0) {
        switch (self.indexPath.row) {
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
            case 5:
                [self classMethodListParentAction];
                break;
            default:
                break;
        }
    }
    
    self.associatedObject_assign = [NSString stringWithFormat:@"leoliu1"];
    self.associatedObject_retain = [NSString stringWithFormat:@"leoliu2"];
    self.associatedObject_copy   = [NSString stringWithFormat:@"leoliu3"];
    
    Person *p = [Person new];
    self.associatedPerson_assign = p;
    self.associatedPerson_retain = [Person new];
    self.associatedPerson_copy   = [Person new];
    
    self.assinP = [Person new];
    
    string_weak_assign = self.associatedObject_assign;
    string_weak_retain = self.associatedObject_retain;
    string_weak_copy   = self.associatedObject_copy;
    
    p_weak_assign = self.associatedPerson_assign;
    p_weak_retain = self.associatedPerson_retain;
    p_weak_copy   = self.associatedPerson_copy;
    
    [self selectorname];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"self.associatedObject_assign: %@", self.associatedObject_assign); //
    NSLog(@"self.associatedObject_retain: %@", self.associatedObject_retain);
    NSLog(@"self.associatedObject_copy:   %@", self.associatedObject_copy);
    
    NSLog(@"self.associatedPerson_assign: %@", self.associatedPerson_assign); // Will Crash
    NSLog(@"self.associatedPerson_retain: %@", self.associatedPerson_retain);
    NSLog(@"self.associatedPerson_copy:   %@", self.associatedPerson_copy);
    /**
     self.associatedObject_assign: leoliu1
     self.associatedObject_retain: leoliu1
     self.associatedObject_copy:   leoliu1
     self.associatedPerson_assign: TitleView(0x7fc571c367e0) //野指针
     self.associatedPerson_retain: <Person: 0x60000044e310>
     self.associatedPerson_copy:   <Person: 0x60000044e340>
     */
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//获取成员变量列表（分类中是无法添加成员变量的）
- (void)ivarListAction {
    unsigned int count;
    Ivar *list = class_copyIvarList([self.father class], &count);
    NSMutableString *str = [NSMutableString stringWithString:@""];
    for (unsigned int i = 0; i < count; i++) {
        Ivar ivar = list[i];
        const char * ivarName = ivar_getName(ivar);
        NSString *ivarStr = [NSString stringWithUTF8String:ivarName];
        [str appendFormat:@"%@\n",ivarStr];
    }
    self.textView.text = [str copy];
}

//获取属性列表 (如果有分类并且分类里有属性，则可以获取到分类的属性，但获取不到分类的实例变量)
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
    NSString *clsStr = NSStringFromClass(self.father.class);
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

// 获取类的所有类方法（包括父类）
- (void)classMethodListParentAction {
    Class tmpClass = self.father.class;
    NSMutableString *str = [NSMutableString stringWithString:@""];
//    while (tmpClass) {//包括NSObject类
    while (class_getSuperclass(tmpClass)) {
        NSString *clsStr = NSStringFromClass(tmpClass);
        Class metaClass = objc_getMetaClass(clsStr.UTF8String);
        //    Class metaClass = object_getClass([self.ps class]);
        NSLog(@"%@",NSStringFromClass(metaClass));
        if (class_isMetaClass(metaClass)) {
            unsigned int count;
            Method *mothodList = class_copyMethodList(metaClass, &count);
            for (unsigned int i = 0; i < count; i++) {
                Method method = mothodList[i];
                SEL sel = method_getName(method);
                [str appendFormat:@"%@\n",NSStringFromSelector(sel)];
            }
        }
        tmpClass = class_getSuperclass(tmpClass);
    }
    self.textView.text = [str copy];
}

- (void)selectorname{
    NSLog(@"aaa");
    SEL sel = @selector(selectorname);
    NSString *name = NSStringFromSelector(sel);
    NSLog(@"viewCOntroller = %p == %p ===%@",sel,&name,name);
    [self.father selectorname];
}

@end
