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
    } else if (self.indexPath.section == 1) {
        
    } else if (self.indexPath.section == 2){
        [self classAssociatedOption];
    } else if (self.indexPath.section == 3){
        if(self.indexPath.row == 0){
            [self dynamicCreateClass];
        } else {
            [self dynamicInstance];
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

- (void)classAssociatedOption
{
    NSLog(@"类相关操作===========\n");
    NSMutableString *str = [NSMutableString stringWithString:@""];
    //获取类名
    const char *charName = class_getName(self.ps.class);
    NSString *name = [NSString stringWithCString:charName encoding:NSUTF8StringEncoding];
    [str appendFormat:@"获取类名:%@\n",name];
    NSLog(@"=================\n");
    //获取父类
    const char *superCharName = class_getName(class_getSuperclass(self.ps.class));
    NSString *superName = [NSString stringWithCString:superCharName encoding:NSUTF8StringEncoding];
    NSLog(@"获取父类类名:%@",superName);
    [str appendFormat:@"获取父类类名:%@\n",superName];
    NSLog(@"=================\n");
    
    //是否是元类
    BOOL isMeta = class_isMetaClass(self.ps.class);
    [str appendFormat:@"%@是否是元类:%@\n",name,isMeta?@"是":@"否"];
    NSLog(@"=================\n");
    
    //获取元类（objc_方法)
    Class metaClass = objc_getMetaClass(charName);
    const char *charMetaClassName = class_getName(metaClass);
    NSString *metaName = [NSString stringWithCString:charMetaClassName encoding:NSUTF8StringEncoding];
    [str appendFormat:@"%@的元类名:%@;是否是元类:%@\n",name,metaName,class_isMetaClass(metaClass)?@"是":@"否"];
    NSLog(@"=================\n");
    
    //变量实例大小
    [str appendFormat:@"%@的变量实例大小:%zu\n",name,class_getInstanceSize(self.ps.class)];
    NSLog(@"=================\n");
    
    //获取指定名称的实例
    Ivar ivar = class_getInstanceVariable(self.ps.class, "_name");
    if (ivar != NULL) {
        [str appendFormat:@"获取%@类中指定_name的实例:%s\n",name,ivar_getName(ivar)];
    }
    NSLog(@"=================\n");
    // 协议
    unsigned outCount;
    Protocol * __unsafe_unretained * protocols = class_copyProtocolList(self.ps.class, &outCount);
    Protocol * protocol;
    for (int i = 0; i < outCount; i++) {
        protocol = protocols[i];
         [str appendFormat:@"获取%@类中遵循的协议名%s\n",name,protocol_getName(protocol)];
    }
    BOOL isConforms = class_conformsToProtocol(self.ps.class, protocol);
    [str appendFormat:@"获取%@类是否遵循了%s协议:%@\n",name,protocol_getName(protocol),isConforms ? @"是":@"否"];
    NSLog(@"=================\n");
    self.textView.text = [str copy];
    self.textView.editable = YES;
}

- (void)dynamicCreateClass
{
    //创建一个继承自self.ps的类SubClass
    Class subClass = objc_allocateClassPair(self.ps.class, "SubClass", 0);
    void(^block)(void) = ^(){
        NSLog(@"block 调用");
    };
    
    IMP imp_subMethod = imp_implementationWithBlock(block);
    //向SubClass中添加方法
    class_addMethod(subClass, @selector(addMethod), imp_subMethod, "v@:");
    //添加实例变量
    class_addIvar(subClass, "_ivar1", sizeof(NSString *), log(sizeof(NSString *)), @encode(NSString *));
    
    //添加属性
    objc_property_attribute_t type = {"T", "@\"NSString\""};
    objc_property_attribute_t ownership = { "C", "" };
    objc_property_attribute_t backingivar = { "V", "_ivar1"};
    objc_property_attribute_t attrs[] = {type, ownership, backingivar};
    class_addProperty(subClass, "property2", attrs, 3);
    
    //注册
    objc_registerClassPair(subClass);
    
    //创建类的实例
    id instance = [[subClass alloc] init];
    [instance performSelector:@selector(addMethod)];
    [instance setValue:@"hello world" forKey:@"_ivar1"];
    
    NSLog(@"_ivar1======%@===",[instance valueForKey:@"_ivar1"]);
    
}

- (void)dynamicInstance
{
    id theObject = class_createInstance(NSString.class, sizeof(unsigned));
    
    id str1 = [theObject init];
    NSLog(@"%@", [str1 class]);
    id str2 = [[NSString alloc] initWithString:@"test"];
    NSLog(@"%@", [str2 class]);
}

@end
