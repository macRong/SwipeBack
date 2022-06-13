# SwipeBack
### 侧滑返回

☔由于历史遗留问题把，滑动返回给禁止了（黑屏和内存问题）。但是这是个很傻x的操作，今天必须要快速使用侧滑，才有了此SwipeBack功能。



### 如何使用？

在你需要侧滑的viewController中实现下面代码(也可以放基类中)

```objective-c
SwipBackManager *swipBackManager = [[SwipBackManager alloc]initWithController:self];
[swipBackManager invalid];
```



#### 后期继续优化

根据协议方式继续完善。



![swipeBack](/SwipeBack/swipeBack.gif)
