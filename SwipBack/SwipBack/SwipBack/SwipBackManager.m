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

@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *leftEdgeGesture;
@property (nonatomic, strong) UIView *view;
@property (nonatomic, weak, readonly) UIResponder *responder;
@property (nonatomic, strong) UIImageView *backShowImageView;

@end

@implementation SwipBackManager

- (instancetype)initResponder:(UIResponder *)responder;
{
    self = [super init];
    if (self) {
        _responder = responder;
        
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
     self.leftEdgeGesture =
     [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self
                                                       action:@selector(handleLeftEdgeGesture:)];
     _leftEdgeGesture.edges = UIRectEdgeLeft;
     [self.view addGestureRecognizer:_leftEdgeGesture];
     [self.view addSubview:self.backShowImageView];
//    [[UIApplication sharedApplication].delegate.window addSubview:self.backShowImageView];
}

- (void)handleLeftEdgeGesture:(UIScreenEdgePanGestureRecognizer *)gesture
{
    BOOL isvalidGoBack = [self isvalidGoback];
    if (!isvalidGoBack) {
        return;
    }
    
//    UIView *view = [self.view hitTest:[gesture locationInView:gesture.view]
//                            withEvent:nil];

    CGPoint point = [gesture locationInView:gesture.view];
    if(UIGestureRecognizerStateBegan == gesture.state ||
       UIGestureRecognizerStateChanged == gesture.state)
    {
        if (_backShowImageView.frame.origin.x != 0) {
            BOOL isScreenheight = CGRectGetHeight(self.view.frame) < [UIScreen mainScreen].bounds.size.height;
            CGFloat fixViewScreenHeight = isScreenheight ? -_backShowImageViewHeight/2 : _backShowImageViewHeight/2;
            
            CGRect rect = _backShowImageView.frame;
            rect.origin.x = 0;
            rect.origin.y = point.y-fixViewScreenHeight;
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

- (BOOL)isvalidProtocol
{
    if (!self.invalid &&
        [self isValidPush] &&
        [_responder conformsToProtocol:@protocol(SwipeBackProtocol)] &&
        [_responder respondsToSelector:@selector(swipBackAction)]) {
        
        return YES;
    }

    return NO;
}

- (BOOL)isvalidForceProtocol
{
    if (!self.invalid &&
        [_responder conformsToProtocol:@protocol(SwipeBackProtocol)] &&
        [_responder respondsToSelector:@selector(swipForceBackAction)]) {
        return YES;
    }
    
    return NO;
}

- (void)fakeCompile
{
   ///这里是伪调用，（懒加载）也可以不用
}

- (void)backHome
{
    if ([self isvalidProtocol]) {
        SwipeBackProtocolCompile *protocolCompile = (SwipeBackProtocolCompile *)_responder;
        if(protocolCompile) [protocolCompile swipBackAction];
        return;
    }
    
    if ([self isvalidForceProtocol]) {
        SwipeBackProtocolCompile *protocolCompile = (SwipeBackProtocolCompile *)_responder;
        if(protocolCompile) [protocolCompile swipForceBackAction];
        return;
    }
}

- (void)resetBackViewStatus
{
    if (!_backShowImageView) {
        return;
    }
    
    _backShowImageView.frame = CGRectMake(-25, 100, 25, _backShowImageViewHeight);
    _backShowImageView.hidden = YES;
}

- (BOOL)isvalidGoback
{
    if ([self isvalidProtocol] || [self isvalidForceProtocol]) {
        return YES;
    }
    
    return NO;
}

- (BOOL)isValidPush
{
    if (_responder && [_responder isKindOfClass:[UIView class]]) {
            
        ///增加view的一些滑动判断条件
        ///Todo
        return YES;
    }
    
    if (_responder && [_responder isKindOfClass:[UIViewController class]]) {
        UIViewController *viewController = (UIViewController *)_responder;
        return [viewController.navigationController childViewControllers].count > 1;
    }
    
    return NO;
}

- (void)setInvalid:(BOOL)invalid
{
    _invalid = invalid;
    
    if (!_leftEdgeGesture || !self.view) {
        return;
    }
    
    if(invalid) { ///无效就删除
        [self.view removeGestureRecognizer:_leftEdgeGesture];
    }else {
        if (![[self.view gestureRecognizers] containsObject:_leftEdgeGesture]) {
            [self.view addGestureRecognizer:_leftEdgeGesture];
        }
    }
}

- (UIView *)view
{
    if (_responder && [_responder isKindOfClass:[UIViewController class]]) {
        UIViewController *viewController = (UIViewController *)_responder;
        _view = viewController.view;
        return _view;
    }
    
    if (_responder && [_responder isKindOfClass:[UIView class]]) {
        _view = (UIView *)_responder;
        return _view;
    }
    
    _view = nil;
    
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

