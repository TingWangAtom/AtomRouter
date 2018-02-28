//
//  RouterModule.m
//  SineduRouter
//
//  Created by 傅雁锋 on 2017/5/11.
//  Copyright © 2017年 厦门象形远教网络科技股份有限公司. All rights reserved.
//

#import "RouterModule.h"

@implementation RouterModule

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initComponment];
    }
    
    return self;
}

- (void)initComponment {
    
}

- (UIViewController *)Action_ModuleMainController:(NSDictionary *)params {
    return nil;
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[RouterModule class]]) {
        return false;
    }
    
    RouterModule *module = object;
    return [module.moduleName isEqualToString:_moduleName];
}

@end
