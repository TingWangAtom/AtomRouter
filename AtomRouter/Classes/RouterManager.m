//
//  RouterManager.m
//  SineduRouter
//
//  Created by 傅雁锋 on 2017/5/11.
//  Copyright © 2017年 厦门象形远教网络科技股份有限公司. All rights reserved.
//

#import "RouterManager.h"
//#import "CTMediator.h"
static RouterManager *instance;

NSString* const kOpenModuleActionName = @"ModuleMainController";
NSString* const kOpenUrlModuleName = @"OpenUrlModule";

@interface RouterManager() {
//    NSMutableArray *modules;
    NSMutableDictionary *modules;
    NSMutableDictionary *events;
    NSMutableDictionary *dataEvents;
}

@end

@implementation RouterManager

+ (RouterManager *)getInstance {
    if (instance == nil) {
        instance = [[RouterManager alloc] init];
    }
    
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        modules = [[NSMutableDictionary alloc] init];
        events = [[NSMutableDictionary alloc] init];
        dataEvents = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)registerModule:(RouterModule *)module {
    if ([self isEmpty:module.moduleName]) {
        @throw @"模块名称不允许为空";
    }
    
    RouterModule *registeredModule = [modules valueForKey:module.moduleName];
    if (registeredModule != nil) {
        @throw @"该模块名已注册";
    }
    
    [modules setValue:module forKey:module.moduleName];
}

- (UIViewController *)openModule:(NSString *)moduleName params:(NSDictionary *)params {
    RouterModule *registeredModule = [modules valueForKey:moduleName];
    if (registeredModule == nil) {
        return nil;
    }
    
    return [registeredModule Action_ModuleMainController:params];
//    return [[CTMediator sharedInstance] performTarget:moduleName action:kOpenModuleActionName params:params shouldCacheTarget:true];
}

- (UIViewController *)openUrl:(NSString *)url params:(NSDictionary *)params {
    return [self openModule:kOpenUrlModuleName params:params];
}

- (BOOL)removeModule:(NSString *)moduleName {
    [modules removeObjectForKey:moduleName];
    return true;
}

- (void)addEvent:(YohooEvent *)event {
    if ([self isEmpty:event.eventName] || [self isEmpty:event.identifier]) {
        @throw @"事件名称或标识为空";
    }
    
    NSMutableArray *_events = [events valueForKey:event.eventName];
    if (_events == nil) {
        _events = [NSMutableArray array];
        [events setValue:_events forKey:event.eventName];
    }
    
    if ([_events containsObject:event]) {
//        @throw @"Already add this event";
        @throw @"事件已经存在";
    }
    
    if (event.target == nil || event.selector == nil) {
        @throw @"事件主体或响应事件的方法为空";
    }
    
    [_events addObject:event];
}

- (void)postEvent:(NSString *)eventName param:(id)params {
    NSMutableArray *_events = [events valueForKey:eventName];
    if (_events == nil) {
        return;
    }
    
    NSMutableArray *needRemoveEvents = [[NSMutableArray alloc] init];
    for (YohooEvent *event in _events) {
        NSObject *target = event.target;
        if ([target respondsToSelector:event.selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [target performSelector:event.selector withObject:params];
#pragma clang diagnostic pop
        } else {
            //TODO support swift
        }
        
        if (event.removeWhenSend) {
            [needRemoveEvents addObject:event];
        }
    }
    
    if (needRemoveEvents.count > 0) {
        [_events removeObjectsInArray:needRemoveEvents];
    }
    
    if (_events.count == 0) {
        [events removeObjectForKey:eventName];
    }
}

- (void)removeEvent:(NSString *)eventName identifier:(NSString *)identifier {
    NSMutableArray *_events = [events valueForKey:eventName];
    if (_events == nil || _events.count == 0) {
//        @throw @"事件不存在";
        return;
    }
    
    YohooEvent *event = [[YohooEvent alloc] initWithName:eventName identifier:identifier target:nil selector:nil removeWhenSend:false];
    [_events removeObject:event];
    
    if (_events.count == 0) {
        [events removeObjectForKey:eventName];
    }
}

#pragma mark - Data Event
- (void)registerDataEvent:(YohooDataEvent *)event {
    if ([self isEmpty:event.eventName]) {
        @throw @"事件名不允许为空";
    }
    
    if (event.getDataByEvent == nil) {
        @throw @"事件获取方法必须存在";
    }
    
    YohooDataEvent *oldEvent = dataEvents[event.eventName];
    if (oldEvent != nil) {
        NSLog(@"该事件已注册，请勿重复注册");
        return;
    }
    
    [dataEvents setValue:event forKey:event.eventName];
}

- (id)getDataByEventName:(NSString *)eventName withParam:(NSDictionary *)param {
    if ([self isEmpty:eventName]) {
        @throw @"事件名不允许为空";
    }
    
    YohooDataEvent *event = dataEvents[eventName];
    if (event == nil) {
        NSLog(@"未找到该事件，请检查代码或连续相关开发人员");
        return nil;
    }
    
    if (event.getDataByEvent == nil) {
        NSLog(@"该事件未实现获取数据事件方法，请检查相关代码或联系相关工作人员");
        return nil;
    }
    
    return event.getDataByEvent(param);
}

- (void)removeDataEvent:(NSString *)eventName {
    [dataEvents removeObjectForKey:eventName];
}

#pragma mark - Utils
- (BOOL)isEmpty:(NSString *)string {
    return string == nil || [string isEqualToString:@""];
}
@end
