//
//   main.m
//   InstanceMethodInvoke
//
//   Created  by chenqg on 2020/4/9
//   Copyright © 2020 chenqg. All rights reserved.
//
   

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
