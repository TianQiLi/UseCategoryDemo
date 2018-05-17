//
//  CommonBasiceViewController.h
//  UseCategoryDemo
//
//  Created by litianqi on 2017/4/25.
//  Copyright © 2017年 updown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+DZNEmptyDataSet.h"

@interface Null_CommonTableCell : UITableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier noDataText:(NSString *)noDataText noDataImgName:(NSString * )noDataImgName  errorText:(NSString *)errorText errorImgName:(NSString * )errorImgName;

//- (void)setDataText:(NSString *)text img:(NSString *)imgName;
- (void)setStatus:(NSInteger )status;
+ (NSString *)cellIdentifiter;
+ (CGFloat)cellHeight;
@end

typedef void(^SuccessBlock)(NSArray * array);
typedef void(^FailureBlock)(NSError * error);
@interface CommonBasiceViewController : UIViewController
@property (readonly) NSString * CBVCCellIdentifiter;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayData;
@property (nonatomic, copy)  SuccessBlock  successBlock;
@property (nonatomic, copy)  FailureBlock  failureBlock;
@property (assign, nonatomic) NSInteger page;
@property (assign, nonatomic) NSInteger rows;//默认30
@property (assign, nonatomic) NSInteger pageFirst;//默认0

@property (assign, nonatomic) BOOL enableHeaderRefresh;//默认yes
@property (assign, nonatomic) BOOL enableFooterRefresh;
@property (assign, nonatomic) UITableViewStyle tableViewStyle;//默认UITableViewStylePlain
@property (nonatomic, assign) BOOL directionScroll_UP;
/*automaticallyAdjustsScrollViewInsets = NO*/
- (id)initWithTableStyle:(UITableViewStyle)tableViewStyle;
/**/
- (id)initWithTableStyle:(UITableViewStyle)tableViewStyle autoAdjustScrollViewInsets:(BOOL)isAdjust;
- (void)basicRequestData;
- (void)loadTopData;
- (void)loadMoreData;


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
