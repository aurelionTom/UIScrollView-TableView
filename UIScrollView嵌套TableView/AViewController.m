//
//  AViewController.m
//  UIScrollView嵌套TableView
//
//  Created by 何嘉洋 on 2019/8/28.
//  Copyright © 2019 苏州世纪飞越信息有限公司. All rights reserved.
//
#define CC_KSCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define CC_KSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//X和XS的逻辑尺寸相同,XR和XS MAX的尺寸相同
#define IphoneX     (CC_KSCREEN_WIDTH == 375.0 && CC_KSCREEN_HEIGHT == 812.0)
#define IphoneXR    (CC_KSCREEN_WIDTH == 414.0 && CC_KSCREEN_HEIGHT == 896.0)
#define IS_LHDevice ((IphoneX || IphoneXR) ? YES:NO)

#import "AViewController.h"
#import "BackScrollView.h"
#import "MJRefresh/MJRefresh.h"
#import "HeaderView.h"

@interface AViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) BackScrollView *mainScrollView;
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic, strong) UITableView *subTableView;
@property (nonatomic, assign) BOOL backViewScroll;
@property (nonatomic, assign) BOOL subViewScroll;

///导航栏高度
@property(nonatomic,assign)CGFloat navicHeight;

@end

@implementation AViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _navicHeight = 85;
    if (IS_LHDevice) {
        _navicHeight += 34;
    }
    
    self.backViewScroll = YES;
    self.subViewScroll = NO;
    
    self.mainScrollView = [[BackScrollView alloc] initWithFrame:self.view.bounds];
    self.mainScrollView.backgroundColor = UIColor.whiteColor;
    self.mainScrollView.delegate = self;
    self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.mainScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    [self.view addSubview:self.mainScrollView];
    
    self.headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen.bounds), 168 + 164 + 190)];
    [self.mainScrollView addSubview:self.headerView];
    
    
    self.subTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.subTableView.dataSource = self;
    self.subTableView.delegate = self;
    self.subTableView.showsVerticalScrollIndicator = NO;
    self.subTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:nil];
    [self.mainScrollView addSubview:self.subTableView];
    
    self.subTableView.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame)+70, CGRectGetWidth(self.subTableView.bounds), CGRectGetHeight(self.subTableView.bounds)-85-70);
    self.mainScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.subTableView.bounds), CGRectGetMaxY(self.subTableView.frame));
    
    
}

- (void)refresh
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.mainScrollView.mj_header endRefreshing];
        
        CGFloat height = 168 + 164 + 190;//arc4random()%100+100;
        [UIView animateWithDuration:1 animations:^{
            self.headerView.mj_h = height;
            self.subTableView.mj_y = self.headerView.mj_y+self.headerView.mj_h+70;
        }];
    });
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor whiteColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"rowIndex:%ld",indexPath.row];
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat maxY = CGRectGetMaxY(self.headerView.frame) - 85;
    NSLog(@"--%lf",maxY);
    if (scrollView == self.mainScrollView) {//backScrollView
        if (!self.backViewScroll) {
            self.mainScrollView.contentOffset = CGPointMake(0, maxY);
        }else{
            if (scrollView.contentOffset.y >= maxY) {
                self.backViewScroll = NO;
                self.subViewScroll = YES;
                self.subTableView.showsVerticalScrollIndicator = YES;
                self.mainScrollView.showsVerticalScrollIndicator = NO;
                self.mainScrollView.contentOffset = CGPointMake(0, maxY);
            }else{
                self.subTableView.contentOffset = CGPointZero;
            }
        }
    }else{//subScrollView
        if (!self.subViewScroll) {
            self.subTableView.contentOffset = CGPointZero;
        }else{
            if (scrollView.contentOffset.y <= 0) {
                self.subViewScroll = NO;
                self.backViewScroll = YES;
                self.subTableView.showsVerticalScrollIndicator = NO;
                self.mainScrollView.showsVerticalScrollIndicator = YES;
                self.subTableView.contentOffset = CGPointMake(0, 0);
            }else{
                self.mainScrollView.contentOffset = CGPointMake(0, maxY);
            }
        }
    }
}

@end
