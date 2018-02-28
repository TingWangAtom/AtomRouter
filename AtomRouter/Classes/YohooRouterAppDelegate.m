//
//  SineduRouterAppDelegate.m
//  gate8
//
//  Created by 傅雁锋 on 2017/5/18.
//  Copyright © 2017年 厦门象形远教网络科技股份有限公司. All rights reserved.
//

#import "YohooRouterAppDelegate.h"
#import "RouterManager.h"

@implementation YohooRouterAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self registerModules];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    [self initApplication];
    return YES;
}

- (void)registerModules {
//    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
//    NSArray *modules = info[@"RouterModules"];
//    for (NSString *moduleName in modules) {
//        NSLog(@"module = %@", moduleName);
////        Class moduleClass = NSClassFromString(moduleName);
////        id module = [[moduleClass alloc] init];
////        [[RouterManager getInstance] registerModule:module];
//        [self addModule:moduleName];
//    }
}

/**
 添加模块
 
 @param moduleName 模块名称，映射
 */
- (void)addModule:(NSString *)moduleName {
    Class moduleClass = NSClassFromString(moduleName);
    if (moduleClass == nil) {
        return;
    }
    id module = [[moduleClass alloc] init];
    [[RouterManager getInstance] registerModule:module];
}

- (void)initApplication {
    
}

@end
