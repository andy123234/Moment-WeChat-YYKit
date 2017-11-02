//
//  DynamicsModel.m
//  LooyuEasyBuy
//
//  Created by Andy on 15/11/20.
//  Copyright © 2015年 Doyoo. All rights reserved.
//

#import "DynamicsModel.h"


extern CGFloat maxContentLabelHeight;

@implementation DynamicsModel
{
    CGFloat _lastContentWidth;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"DynamicsModel找不到Key----------------------------%@",key);
}
-(void)setOptthumb:(NSMutableArray *)optthumb
{
    _optthumb = optthumb;
    self.likeArr = optthumb;
    
    if (optthumb.count != 0 && optthumb != nil) {
        __block BOOL hasUserID = NO;
        [optthumb enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //这里加入if判断如果存在于点赞列表则显示取消点赞
            //  if(){
                _isThumb = YES;
                hasUserID = YES;
            //        }
        }];
        if (!hasUserID) {
            _isThumb = NO;
        }
    }else{
        _isThumb = NO;
    }
    
}
- (void)setLikeArr:(NSMutableArray<DynamicsLikeItemModel *> *)likeArr
{
    NSMutableArray *tempLikes = [NSMutableArray new];
    for (id thumbDic in likeArr) {
        DynamicsLikeItemModel * likeModel = [DynamicsLikeItemModel new];
        [likeModel setValuesForKeysWithDictionary:thumbDic];
        [tempLikes addObject:likeModel];
    }
    likeArr = [tempLikes copy];
    
    _likeArr = likeArr;
}
- (void)setOptcomment:(NSMutableArray *)optcomment
{
    _optcomment = optcomment;
    self.commentArr = optcomment;
    
}
-(void)setCommentArr:(NSMutableArray<DynamicsCommentItemModel *> *)commentArr
{
    NSMutableArray *tempComments = [NSMutableArray new];
    for (id commentDic in commentArr) {
        DynamicsCommentItemModel * commentModel = [DynamicsCommentItemModel new];
        [commentModel setValuesForKeysWithDictionary:commentDic];
        [tempComments addObject:commentModel];
    }
    commentArr = [tempComments copy];
    
    _commentArr = commentArr;
}
-(NSString *)dsp
{
    if (_dsp == nil) {
        _dsp = @"";
    }
    NSMutableAttributedString * text = [[NSMutableAttributedString alloc] initWithString:_dsp];
    text.font = [UIFont systemFontOfSize:14];
    
    YYTextContainer * container = [YYTextContainer containerWithSize:CGSizeMake(SCREENWIDTH - 15 - 45 - 10 - 15, CGFLOAT_MAX)];
    
    YYTextLayout * layout = [YYTextLayout layoutWithContainer:container text:text];
    
    if (layout.rowCount <= 6) {
        _shouldShowMoreButton = NO;
    }else{
        _shouldShowMoreButton = YES;
    }
    
    return _dsp;
}
- (void)setIsOpening:(BOOL)isOpening
{
    if (!_shouldShowMoreButton) {
        _isOpening = NO;
    } else {
        _isOpening = isOpening;
    }
}
@end

@implementation DynamicsLikeItemModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"DynamicsLikeItemModel找不到Key----------------------------%@",key);
}


@end

@implementation DynamicsCommentItemModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"DynamicsCommentItemModel找不到Key----------------------------%@",key);
}

@end
