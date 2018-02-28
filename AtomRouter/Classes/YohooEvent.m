//
//  YohooEvent.m
//  gate8
//
//  Created by 傅雁锋 on 2017/5/21.
//  Copyright © 2017年 厦门象形远教网络科技股份有限公司. All rights reserved.
//

#import "YohooEvent.h"

@implementation YohooEvent

- (id)initWithName:(NSString *)eventName identifier:(NSString *)identifier target:(NSObject *)target selector:(SEL)selector removeWhenSend:(BOOL)removeWhenSend {
    self = [super init];
    if (self) {
        self.eventName = eventName;
        self.identifier = identifier;
        self.target = target;
        self.selector = selector;
        self.removeWhenSend = removeWhenSend;
    }
    
    return self;
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[YohooEvent class]]) {
        return false;
    }
    
    YohooEvent *event = object;
    return [event.eventName isEqualToString:_eventName] && [event.identifier isEqual:_identifier];
}

@end
