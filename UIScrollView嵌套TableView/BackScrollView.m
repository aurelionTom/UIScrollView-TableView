//
//  BackScrollView.m
//  UIScrollView嵌套TableView
//
//  Created by 何嘉洋 on 2019/8/28.
//  Copyright © 2019 苏州世纪飞越信息有限公司. All rights reserved.
//

#import "BackScrollView.h"

@interface BackScrollView()<UIGestureRecognizerDelegate>

@end

@implementation BackScrollView


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}



@end
