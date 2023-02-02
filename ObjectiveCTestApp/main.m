//
//  main.m
//  ObjectiveCTestApp
//
//  Created by Егор Худяев on 26.01.2023.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface New: NSObject



@end

@implementation New



@end

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
