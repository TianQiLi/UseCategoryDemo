//
//  SubViewController.m
//  UseCategoryDemo
//
//  Created by litianqi on 2018/5/15.
//  Copyright © 2018年 tqUDown. All rights reserved.
//

#import "SubViewController.h"

@interface SubViewController ()

@end

@implementation SubViewController

- (void)basicRequestData{
    //网络接口success 或者failure 回调处理的
    if(_type == 0){
        //成功-无数据
        sleep(2);
        self.successBlock(@[]);
    }else if(_type == 1){
        sleep(2);
        self.successBlock(@[@"1",@"2"]);
    }else if(_type == 2){
        sleep(2);
        self.failureBlock(nil);
    }else{
        sleep(2);
        self.successBlock(@[@"1",@"2",@"3",@"4",@"1",@"2",@"3",@"4",@"1",@"2",@"3",@"4"]);
    }
   
    /* 实际运用
      NSInteger from = self.page * self.rows;
     [ListRequestManager getListWithGood_id:goodsId from:from rows:self.rows success:^(ProductCategoryModel *model) {
     
         self.successBlock([NSArray arrayWithRLMArray:model.categoryIds]);

     } failure:^(NSError *error) {
         self.failureBlock(error);

     }];
     */
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataStatusNoData_text= @"成功无内容文本或者图片";
    self.dataStatusError_text = @"失败文本或者图片";
    self.dataStatusUnknown_text = @"加载中文本或者图片";
    [self.tableView.mj_header beginRefreshing];
    self.tableView.backgroundColor = [UIColor redColor];
    self.view.backgroundColor = [UIColor redColor];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //侧滑动画
    if(self.type == 3){
        if (self.directionScroll_UP) {
            [cell startSlideAnimaitonWithDirection:YES callback:nil];
        }
         //项目中更多采用下面的方式
//        NSInteger count = tableView.visibleCells.count;
//        if (self.directionScroll_UP && (count < indexPath.row)) {
//            [cell startSlideAnimaitonWithDirection:YES callback:nil];
//        }
    }else if(self.type == 4){
        //磁铁动画
        if (self.directionScroll_UP) {
            [cell startAnimationCutom_magnet_DirectionUp:YES block:nil];
        }
        
        //项目中更多采用下面的方式
//        NSInteger count = tableView.visibleCells.count;
//        if (self.directionScroll_UP && (count < indexPath.row)) {
//            [cell startAnimationCutom_magnet_DirectionUp:YES block:nil];
//        }
    }else if(self.type == 5){
        //透明度动画
        if (self.directionScroll_UP) {
            [cell startAnimationCutom_Alpha:nil];
        }
    }else if(self.type == 6){
        //透明度动画
        if (self.directionScroll_UP) {
            [cell startAnimationCutom_shake:nil];
        }
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if(self.type == 7){
        [cell startAnimationCutom_ScaleDefaultDurationWithCallBack:nil];
    }
    else if(self.type == 8){
        [cell startAnimationCutom_twinkleTypeWithCallBack:nil];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
