//
//  SectionViewController.m
//  SwipBack
//
//  Created by macRong on 2022/6/13.
//

#import "SectionViewController.h"
#import "CustomView.h"

@interface SectionViewController ()

@property (nonatomic, strong) SwipBackManager *swipBackManager;
@property (nonatomic, strong) CustomView *cutomView;

@end

@implementation SectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(150, 200, 160, 30);
    [btn addTarget:self action:@selector(viewAction) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"弹窗view" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    self.swipBackManager = [[SwipBackManager alloc]initResponder:self];
    [_swipBackManager fakeCompile];
}

- (void)swipBackAction
{
    [self goBack];
}

- (void)goBack
{
    NSLog(@"====自定义事件");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewAction
{
//    [[UIApplication sharedApplication].delegate.window  addSubview:self.cutomView];
    [self.view.window  addSubview:self.cutomView];

}

- (UIView *)cutomView
{
    if (!_cutomView) {
        _cutomView = [[CustomView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _cutomView.backgroundColor = [UIColor  colorWithWhite:0 alpha:0.7];
    }
    
    return _cutomView;
}

@end
