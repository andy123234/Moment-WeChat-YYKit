//
//  NewDynamicsViewController.m
//  LooyuEasyBuy
//
//  Created by Andy on 2017/9/27.
//  Copyright © 2017年 Doyoo. All rights reserved.
//

#import "NewDynamicsViewController.h"
#import "NewDynamicsViewController+Delegate.h"
#import "NewDynamicsLayout.h"
#import "DynamicsModel.h"

#import "SDTimeLineRefreshHeader.h"//下拉刷新控件

@interface NewDynamicsViewController ()

@property(nonatomic,strong)SDTimeLineRefreshHeader * refreshHeader;
@property(nonatomic,strong)UISegmentedControl * segment;

@end

@implementation NewDynamicsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed  = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"朋友圈";
    [self setup];
    [self dragUpToLoadMoreData];
    [self.view addSubview:self.commentInputTF];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"moment0" ofType:@"plist"];
    NSArray * dataArray = [NSArray arrayWithContentsOfFile:plistPath];
    
    [self.layoutsArr removeAllObjects];
    for (id dict in dataArray) {
        DynamicsModel * model = [DynamicsModel modelWithDictionary:dict];
        NewDynamicsLayout * layout = [[NewDynamicsLayout alloc] initWithModel:model];
        [self.layoutsArr addObject:layout];
    }
    [self.dynamicsTable reloadData];
    
    //外观代理
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    
    //修改标题颜色
    NSDictionary * dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [navigationBar setTitleTextAttributes:dict];
    
    navigationBar.barTintColor = [UIColor colorWithRed:64.0/255.0 green:64.0/255.0 blue:64.0/255.0 alpha:1.0];
    navigationBar.tintColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)keyboardWillHide:(NSNotification *)notification{
    
    CGRect frame = _commentInputTF.frame;
    frame.origin.y = self.view.frame.size.height;
    _commentInputTF.frame = frame;
}

- (void)keyboardFrameWillChange:(NSNotification *)notification{
    CGRect keyBoardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect frame = _commentInputTF.frame;
    frame.origin.y = keyBoardFrame.origin.y - 45;
    _commentInputTF.frame = frame;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    [JRMenuView dismissAllJRMenu];
}
- (void)setup
{
    [self.view addSubview:self.dynamicsTable];
    
}
#pragma mark - 上拉加载更多数据
- (void)dragUpToLoadMoreData
{
    [self.dynamicsTable.footer beginRefreshing];
    // 添加默认的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

    // 设置文字
    [footer setTitle:@"点击或上拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载中......" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];

    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:14];

    // 设置颜色
    footer.stateLabel.textColor = [UIColor grayColor];

    // 设置footer
    self.dynamicsTable.footer = footer;
}
- (void)loadMoreData
{
    //执行事件
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"moment1" ofType:@"plist"];
        NSArray * dataArray = [NSArray arrayWithContentsOfFile:plistPath];
        
        for (id dict in dataArray) {
            DynamicsModel * model = [DynamicsModel modelWithDictionary:dict];
            NewDynamicsLayout * layout = [[NewDynamicsLayout alloc] initWithModel:model];
            [self.layoutsArr addObject:layout];
        }
        [self.dynamicsTable reloadData];
        [self.dynamicsTable.footer endRefreshingWithNoMoreData];
}
#pragma mark - getter
-(UITableView *)dynamicsTable
{
    if (!_dynamicsTable) {
        _dynamicsTable = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _dynamicsTable.dataSource = self;
        _dynamicsTable.delegate = self;
        _dynamicsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_dynamicsTable registerClass:[NewDynamicsTableViewCell class] forCellReuseIdentifier:@"NewDynamicsTableViewCell"];
        if ([[[UIDevice currentDevice] systemVersion] compare:@"11.0" options:NSNumericSearch] != NSOrderedAscending) {
            _dynamicsTable.estimatedRowHeight = 0;
        }

        UITapGestureRecognizer * tableViewGesture = [[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
            [_commentInputTF resignFirstResponder];
        }];
        
        tableViewGesture.cancelsTouchesInView = NO;
        [_dynamicsTable addGestureRecognizer:tableViewGesture];
    }
    return _dynamicsTable;
}
-(NSMutableArray *)layoutsArr
{
    if (!_layoutsArr) {
        _layoutsArr = [NSMutableArray array];
    }
    return _layoutsArr;
}
-(UITextField *)commentInputTF
{
    if (!_commentInputTF) {
        _commentInputTF = [[UITextField alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 45)];
        _commentInputTF.backgroundColor = [UIColor lightGrayColor];
        _commentInputTF.delegate = self;
        _commentInputTF.textColor = [UIColor whiteColor];
    }
    return _commentInputTF;
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
