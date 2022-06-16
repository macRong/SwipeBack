# SwipeBack


☔由于历史遗留问题把，部分滑动返回给禁止了。但是这是个很傻x的操作，如何快速使用侧滑，经过参考与思考，便有了SwipeBack

## Feature

1. iOS侧滑返回（类似Android系统返回）
2. 自定义侧滑返回策略
3. 快速添加侧滑返回功能

## Usage

在你需要侧滑的Responder(viewController或view)中实现下面代码(也可以放基类中)

```
1. 实现协议SwipBackProtocol
2. self.backManager = [[SwipBackManager alloc]initResponder:self.view];   [self.backManager fakeCompile];
3. 实现代理swipBackAction，在此方法中实现返回的逻辑（等同点击按钮事件）
4. 如果一个页面在A情况可支持手势，在B情况不支持手势，可以用self.backManager.invalid = YES; Or NO 关闭或开启侧滑
```



注意，这里是关闭了系统的手势滑动功能

```objective-c
// 关闭 侧滑
if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
	self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
```

## Sam


![swipeBackDemo](/swipeBackDemo.gif)![swipeBack](/swipeBack.gif)
