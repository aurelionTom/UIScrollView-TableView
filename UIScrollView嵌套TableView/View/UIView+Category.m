//
//  UIView+Category.m
//  UIScrollView嵌套TableView
//
//  Created by 何嘉洋 on 2019/8/29.
//  Copyright © 2019 苏州世纪飞越信息有限公司. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)

- (void)setGradientLayer:(UIColor*)startColor endColor:(UIColor*)endColor{
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [self.layer addSublayer:gradientLayer];
    
    //设置渐变区域的起始和终止位置（范围为0-1）
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    
    //设置颜色数组
    //    gradientLayer.colors = @[(__bridge id)[UIColor blueColor].CGColor,
    //                                  (__bridge id)[UIColor redColor].CGColor];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor,
                             (__bridge id)endColor.CGColor];
    
    //设置颜色分割点（范围：0-1）
    gradientLayer.locations = @[@(0.5f), @(1.0f)];
}

@end
