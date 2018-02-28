//
//  YohooDataEvent.h
//  Pods
//
//  Created by 傅雁锋 on 2017/6/5.
//
//

#import <Foundation/Foundation.h>
typedef id (^GetDataByEvent)(NSDictionary *param);

@interface YohooDataEvent : NSObject

- (instancetype)initWithEventName:(NSString *)eventName function:(GetDataByEvent)getDataByEvent;

@property (copy, nonatomic) NSString *eventName;
@property (copy, nonatomic) GetDataByEvent getDataByEvent;

@end
