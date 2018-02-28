//
//  RouterModule.h
//  SineduRouter
//
//  Created by 傅雁锋 on 2017/5/11.
//  Copyright © 2017年 厦门象形远教网络科技股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//暂时没用，先定义
typedef NS_ENUM(NSInteger) {
    OpenModuleViewControllerTypePush = 0,   // push
    OpenModuleViewControllerTypePresent = 1     // present
} OpenModuleViewControllerType;

// 模块类型
typedef NS_ENUM(NSInteger) {
    ModuleTypeAction = 0,   //原生
    ModuleTypeUrl = 1       //html5
} ModuleType;

/**
 项目模块数据模型
 子类复写时请在注释中添加该模块需要的参数名称及类型以便其他人员能清晰的了解,
 参数名请使用const nsstring的方式在m文件中定义，
 在h文件中用extern const nsstring的方式,
 子类继承该model时必须以Target_为开头命名,
 需要执行的action必须以Action_开头
 */
@interface RouterModule : NSObject

@property (copy, nonatomic) NSString *moduleName;   // 模块名称，英文，驼峰命名法
@property (copy, nonatomic) NSString *moduleDescription;    // 模块描述，请尽量详细的描述
@property (nonatomic) OpenModuleViewControllerType openType;    // viewController的打开方式
@property (nonatomic) ModuleType moduleType;    // 模块类型：原生或url

- (void)initComponment;

/**
 模块主入口ViewController

 @param params 参数
 @return 主入口controller
 */
- (UIViewController *)Action_ModuleMainController:(NSDictionary *)params;

@end
