//
//  SwipeBackProtocol.h
//  SwipBack
//
//  Created by macRong on 2022/6/14.
//

/**
返回事件协议，必须是实现协议才可以返回，因为有个别页面特殊处理逻辑
*/
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SwipeBackProtocol <NSObject>

@required
///虽然实现协议了，但必须满足侧滑条件才能生效（如一级viewctronller，返回就无效）和swipForceBackAction选其一即可，优先调用swipBackAction方法
- (void)swipBackAction;

@optional
///实现了协议，不管满足侧滑条件，都强制生效
- (void)swipForceBackAction;

@end

NS_ASSUME_NONNULL_END
