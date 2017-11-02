//
//  NewDynamicsTableViewCell.h
//  LooyuEasyBuy
//
//  Created by Andy on 2017/9/27.
//  Copyright © 2017年 Doyoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewDynamicsLayout.h"
#import "SDWeiXinPhotoContainerView.h"
#import "JRMenuView.h"
@class NewDynamicsTableViewCell;
@protocol NewDynamicsCellDelegate;

@interface NewDynamicsGrayView : UIView

@property(nonatomic,strong)UIButton * grayBtn;
@property(nonatomic,strong)UIImageView * thumbImg;
@property(nonatomic,strong)YYLabel * dspLabel;

@property(nonatomic,strong)NewDynamicsTableViewCell * cell;

@end

@interface NewDynamicsThumbCommentView : UIView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIImageView * bgImgView;
@property(nonatomic,strong)YYLabel * thumbLabel;
@property(nonatomic,strong)UIView * dividingLine;
@property(nonatomic,strong)NSMutableArray * likeArray;
@property(nonatomic,strong)NSMutableArray * commentArray;
@property(nonatomic,strong)NewDynamicsLayout * layout;
@property(nonatomic,strong)UITableView * commentTable;

@property(nonatomic,strong)NewDynamicsTableViewCell * cell;

- (void)setWithLikeArr:(NSMutableArray *)likeArr CommentArr:(NSMutableArray *)commentArr DynamicsLayout:(NewDynamicsLayout *)layout;

@end

@interface NewDynamicsTableViewCell : UITableViewCell<JRMenuDelegate>

@property(nonatomic,strong)NewDynamicsLayout * layout;

@property(nonatomic,strong)UIImageView * portrait;
@property(nonatomic,strong)YYLabel * nameLabel;
@property(nonatomic,strong)YYLabel * detailLabel;
@property(nonatomic,strong)UIButton * moreLessDetailBtn;
@property(nonatomic,strong)SDWeiXinPhotoContainerView *picContainerView;
@property(nonatomic,strong)NewDynamicsGrayView * grayView;
@property(nonatomic,strong)UIButton * spreadBtn;
@property(nonatomic,strong)YYLabel * dateLabel;
@property(nonatomic,strong)UIButton * deleteBtn;
@property(nonatomic,strong)UIButton * menuBtn;
@property(nonatomic,strong)NewDynamicsThumbCommentView * thumbCommentView;
@property(nonatomic,strong)UIView * dividingLine;

@property(nonatomic,strong)JRMenuView * jrMenuView;

@property(nonatomic,assign)id<NewDynamicsCellDelegate>delegate;

@end

@protocol NewDynamicsCellDelegate <NSObject>
/**
 点击了用户头像或名称

 @param userId 用户ID
 */
- (void)DynamicsCell:(NewDynamicsTableViewCell *)cell didClickUser:(NSString *)userId;

/**
 点击了全文/收回

 */
- (void)DidClickMoreLessInDynamicsCell:(NewDynamicsTableViewCell *)cell;

/**
 点击了推广按钮

 */
- (void)DidClickSpreadInDynamicsCell:(NewDynamicsTableViewCell *)cell;
/**
 点击了灰色详情

 */
- (void)DidClickGrayViewInDynamicsCell:(NewDynamicsTableViewCell *)cell;
/**
 点赞

 */
- (void)DidClickThunmbInDynamicsCell:(NewDynamicsTableViewCell *)cell;

/**
 取消点赞

 */
- (void)DidClickCancelThunmbInDynamicsCell:(NewDynamicsTableViewCell *)cell;

/**
 评论

 */
- (void)DidClickCommentInDynamicsCell:(NewDynamicsTableViewCell *)cell;

/**
 私聊

 */
- (void)DidClickChatInDynamicsCell:(NewDynamicsTableViewCell *)cell;
/**
 分享

 */
- (void)DidClickShareInDynamicsCell:(NewDynamicsTableViewCell *)cell;

/**
 删除

 */
- (void)DidClickDeleteInDynamicsCell:(NewDynamicsTableViewCell *)cell;

/**
 点击了评论

 @param commentModel 评论模型
 */
- (void)DynamicsCell:(NewDynamicsTableViewCell *)cell didClickComment:(DynamicsCommentItemModel *)commentModel;
/**
 点击了网址或电话号码
 @param url 网址链接
 @param phoneNum 电话号
 */
- (void)DynamicsCell:(NewDynamicsTableViewCell *)cell didClickUrl:(NSString *)url PhoneNum:(NSString *)phoneNum;
@end


