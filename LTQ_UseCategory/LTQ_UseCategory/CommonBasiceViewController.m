//
//  CommonBasiceViewController.m
//  UseCategoryDemo
//
//  Created by litianqi on 2017/4/25.
//  Copyright © 2017年 updown. All rights reserved.
//
#import "LTQ_header.h"
#import "CommonBasiceViewController.h"
@interface Null_CommonTableCell()
@property (nonatomic, strong)UIImageView * imgV;
@property (nonatomic, strong)UILabel * textlabel;

@property (nonatomic, strong)NSString * noDataText;
@property (nonatomic, strong)NSString * noDataImg;

@property (nonatomic, strong)NSString * errorText;
@property (nonatomic, strong)NSString * errorImg;

@end

@implementation Null_CommonTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier noDataText:(NSString *)noDataText noDataImgName:(NSString * )noDataImgName  errorText:(NSString *)errorText errorImgName:(NSString * )errorImgName {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _noDataText = noDataText ? noDataText : @"无数据";
        _noDataImg = noDataImgName ? noDataImgName : @"unusual-empty";
        
        _errorText = errorText ? errorText : @"请点击屏幕重试";
        _errorImg = errorImgName ? errorImgName : @"unusual-badmood";
        
        _imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [_imgV setImage:[UIImage imageNamed:_noDataImg]];
        [self.contentView addSubview:_imgV];

       
        [_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(50);
        }];
        
        _textlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 16)];
        [_textlabel setTextColor:[UIColor colorWithHexString:@"0x999999"]];
        [_textlabel setFont:[UIFont systemFontOfSize:14]];
        [_textlabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_textlabel];
        _textlabel.text = _noDataText;
        [_textlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.greaterThanOrEqualTo(self).offset(16);
            make.trailing.greaterThanOrEqualTo(self).offset(16);
            make.centerX.equalTo(self);
            make.top.equalTo(self.imgV.mas_bottom).offset(20);
        }];
        
    }
    return self;
}

//- (void)setDataText:(NSString *)text img:(NSString *)imgName{
//    [_imgV setImage:[UIImage imageNamed:imgName]];
//    [_textlabel setText:text];
//}

- (void)setStatus:(NSInteger )status{
    switch (status) {
        case 0:{//空数据
            [_imgV setImage:[UIImage imageNamed:_noDataImg]];
            [_textlabel setText:_noDataText];
            break;
        }
        case 1:{//异常
            [_imgV setImage:[UIImage imageNamed:_errorImg]];
            [_textlabel setText:_errorText];
            break;
        }
        default:{
            [_imgV setImage:[UIImage imageNamed:@""]];
            [_textlabel setText:@""];
            break;
        }
    }
}



+ (NSString *)cellIdentifiter{
    return @"NullTableIdentifiter";
}

+ (CGFloat)cellHeight{
    return 250;
}

@end




static NSString * const CBVCCellIdentifiter = @"CBVCCellIdentifiter";
@interface CommonBasiceViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/** tablevie */
@property (assign, nonatomic) BOOL isHeaderRefreshing;
@property (assign, nonatomic) BOOL isAdjust;//默认NO
@end

@implementation CommonBasiceViewController
- (id)initWithTableStyle:(UITableViewStyle)tableViewStyle autoAdjustScrollViewInsets:(BOOL)isAdjust{
    if (self = [super init]) {
        _tableViewStyle = tableViewStyle;
        _isAdjust = isAdjust;
        _rows = 30;
        _page = 0;
        _pageFirst = 0;
        _arrayData = [[NSMutableArray alloc] init];
    }
    return self;
    
}
- (id)initWithTableStyle:(UITableViewStyle)tableViewStyle{
    return [self initWithTableStyle:tableViewStyle autoAdjustScrollViewInsets:NO];
}

- (id)init{
    return [self initWithTableStyle:UITableViewStylePlain autoAdjustScrollViewInsets:NO];
}

- (void)setPageFirst:(NSInteger)pageFirst{
    _pageFirst = pageFirst;
    _page = _pageFirst;
}

- (NSString *)CBVCCellIdentifiter{
    return CBVCCellIdentifiter;
}

- (void)setEnableHeaderRefresh:(BOOL)enableHeaderRefresh{
    _enableHeaderRefresh = enableHeaderRefresh;
    if (_enableHeaderRefresh) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTopData)];
    }else{
        self.tableView.mj_header = nil;
    }
}

- (void)setEnableFooterRefresh:(BOOL)enableFooterRefresh{
    //上拉加载更多
    _enableFooterRefresh = enableFooterRefresh;
    if (_enableFooterRefresh) {
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }else{
        self.tableView.mj_footer = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _directionScroll_UP = YES;
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:_tableViewStyle];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setAutoresizingMask:~UIViewAutoresizingNone];
    [self.view addSubview:_tableView];
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
    }];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0")) {
        if (_isAdjust){
            [self.tableView setValue:@(3) forKey:@"contentInsetAdjustmentBehavior"];
        }else
           [self.tableView setValue:@(2) forKey:@"contentInsetAdjustmentBehavior"];
    } else {
        self.automaticallyAdjustsScrollViewInsets = _isAdjust;
    }
    self.edgesForExtendedLayout = UIRectEdgeTop;
    self.enableHeaderRefresh = YES;
    self.enableFooterRefresh = NO;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CBVCCellIdentifiter];
    //    [self.tableView registerNib:[UINib nibWithNibName:@"CommonTextTableViewCell" bundle:nil] forCellReuseIdentifier:[CommonTextTableViewCell identifiter]];
    @weakify(self)
    _successBlock = ^(NSArray * array){
        @strongify(self)
        NSArray * tempArray = array ? array : @[];
        if (self.isHeaderRefreshing && self.arrayData.count > 0) {
            [self.arrayData removeAllObjects];
        }
        if (self.page == self.pageFirst) {
            [self.arrayData removeAllObjects];
        }
        if (tempArray.count > 0) {
            [self.arrayData addObjectsFromArray:tempArray];
        }
        [self setEndRefresh:tempArray];
        [self.tableView reloadData];
        
    };
    
    _failureBlock = ^(NSError * error){
        @strongify(self)
        self.page --;//reset
        [self setEndRefresh:nil];
        if (self.arrayData.count == 0) {
            self.dataStatusType = @(DataStatusError);
            [self.tableView reloadData];
        }
        else
        self.dataStatusType = @(DataStatusOk);
        
    };
    
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    
    
    [RACObserve(self.tableView,contentOffset)subscribeNext:^(NSValue *point) {
        @strongify(self)
        CGPoint  pointNew = point.CGPointValue;
        static float offsetY = 0;
        self.directionScroll_UP = NO;
        if (pointNew.y > offsetY) {
            self.directionScroll_UP = YES;
        }
        offsetY = pointNew.y;
    }];
    
    
    [RACObserve(self.tableView.mj_header,state) subscribeNext:^(NSNumber * status) {
        @strongify(self)
        if (!status) {
            return ;
        }
        switch ([status integerValue]) {
                case MJRefreshStateIdle:{
                    [self setApiStatus];
                    break;
                }
                case MJRefreshStatePulling:{//start
                    break;
                }
                case MJRefreshStateRefreshing:{//start
                    self.dataStatusType = @(DataStatusNoKnown);
                    break;
                }
                case MJRefreshStateWillRefresh:
                case MJRefreshStateNoMoreData:{//over
                    self.dataStatusType = @(DataStatusNoKnown);
                    break;
                }
            default:
                break;
        }
        
    }];
    
}

- (void)setEndRefresh:(NSArray *)array{
    if (_isHeaderRefreshing) {
        [self.tableView.mj_header endRefreshing];
        if (!array || array.count == 0) {
            self.tableView.mj_footer.alpha = 0;
        }else{
            self.tableView.mj_footer.alpha = 1;
        }
    }
    if (!array || array.count < self.rows) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    else{
        [self.tableView.mj_footer endRefreshing];
    }
}

- (void)setApiStatus{
    if (self.arrayData == nil || self.arrayData.count==0) {
        self.dataStatusType = @(DataStatusNoData);
    }
    else
    self.dataStatusType = @(DataStatusOk);
}

- (void)basicRequestData{
    
}

//TODO: 请求数据
- (void)loadTopData{
    _isHeaderRefreshing = YES;
    self.page = self.pageFirst;
    [self basicRequestData];
}

- (void)loadMoreData{
    _isHeaderRefreshing = NO;
    self.page ++;
    [self basicRequestData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    CommonTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[CommonTextTableViewCell identifiter]];
    //    if ([self.arrayData[indexPath.row] isKindOfClass:[NSString class]]) {
    //        cell.titleLable.text = self.arrayData[indexPath.row];
    //    }
    //    return cell;
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TextCell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TextCell"];
    }
    if ([self.arrayData[indexPath.row] isKindOfClass:[NSString class]]) {
        cell.textLabel.text = self.arrayData[indexPath.row];
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * viewHeader = [UIView new];
    return  viewHeader;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * viewFooter = [UIView new];
    return  viewFooter;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - DZNEmptyDataSetSource

-(void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
    if ([self.dataStatusType integerValue] == DataStatusError) {
        [self.tableView.mj_header beginRefreshing];
    }
}

@end
