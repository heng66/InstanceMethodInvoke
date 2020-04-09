//
//   ViewController.m
//   InstanceMethodInvoke
//
//   Created  by chenqg on 2020/4/9
//   Copyright © 2020 chenqg. All rights reserved.
//


#import "ViewController.h"
#import <objc/message.h>

@interface ViewController ()
{
    Class cls;
    SEL selOne;
    SEL selTwo;
    SEL selThree;
    NSString *name;
    NSString *age;
    NSString *salary;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self publicInfo];
    // ==============
    [self method4];
}

- (void)publicInfo {
    cls = NSClassFromString(@"InstanceTest");
    selOne = @selector(staffInformationWithName:);
    selTwo = @selector(staffInformationWithName:age:);
    selThree = @selector(staffInformationWithName:age:salary:);
    
    name = @"chenqg";
    age = @"18";
    salary = @"12345";
    
}

- (void)method1 {
    
    id instanceObj = [[cls alloc] init];
    //    performSelector最多可以传两个参数
    [instanceObj performSelector:selOne withObject:name];
    [instanceObj performSelector:selTwo withObject:name withObject:age];
    //    ==============================
    //    三个参数及以上可使用 IMP通过函数指针去调用
    IMP imp = [instanceObj methodForSelector:selThree];
    void (*func)(id, SEL, NSString *, NSString *, NSString *) = (void *)imp;
    func(instanceObj, selThree, name, age, salary);
    
}

- (void)method2 {
    
    //    objc_msgSend
    
    id instanceObj = [[cls alloc] init];
    void (*objc_megSendType)(id, SEL, NSString *, NSString *, NSString *) = (void *)objc_msgSend;
    objc_megSendType(instanceObj, selThree, name, age, salary);
}

- (void)method3 {
    
    id instanceObj = [[cls alloc] init];
    
    NSMethodSignature *sig = [[instanceObj class] instanceMethodSignatureForSelector:selThree];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
    [invocation setTarget:instanceObj];
    [invocation setSelector:selThree];
    [invocation setArgument:&name atIndex:2];
    [invocation setArgument:&age atIndex:3];
    [invocation setArgument:&salary atIndex:4];
    [invocation invoke];
    
}

- (void)method4 {
    
    void (*objc_megSendType)(id, SEL, NSString *, NSString *, NSString *) = (void *)objc_msgSend;
    objc_megSendType(self, selThree, name, age, salary);
}

//方法4中消息转发 在forwardingTargetForSelector拦截
- (id)forwardingTargetForSelector:(SEL)aSelector {

    id instanceObj = [[cls alloc] init];
    NSString *selStr = NSStringFromSelector(aSelector);
    if ([selStr isEqualToString:@"staffInformationWithName:age:salary:"]) {
        return instanceObj;
    } else {
        return [super forwardingTargetForSelector:aSelector];
    }
}

//方法4中消息转发 在methodSignatureForSelector拦截
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    id instanceObj = [[cls alloc] init];
    NSMethodSignature *sig = nil;
    NSString *selStr = NSStringFromSelector(aSelector);
    if ([selStr isEqualToString:@"staffInformationWithName:age:salary:"]) {
        sig = [instanceObj methodSignatureForSelector:selThree];
    }else{
        sig = [super methodSignatureForSelector:aSelector];
    }
    return sig;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    id instanceObj = [[cls alloc] init];
    NSString *selStr = NSStringFromSelector(anInvocation.selector);
    if ([selStr isEqualToString:@"staffInformationWithName:age:salary:"]) {
        [anInvocation setTarget:instanceObj];
        [anInvocation setArgument:&name atIndex:2];
        [anInvocation setArgument:&age atIndex:3];
        [anInvocation setArgument:&salary atIndex:4];
        [anInvocation setSelector:selThree];
        [anInvocation invoke];
    }else{
        [super forwardInvocation:anInvocation];
    }
}


@end
