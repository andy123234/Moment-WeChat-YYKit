//
//  JRMenuView.m
//  JRMenu
//
//  Created by Andy on 15/12/31.
//  Copyright © 2015年 Andy. All rights reserved.
//

#import "JRMenuView.h"

#define JRMenuHeight 35
#define JRMenuDismissNotification @"JRMenuDismissNotification"
@implementation JRMenuView
{
    BOOL hasShow;
    CGFloat jrMenuWidth;
    UIView * backGroundView;
    UIButton * thumbBtn;
    UIButton * commentBtn;
    UIButton * shareBtn;
    NSArray * nameArray;
    UIView * targetView;
    UIView * superView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        hasShow = NO;
    }
    return self;
}
- (void)setTargetView:(UIView *)target InView:(UIView *)superview
{
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    targetView = target;
    superView = superview;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissOtherJRMenu) name:JRMenuDismissNotification object:nil];
}
- (void)setTitleArray:(NSArray *)array
{
    nameArray = [NSArray arrayWithArray:array];
    jrMenuWidth = 0;
    if (self.subviews != nil && self.subviews.count != 0) {//移除所有子视图
        for (id object in self.subviews) {
            [object removeFromSuperview];
        }
    }
    for (int i = 0; i < array.count; i++) {
        //添加按钮
        UIButton * itemBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        itemBtn.tag = 80000 + i;
        [itemBtn setTitle:nameArray[i] forState:UIControlStateNormal];
        [itemBtn setTintColor:[UIColor whiteColor]];
        itemBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
        CGFloat length = [nameArray[i] boundingRectWithSize:CGSizeMake(320, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width + 30;
        itemBtn.frame = CGRectMake(jrMenuWidth, 0, length , JRMenuHeight);
        jrMenuWidth += length;
        [itemBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:itemBtn];
        
        //设置分割线
        if (i < array.count - 1) {
            UIView * dividingLine = [[UIView alloc] initWithFrame:CGRectMake(jrMenuWidth - 0.5, JRMenuHeight/4, 1, JRMenuHeight/2)];
            dividingLine.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:dividingLine];
        }
        
    }
    
    //添加背景view
    backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, jrMenuWidth, JRMenuHeight)];
    backGroundView.backgroundColor = [UIColor blackColor];
    [self insertSubview:backGroundView atIndex:0];
}
- (void)click:(UIButton *)sender
{
    if(self.delegate&&[self.delegate respondsToSelector:@selector(hasSelectedJRMenuIndex:)]) {
        [_delegate hasSelectedJRMenuIndex:sender.tag - 80000];
    }
    [self dismiss];
}
- (void)show
{
    if (!hasShow) {
        [JRMenuView dismissAllJRMenu];
        [superView bringSubviewToFront:self];
        hasShow = YES;
        self.frame = CGRectMake(targetView.frame.origin.x, targetView.frame.origin.y, 0, JRMenuHeight);
        [UIView animateWithDuration:.1 animations:^{
            [self setFrame:CGRectMake(targetView.frame.origin.x - jrMenuWidth, targetView.frame.origin.y, jrMenuWidth, JRMenuHeight)];
        }];
    }else{
        [self dismiss];
    }
    
}
- (void)dismiss
{
    if (hasShow) {
        hasShow = NO;
        [UIView animateWithDuration:.1 animations:^{
            [self setFrame:CGRectMake(targetView.frame.origin.x, targetView.frame.origin.y, 0, JRMenuHeight)];
        }];
    }
    
}
- (void)dismissOtherJRMenu
{
    if (hasShow) {
        [self dismiss];
    }
}
+ (void)dismissAllJRMenu
{
    [[NSNotificationCenter defaultCenter] postNotificationName:JRMenuDismissNotification object:nil];
}
@end

