//
//  JRMenuView.h
//  JRMenu
//
//  Created by Andy on 15/12/31.
//  Copyright © 2015年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JRMenuDelegate <NSObject>

-(void)hasSelectedJRMenuIndex:(NSInteger)jrMenuIndex;

@end
@interface JRMenuView : UIView

@property(assign,nonatomic)id<JRMenuDelegate>delegate;

- (instancetype)init;//初始化
- (void)setTargetView:(UIView *)target InView:(UIView *)superview;
- (void)setTitleArray:(NSArray *)array;
- (void)show;
- (void)dismiss;
+ (void)dismissAllJRMenu;//收回所有JRMenu
@end
