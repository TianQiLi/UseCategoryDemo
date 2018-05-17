//
//  ViewController.m
//  UseCategoryDemo
//
//  Created by litianqi on 2018/5/14.
//  Copyright © 2018年 tqUDown. All rights reserved.
//

#import "ViewController.h"
#import "SubViewController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ViewController
- (IBAction)clickBtn:(UIButton *)sender {
    SubViewController * vc = [[SubViewController alloc] initWithTableStyle:UITableViewStyleGrouped autoAdjustScrollViewInsets:YES];
    vc.type = sender.tag;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIView * view = [UIView new];
    view.frame = CGRectMake(0, 0, 20, 20);
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.leading.equalTo(self.view);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
    }];
    NSLog(@"%@\n",self.view);
    NSLog(@"---%lf,%lf\n",self.view.bounds.size.width,self.view.bounds.size.height);
} 


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
