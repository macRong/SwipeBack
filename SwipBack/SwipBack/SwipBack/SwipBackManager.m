//
//  SwipBackManager.m
//  SwipBackManager
//
//  Created by macRong on 2022/6/13.
//

#import "SwipBackManager.h"

@interface SwipBackManager()
{
    CGFloat _swipMaxX;
    CGFloat _backShowImageViewHeight;
}

@property (nonatomic, strong) UIView *view;
@property (nonatomic, weak, readonly) UIViewController *viewController;
@property (nonatomic, strong) UIImageView *backShowImageView;

@end

@implementation SwipBackManager

- (instancetype)initWithController:(UIViewController *)vc
{
    self = [super init];
    if (self) {
        _viewController = vc;
        
        [self initVars];
        [self initViews];
    }
    
    return self;
}

- (void)initVars
{
    _swipMaxX = 100;
    _backShowImageViewHeight = 300;
}

- (void)initViews
{
     UIScreenEdgePanGestureRecognizer *leftEdgeGesture =
     [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self
                                                       action:@selector(handleLeftEdgeGesture:)];
     leftEdgeGesture.edges = UIRectEdgeLeft;
     [self.view addGestureRecognizer:leftEdgeGesture];
     [self.view addSubview:self.backShowImageView];
//    [[UIApplication sharedApplication].delegate.window addSubview:self.backShowImageView];
}

- (void)handleLeftEdgeGesture:(UIScreenEdgePanGestureRecognizer *)gesture
{
    ///如果当前不是push过的不要处理
    if (![_viewController isKindOfClass:[UIViewController class]] &&
          [self.viewController.navigationController childViewControllers].count > 1) {
        return;
    }
    
//    UIView *view = [self.view hitTest:[gesture locationInView:gesture.view]
//                            withEvent:nil];

    CGPoint point = [gesture locationInView:gesture.view];
    if(UIGestureRecognizerStateBegan == gesture.state ||
       UIGestureRecognizerStateChanged == gesture.state)
    {
        if (_backShowImageView.frame.origin.x != 0) {
            CGRect rect = _backShowImageView.frame;
            rect.origin.x = 0;
            rect.origin.y = point.y-_backShowImageViewHeight/2;
            _backShowImageView.frame = rect;
            _backShowImageView.hidden = NO;
        }
        
        _backShowImageView.alpha = [self invalidSwipeGesture:gesture] ? 0.6 :0.3;
    }else {
        [self resetBackViewStatus];
        if ([self invalidSwipeGesture:gesture]) {
            [self backHome];
        }
    }
}

- (BOOL)invalidSwipeGesture:(UIScreenEdgePanGestureRecognizer *)gesture
{
    if ([gesture translationInView:gesture.view].x > _swipMaxX) {
        return YES;
    }else {
        if ([gesture velocityInView:gesture.view].x > 100) {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)invalid
{
   ///这里是伪调用
}

- (void)backHome
{
    if (![_viewController isKindOfClass:[UIViewController class]]) {
        return;
    }
    
    [self.viewController.navigationController popViewControllerAnimated:YES];
}

- (void)resetBackViewStatus
{
    if (!_backShowImageView) {
        return;
    }
    
    _backShowImageView.frame = CGRectMake(-25, 100, 25, _backShowImageViewHeight);
    _backShowImageView.hidden = YES;
}

- (UIView *)view
{
    if (![_viewController isKindOfClass:[UIViewController class]]) {
        return nil;
    }
    
    _view = self.viewController.view;
    
    return _view;
}

- (UIImageView *)backShowImageView
{
    if (!_backShowImageView) {
        _backShowImageView = [[UIImageView alloc] init];
        _backShowImageView.image = [UIImage imageNamed:@"swipe_back_icon"];
        _backShowImageView.layer.zPosition = 99999;
        [self resetBackViewStatus];
    }
    
    return _backShowImageView;
}

@end
