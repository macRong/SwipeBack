//
//  SectionViewController.m
//  SwipBack
//
//  Created by macRong on 2022/6/13.
//

#import "SectionViewController.h"
#import "SwipBackManager.h"

@interface SectionViewController ()

@property (nonatomic, strong) SwipBackManager *swipBackManager;

@end

@implementation SectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.swipBackManager = [[SwipBackManager alloc]initWithController:self];
    [_swipBackManager invalid];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
