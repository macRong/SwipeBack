//
//  ViewController.m
//  SwipBack
//
//  Created by macRong on 2022/6/13.
//

#import "ViewController.h"
#import "SectionViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 关闭 侧滑
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
          self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (IBAction)pushAction:(id)sender {
    SectionViewController *vc = [SectionViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
