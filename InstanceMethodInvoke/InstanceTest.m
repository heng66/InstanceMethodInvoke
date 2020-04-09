//
//   InstanceTest.m
//   InstanceMethodInvoke
//
//   Created  by chenqg on 2020/4/9
//   Copyright © 2020 chenqg. All rights reserved.
//
   

#import "InstanceTest.h"

@implementation InstanceTest

- (void)staffInformationWithName:(NSString *)name {
    NSLog(@"%s -- > %@",__func__,name);
}

- (void)staffInformationWithName:(NSString *)name age:(NSString *)age {
    NSLog(@"%s -- > %@ -- > %@",__func__,name,age);

}

- (void)staffInformationWithName:(NSString *)name age:(NSString *)age salary:(NSString *)salary {
    NSLog(@"%s -- > %@ -- > %@ -- > %@",__func__,name,age,salary);
}


@end
