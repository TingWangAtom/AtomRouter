//
//  YohooDataEvent.m
//  Pods
//
//  Created by 傅雁锋 on 2017/6/5.
//
//

#import "YohooDataEvent.h"

@implementation YohooDataEvent

- (instancetype)initWithEventName:(NSString *)eventName function:(GetDataByEvent)getDataByEvent {
    self = [super init];
    if (self) {
        self.eventName = eventName;
        self.getDataByEvent = getDataByEvent;
    }
    
    return self;
}

@end
