//
//  CustomView.m
//  SwipBack
//
//  Created by macRong on 2022/6/14.
//

#import "CustomView.h"

@interface CustomView()

@property (nonatomic, strong) SwipBackManager *swipBackManager;

@end

@implementation CustomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initViews];
        [self.swipBackManager fakeCompile];
    }
    
    return self;
}


- (void)initViews
{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(70, 100, 250, 300)];
    bgView.backgroundColor = [UIColor redColor];
    [self addSubview:bgView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 10, 40, 40);
    [btn addTarget:self action:@selector(viewAction) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"X" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [bgView addSubview:btn];
}

- (void)viewAction
{
    if (self) {
        [self removeFromSuperview];
    }
}

- (void)swipBackAction
{
    [self viewAction];
}

- (SwipBackManager *)swipBackManager
{
    if (!_swipBackManager) {
        _swipBackManager = [[SwipBackManager alloc]initResponder:self];
    }
    
    return _swipBackManager;
}

@end
