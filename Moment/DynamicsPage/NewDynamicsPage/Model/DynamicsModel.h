//
//  DynamicsModel.h
//  LooyuEasyBuy
//
//  Created by Andy on 15/11/20.
//  Copyright © 2015年 Doyoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DynamicsLikeItemModel,DynamicsCommentItemModel,NewDynamicsLayout;

@interface DynamicsModel : NSObject

@property(nonatomic,strong)NSString * pid;//动态页面ID
@property(nonatomic,strong)NSString * title;//动态页面标题
@property(nonatomic,strong)NSString * dsp;//动态页面描述
@property(nonatomic,strong)NSString * thumb;//封面图
@property(nonatomic,assign)int auditstatus;//是否打开微信分享(0:隐藏,1:开启)
@property(nonatomic,strong)NSString * exttime;//格式化时间1(例:20151024...)
@property(nonatomic,strong)NSString * userid;//用户ID
@property(nonatomic,strong)NSString * nick;//用户昵称
@property(nonatomic,strong)NSString * url;//动态页面链接
@property(nonatomic,strong)NSString * compid;//公司ID
@property(nonatomic,strong)NSString * portrait;//用户头像
@property(nonatomic,strong)NSString * background;//用户背景
@property(nonatomic,strong)NSString * remark;//用户个性签名
@property(nonatomic,strong)NSString * favorite;//该字段存在,则表示当前登录微赚宝用户已收藏过这个店铺
@property(nonatomic,strong)NSMutableArray * photocollections;//照片数组
@property(nonatomic,strong)NSMutableArray * optthumb;//点赞数组
@property(nonatomic,strong)NSMutableArray * optcomment;//评论数组
@property(nonatomic,strong)NSDictionary * companyparams;//公司信息
@property(nonatomic,strong)NSDictionary * spreadparams;//推广内容
@property(nonatomic,strong)NSMutableArray<DynamicsLikeItemModel *> * likeArr;//存放Model点赞数组
@property(nonatomic,strong)NSMutableArray<DynamicsCommentItemModel *> * commentArr;//存放Model评论数组
@property(nonatomic,strong)NSData * photocollectionsData;//照片数组(存入数据库)
@property(nonatomic,assign)int pagetype;//动态类型(0:普通动态,1:头条动态)


@property (nonatomic, assign) BOOL isOpening;//已展开文字
@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;//应该显示"全文"
@property(nonatomic,assign)BOOL isThumb;//已点赞

@end

@interface DynamicsLikeItemModel : NSObject

@property(nonatomic,copy)NSString * optid;
@property(nonatomic,copy)NSString * userid;
@property(nonatomic,copy)NSString * nick;
@property(nonatomic,assign)int opttype;
@property(nonatomic,copy)NSString * portrait;//头像
@property(nonatomic,copy)NSString * background;//背景图
@property(nonatomic,copy)NSString * remark;//个性签名

@property (nonatomic, copy) NSAttributedString *attributedContent;
@end

@interface DynamicsCommentItemModel : NSObject

@property(nonatomic,copy)NSString * optid;;
@property(nonatomic,copy)NSString * message;
@property(nonatomic,copy)NSString * userid;
@property(nonatomic,copy)NSString * nick;
@property(nonatomic,copy)NSString * touser;
@property(nonatomic,copy)NSString * tonick;
@property(nonatomic,assign)int opttype;
@property(nonatomic,copy)NSString * portrait;//头像
@property(nonatomic,copy)NSString * background;//背景图
@property(nonatomic,copy)NSString * remark;//个性签名
@property(nonatomic,copy)NSString * toportrait;//回复者头像
@property(nonatomic,copy)NSString * tobackground;//回复者背景图
@property(nonatomic,copy)NSString * toremark;//回复者个性签名
@property(nonatomic,assign)float commentCellHeight;

@property (nonatomic, copy) NSAttributedString *attributedContent;
@end

