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
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
