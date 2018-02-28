//
//  SineduRouterAppDelegate.h
//  gate8
//
//  Created by 傅雁锋 on 2017/5/18.
//  Copyright © 2017年 厦门象形远教网络科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YohooRouterAppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;

/**
 初始化模块数据:从plist文件中读取RouterModules字段数组进行初始化
 */
- (void)registerModules NS_REQUIRES_SUPER;

/**
 初始化应用数据，供子类复写，基类调用本方法时已经初始化self.window，子类无需再次初始化
 例如：初始化微信支付，初始化im等
 */
- (void)initApplication;

/**
 添加模块到router manager中
 
 @param moduleName 模块名称，映射
 */
- (void)addModule:(NSString *)moduleName;

@end
