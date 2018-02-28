//
//  YohooEvent.h
//  gate8
//
//  Created by 傅雁锋 on 2017/5/21.
//  Copyright © 2017年 厦门象形远教网络科技股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 事件属性
 */
@interface YohooEvent : NSObject

- (id)initWithName:(NSString *)eventName identifier:(NSString *)identifier target:(NSObject *)target selector:(SEL)selector removeWhenSend:(BOOL)removeWhenSend;

@property (copy, nonatomic) NSString *eventName;        // 事件名称
@property (copy, nonatomic) NSString *identifier;       // 事件标识，用于移除事件使用，因为可能多个地方注册同一个事件通知，需要唯一标识来判断移除哪一个，请使用需要获取事件的类名来定义
@property (strong, nonatomic) NSObject *target;         // 事件主体，用户SEL获取
@property (assign, nonatomic) SEL selector;             // 事件发生时的处理方法
@property (nonatomic) BOOL removeWhenSend;              // 事件发送后是否移除

@end
