//
//  HeaderView.m
//  UIScrollView嵌套TableView
//
//  Created by 何嘉洋 on 2019/8/28.
//  Copyright © 2019 苏州世纪飞越信息有限公司. All rights reserved.
//

#import "HeaderView.h"
#import "Masonry.h"
#import "GYChangeTextView.h"
#import "UIView+Category.h"

@interface HeaderView()<GYChangeTextViewDelegate>
///应用View
@property(nonatomic,strong)UIView *applicationNameView;
///上下滚动广告
@property (nonatomic, strong) GYChangeTextView *tView;

@end

@implementation HeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor colorWithRed:63.0/255.0 green:131.0/255.0 blue:244.0/255.0 alpha:1];
        [self setUI];
    }
    return self;
}

-(void)setUI{
    self.applicationNameView = [[UIView alloc]init];
    self.applicationNameView.backgroundColor = [UIColor whiteColor];
    self.applicationNameView.layer.masksToBounds = YES;
    [self addSubview:self.applicationNameView];
    self.applicationNameView.frame = CGRectMake(0, 168, self.frame.size.width, 164);

    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.applicationNameView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:(CGSize){60.0}];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    // 设置绘制路径
    shapeLayer.path = bezierPath.CGPath;
    // 将shapeLayer设置为cornerView的layer的mask
    self.applicationNameView.layer.mask = shapeLayer;
    

    self.tView = [[GYChangeTextView alloc] initWithFrame:CGRectMake(20, 30, 100, 40)];
    self.tView.backgroundColor = [UIColor colorWithRed:244/255.0 green:59/255.0 blue:54/255.0 alpha:1.0];
    [self.applicationNameView addSubview:self.tView];
    [self.tView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.bottom.offset(-6);
        make.height.offset(40);
    }];
    self.tView.delegate = self;
    [self.tView animationWithTexts:[NSArray arrayWithObjects:@"这是第1条",@"这是第2条",@"这是第3条", nil]];

//    [self.tView layoutIfNeeded];
//
//    [self.tView setGradientLayer:[UIColor colorWithRed:244/255.0 green:59/255.0 blue:54/255.0 alpha:1.0] endColor:[UIColor colorWithRed:254/255.0 green:134/255.0 blue:74/255.0 alpha:1.0]];
    
}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

- (void)stop {
    [_tView stopAnimation];
}

- (void)gyChangeTextView:(GYChangeTextView *)textView didTapedAtIndex:(NSInteger)index {
    NSLog(@"%ld",index);
}

@end
