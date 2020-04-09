//
//   InstanceTest.h
//   InstanceMethodInvoke
//
//   Created  by chenqg on 2020/4/9
//   Copyright © 2020 chenqg. All rights reserved.
//
   

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InstanceTest : NSObject

- (void)staffInformationWithName:(NSString *)name;

- (void)staffInformationWithName:(NSString *)name age:(NSString *)age;

- (void)staffInformationWithName:(NSString *)name age:(NSString *)age salary:(NSString *)salary;

@end

NS_ASSUME_NONNULL_END
