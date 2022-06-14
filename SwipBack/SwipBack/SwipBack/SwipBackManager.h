//
//  SwipBackManager.h
//  SwipBackManager
//
//  Created by macRong on 2022/6/13.
//

#import <UIKit/UIKit.h>
#import "SwipeBackProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SwipBackManager : NSObject

///是否生效  默认NO:生效
@property (nonatomic, assign) BOOL invalid;

+ (instancetype)new __attribute__((unavailable("new invalid")));
- (instancetype)init __attribute__((unavailable("init invalid")));

/// 初始化
/// @param responder UIViewcontroller or UIView
- (instancetype)initResponder:(UIResponder *)responder;

///伪调用
- (void)fakeCompile;

@end

NS_ASSUME_NONNULL_END

/**
如何使用？
 
 1、实现协议SwipeBackProtocol
 2、self.backManager = [[SwipBackManager alloc]initResponder:self];         [self.backManager fakeCompile];
 3、实现代理swipBackAction，在此方法中实现返回的逻辑（等同点击按钮事件）
 4、如果一个页面在A情况可支持手势，在B情况不支持手势，可以用self.backManager.invalid = YES; Or NO 关闭或开启侧滑

 */
