//
//  SwipBackManager.h
//  SwipBackManager
//
//  Created by macRong on 2022/6/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SwipBackManager : NSObject

+ (instancetype)new __attribute__((unavailable("new invalid")));
- (instancetype)init __attribute__((unavailable("init invalid")));

- (instancetype)initWithController:(UIViewController *)vc;
- (void)invalid;

@end

NS_ASSUME_NONNULL_END

/**
 注意：
 
下版根据<协议>来完善此功能
 */
