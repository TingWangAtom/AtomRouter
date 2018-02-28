//
//  RouterManager.h
//  SineduRouter
//
//  Created by 傅雁锋 on 2017/5/11.
//  Copyright © 2017年 厦门象形远教网络科技股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RouterModule.h"
#import "YohooEvent.h"
#import "YohooDataEvent.h"

extern NSString* const kOpenUrlModuleName;

@interface RouterManager : NSObject

/**
 获取管理单例

 @return 管理器
 */
+ (RouterManager *)getInstance;

/**
 注册模块
 
 @param module 模块数据
    模块名称不允许为空
    不允许注册相同模块名
 @throw 异常
 */
- (void)registerModule:(RouterModule *)module;

/**
 打开模块

 @param moduleName 模块名称
 @param params 模块需要的参数
 @return 模块主入口viewController
 */
- (UIViewController *)openModule:(NSString *)moduleName params:(id)params;

/**
 打开外部链接

 @param url url
 @param params 参数
 @return viewController
 */
- (UIViewController *)openUrl:(NSString *)url params:(NSDictionary *)params;

/**
 移除模块

 @param moduleName 模块名称
 @return 是否移除成功
 */
- (BOOL)removeModule:(NSString *)moduleName;

/**
 添加事件通知响应
 事件响应的事件名称及identifier不允许为空,并且target及selector必须不为空
 允许同一个事件注册多个响应，即事件名称可以一致，但不允许同一个事件的identifier一样
 @param event 事件
 */
- (void)addEvent:(YohooEvent *)event;

/**
 发送事件
 
 @param eventName 事件名称
 @param params 事件参数
 */
- (void)postEvent:(NSString *)eventName param:(NSDictionary *)params;

/**
 移除事件

 @param eventName 事件名称
 @param identifier 事件标识
 */
- (void)removeEvent:(NSString *)eventName identifier:(NSString *)identifier;

/**
 根据事件名称获取数据

 @param eventName 事件名称
 @param param 参数
 @return 数据
 */
- (id)getDataByEventName:(NSString *)eventName withParam:(NSDictionary *)param;

/**
 注册数据获取事件

 @param event 事件参数
 */
- (void)registerDataEvent:(YohooDataEvent *)event;

/**
 移除获取数据事件

 @param eventName 事件名
 */
- (void)removeDataEvent:(NSString *)eventName;

@end
