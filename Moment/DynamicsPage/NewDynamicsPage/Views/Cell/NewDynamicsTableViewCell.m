//
//  NewDynamicsTableViewCell.m
//  LooyuEasyBuy
//
//  Created by Andy on 2017/9/27.
//  Copyright © 2017年 Doyoo. All rights reserved.
//

#import "NewDynamicsTableViewCell.h"

@implementation NewDynamicsGrayView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = SCREENWIDTH - kDynamicsNormalPadding * 2 - kDynamicsPortraitNamePadding - kDynamicsPortraitWidthAndHeight;;
        frame.size.height = kDynamicsGrayBgHeight;
    }
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    [self addSubview:self.grayBtn];
    [self addSubview:self.thumbImg];
    [self addSubview:self.dspLabel];
    
    [self layout];
}
- (void)layout
{
    _grayBtn.frame = self.frame;
    
    _thumbImg.left = kDynamicsGrayPicPadding;
    _thumbImg.top = kDynamicsGrayPicPadding;
    _thumbImg.width = kDynamicsGrayPicHeight;
    _thumbImg.height = kDynamicsGrayPicHeight;

    _dspLabel.left = _thumbImg.right + kDynamicsNameDetailPadding;
    _dspLabel.width = self.right - kDynamicsNameDetailPadding - _dspLabel.left;
}

-(UIButton *)grayBtn
{
    if (!_grayBtn) {
        _grayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _grayBtn.backgroundColor = RGBA_COLOR(240, 240, 242, 1);
        WS(weakSelf);
        [_grayBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.cell.delegate != nil && [weakSelf.cell.delegate respondsToSelector:@selector(DidClickGrayViewInDynamicsCell:)]) {
                [weakSelf.cell.delegate DidClickGrayViewInDynamicsCell:weakSelf.cell];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _grayBtn;
}
-(UIImageView *)thumbImg
{
    if (!_thumbImg) {
        _thumbImg = [UIImageView new];
        _thumbImg.userInteractionEnabled = NO;
        _thumbImg.backgroundColor = [UIColor grayColor];
    }
    return _thumbImg;
}
-(YYLabel *)dspLabel
{
    if (!_dspLabel) {
        _dspLabel = [YYLabel new];
        _dspLabel.userInteractionEnabled = NO;
    }
    return _dspLabel;
}

@end

@implementation NewDynamicsThumbCommentView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = SCREENWIDTH - kDynamicsNormalPadding * 2 - kDynamicsPortraitNamePadding - kDynamicsPortraitWidthAndHeight;;
        frame.size.height = 0;
    }
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    [self addSubview:self.bgImgView];
    [self addSubview:self.thumbLabel];
    [self addSubview:self.dividingLine];
    [self addSubview:self.commentTable];
    
}
- (void)setWithLikeArr:(NSMutableArray *)likeArr CommentArr:(NSMutableArray *)commentArr DynamicsLayout:(NewDynamicsLayout *)layout
{
    _likeArray = likeArr;
    self.commentArray = layout.commentLayoutArr;
    _layout = layout;
    [self layoutView];
}
- (void)layoutView
{
    _bgImgView.top = 0;
    _bgImgView.left = 0;
    _bgImgView.width = self.frame.size.width;
    _bgImgView.height = _layout.thumbCommentHeight;
    
    UIView * lastView = _bgImgView;
    
    if (_likeArray.count != 0) {
        _thumbLabel.hidden = NO;
        _thumbLabel.top = 10;
        _thumbLabel.left = kDynamicsNameDetailPadding;
        _thumbLabel.width = self.frame.size.width - kDynamicsNameDetailPadding*2;
        _thumbLabel.height = _layout.thumbLayout.textBoundingSize.height;
        _thumbLabel.textLayout = _layout.thumbLayout;
        lastView = _thumbLabel;
    }else{
        _thumbLabel.hidden = YES;
    }
    
    
    if (_likeArray.count != 0 && _commentArray.count != 0) {
        _dividingLine.hidden = NO;
        _dividingLine.top = _thumbLabel.bottom;
        _dividingLine.left = 0;
        _dividingLine.width = self.frame.size.width;
        _dividingLine.height = .5;
        lastView = _dividingLine;
    }else{
        _dividingLine.hidden = YES;
    }
    
    if (_commentArray.count != 0) {
        _commentTable.hidden = NO;
        _commentTable.left = _bgImgView.left;
        _commentTable.top = lastView == _dividingLine ? lastView.bottom + .5 : lastView.top + 10;
        _commentTable.width = _bgImgView.width;
        _commentTable.height = _layout.commentHeight;
        
        [_commentTable reloadData];
    }else{
        _commentTable.hidden = YES;
    }
    
}
#pragma mark - TableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YYTextLayout * layout = self.commentArray[indexPath.row];
    return layout.textBoundingSize.height + kDynamicsGrayPicPadding*2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;//这里不使用重用机制(会出现评论窜位bug)
    
    YYTextLayout * layout = self.commentArray[indexPath.row];

    YYLabel * label;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"commentCell"];
        cell.backgroundColor = [UIColor clearColor];
        label = [YYLabel new];
        [cell addSubview:label];
    }
    
    label.top = kDynamicsGrayPicPadding;
    label.left = kDynamicsNameDetailPadding;
    label.width = self.frame.size.width - kDynamicsNameDetailPadding*2;
    label.height = layout.textBoundingSize.height;
    label.textLayout = layout;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    if (_cell.delegate != nil && [_cell.delegate respondsToSelector:@selector(DynamicsCell:didClickComment:)]) {
        [_cell.delegate DynamicsCell:_cell didClickComment:(DynamicsCommentItemModel *)_cell.layout.model.commentArr[indexPath.row]];
    }
}
-(UIImageView *)bgImgView
{
    if (!_bgImgView) {
        _bgImgView = [UIImageView new];
        UIImage *bgImage = [[[UIImage imageNamed:@"LikeCmtBg"] stretchableImageWithLeftCapWidth:40 topCapHeight:30] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _bgImgView.image = bgImage;
        _bgImgView.backgroundColor = [UIColor clearColor];
    }
    return _bgImgView;
}
-(YYLabel *)thumbLabel
{
    if (!_thumbLabel) {
        _thumbLabel = [YYLabel new];
    }
    return _thumbLabel;
}
-(UIView *)dividingLine
{
    if (!_dividingLine) {
        _dividingLine = [UIView new];
        _dividingLine.backgroundColor = RGBA_COLOR(210, 210, 210, 1);
    }
    return _dividingLine;
}
-(UITableView *)commentTable
{
    if (!_commentTable) {
        _commentTable = [UITableView new];
        _commentTable.dataSource = self;
        _commentTable.delegate = self;
        _commentTable.scrollEnabled = NO;
        _commentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _commentTable.backgroundColor = [UIColor clearColor];
    }
    return _commentTable;
}
@end

@implementation NewDynamicsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)setup
{
    [self.contentView addSubview:self.portrait];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.moreLessDetailBtn];
    [self.contentView addSubview:self.picContainerView];
    [self.contentView addSubview:self.grayView];
    [self.contentView addSubview:self.spreadBtn];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.deleteBtn];
    [self.contentView addSubview:self.menuBtn];
    [self.contentView addSubview:self.thumbCommentView];
    [self.contentView addSubview:self.dividingLine];
}

-(void)setLayout:(NewDynamicsLayout *)layout
{
    UIView * lastView;
    _layout = layout;
    DynamicsModel * model = layout.model;
    
    //头像
    _portrait.left = kDynamicsNormalPadding;
    _portrait.top = kDynamicsNormalPadding;
    _portrait.size = CGSizeMake(kDynamicsPortraitWidthAndHeight, kDynamicsPortraitWidthAndHeight);
    [_portrait sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgHeader,model.portrait]]];
    
    //昵称
    _nameLabel.text = model.nick;
    _nameLabel.top = kDynamicsNormalPadding;
    _nameLabel.left = _portrait.right + kDynamicsPortraitNamePadding;
    CGSize nameSize = [_nameLabel sizeThatFits:CGSizeZero];
    _nameLabel.width = nameSize.width;
    _nameLabel.height = kDynamicsNameHeight;
    
    
    //描述
    _detailLabel.left = _nameLabel.left;
    _detailLabel.top = _nameLabel.bottom + kDynamicsNameDetailPadding;
    _detailLabel.width = SCREENWIDTH - kDynamicsNormalPadding * 2 - kDynamicsPortraitNamePadding - kDynamicsPortraitWidthAndHeight;
    _detailLabel.height = layout.detailLayout.textBoundingSize.height;
    _detailLabel.textLayout = layout.detailLayout;
    lastView = _detailLabel;
    
    //展开/收起按钮
    _moreLessDetailBtn.left = _nameLabel.left;
    _moreLessDetailBtn.top = _detailLabel.bottom + kDynamicsNameDetailPadding;
    _moreLessDetailBtn.height = kDynamicsMoreLessButtonHeight;
    [_moreLessDetailBtn sizeToFit];
    
    if (model.shouldShowMoreButton) {
        _moreLessDetailBtn.hidden = NO;
        
        if (model.isOpening) {
            [_moreLessDetailBtn setTitle:@"收起" forState:UIControlStateNormal];
        }else{
            [_moreLessDetailBtn setTitle:@"全文" forState:UIControlStateNormal];
        }
        
        lastView = _moreLessDetailBtn;
    }else{
        _moreLessDetailBtn.hidden = YES;
    }
    //图片集
    if (model.photocollections.count != 0) {
        _picContainerView.hidden = NO;

        _picContainerView.left = _nameLabel.left;
        _picContainerView.top = lastView.bottom + kDynamicsNameDetailPadding;
        _picContainerView.width = layout.photoContainerSize.width;
        _picContainerView.height = layout.photoContainerSize.height;
        _picContainerView.picPathStringsArray = model.photocollections;
        
        lastView = _picContainerView;
    }else{
        _picContainerView.hidden = YES;
    }
    //头条
    if (model.pagetype == 1) {
        _grayView.hidden = NO;
        
        _grayView.left = _nameLabel.left;
        _grayView.top = lastView.bottom + kDynamicsNameDetailPadding;
        _grayView.width = _detailLabel.right - _grayView.left;
        _grayView.height = kDynamicsGrayBgHeight;
        
        [_grayView.thumbImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgHeader,model.thumb]]];
        _grayView.dspLabel.height = layout.dspLayout.textBoundingSize.height;
        _grayView.dspLabel.centerY = _grayView.thumbImg.centerY;
        _grayView.dspLabel.textLayout = layout.dspLayout;
        
        lastView = _grayView;
    }else{
        _grayView.hidden = YES;
    }
    
    //推广
    _spreadBtn.left = _nameLabel.left;
    _spreadBtn.top = lastView.bottom + kDynamicsNameDetailPadding;;
    
    if (model.spreadparams.count != 0) {
        _spreadBtn.hidden = NO;
        [_spreadBtn setTitle:model.spreadparams[@"name"] forState:UIControlStateNormal];
        CGSize fitSize = [_spreadBtn sizeThatFits:CGSizeZero];
        _spreadBtn.width = fitSize.width > _detailLabel.size.width ? _detailLabel.size.width : fitSize.width;
        _spreadBtn.height = kDynamicsSpreadButtonHeight;
        
        lastView = _spreadBtn;
    }else if (model.companyparams.count != 0){
        _spreadBtn.hidden = NO;
        [_spreadBtn setTitle:model.companyparams[@"name"] forState:UIControlStateNormal];
        CGSize fitSize = [_spreadBtn sizeThatFits:CGSizeZero];
        _spreadBtn.width = fitSize.width > _detailLabel.size.width ? _detailLabel.size.width : fitSize.width;
        _spreadBtn.height = kDynamicsSpreadButtonHeight;
        
        lastView = _spreadBtn;
    }else{
        _spreadBtn.hidden = YES;
    }
    
    //时间
    _dateLabel.left = _detailLabel.left;
    _dateLabel.top = lastView.bottom + kDynamicsPortraitNamePadding;
    NSString * newTime = [self formateDate:model.exttime withFormate:@"yyyyMMddHHmmss"];
    _dateLabel.text = newTime;
    CGSize dateSize = [_dateLabel sizeThatFits:CGSizeMake(100, kDynamicsNameHeight)];
    _dateLabel.width = dateSize.width;
    _dateLabel.height = kDynamicsNameHeight;
    
        
    _deleteBtn.left = _dateLabel.right + kDynamicsPortraitNamePadding;
    _deleteBtn.top = _dateLabel.top;
    CGSize deleteSize = [_deleteBtn sizeThatFits:CGSizeMake(100, kDynamicsNameHeight)];
    _deleteBtn.width = deleteSize.width;
    _deleteBtn.height = kDynamicsNameHeight;
    
    //更多
    _menuBtn.left = _detailLabel.right - 30 + 5;
    _menuBtn.top = lastView.bottom + kDynamicsPortraitNamePadding - 8;
    _menuBtn.size = CGSizeMake(30, 30);
    
    if (model.likeArr.count != 0 || model.commentArr.count != 0) {
        _thumbCommentView.hidden = NO;
        //点赞/评论
        _thumbCommentView.left = _detailLabel.left;
        _thumbCommentView.top = _dateLabel.bottom + kDynamicsPortraitNamePadding;
        _thumbCommentView.width = _detailLabel.width;
        _thumbCommentView.height = layout.thumbCommentHeight;
        
        [_thumbCommentView setWithLikeArr:model.likeArr CommentArr:model.commentArr DynamicsLayout:layout];
    }else{
        _thumbCommentView.hidden = YES;
    }
    
    
    //分割线
    _dividingLine.left = 15;
    _dividingLine.height = .5;
    _dividingLine.width = SCREENWIDTH - 15;
    _dividingLine.bottom = layout.height - .5;
    
    WS(weakSelf);
    layout.clickUserBlock = ^(NSString *userID) {//点赞评论区域点击用户昵称操作
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(DynamicsCell:didClickUser:)]) {
            [weakSelf.delegate DynamicsCell:weakSelf didClickUser:userID];
        }
    };
    
    layout.clickUrlBlock = ^(NSString *url) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(DynamicsCell:didClickUrl:PhoneNum:)]) {
            [weakSelf.delegate DynamicsCell:weakSelf didClickUrl:url PhoneNum:nil];
        }
    };
    
    layout.clickPhoneNumBlock = ^(NSString *phoneNum) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(DynamicsCell:didClickUrl:PhoneNum:)]) {
            [weakSelf.delegate DynamicsCell:weakSelf didClickUrl:nil PhoneNum:phoneNum];
        }
    };
}
#pragma mark - 弹出JRMenu
- (void)presentMenuController
{
    DynamicsModel * model = _layout.model;
    if (!model.isThumb) {//点赞
        if (!_jrMenuView) {
            _jrMenuView = [[JRMenuView alloc] init];
        }
        [_jrMenuView setTargetView:_menuBtn InView:self.contentView];
        _jrMenuView.delegate = self;
        [_jrMenuView setTitleArray:@[@"点赞",@"评论"]];
        [self.contentView addSubview:_jrMenuView];
        [_jrMenuView show];
    }else{//取消点赞
        if (!_jrMenuView) {
            _jrMenuView = [[JRMenuView alloc] init];
        }
        [_jrMenuView setTargetView:_menuBtn InView:self.contentView];
        _jrMenuView.delegate = self;
        [_jrMenuView setTitleArray:@[@"取消点赞",@"评论"]];
        [self.contentView addSubview:_jrMenuView];
        [_jrMenuView show];
    }
}
#pragma mark - 点击JRMenu上的Btn
-(void)hasSelectedJRMenuIndex:(NSInteger)jrMenuIndex
{
    DynamicsModel * model = _layout.model;
    if (jrMenuIndex == 0) {
        if (!model.isThumb) {
            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(DidClickThunmbInDynamicsCell:)]) {
                [_delegate DidClickThunmbInDynamicsCell:self];
            }
        }else{
            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(DidClickCancelThunmbInDynamicsCell:)]) {
                [_delegate DidClickCancelThunmbInDynamicsCell:self];
            }
        }
    }else{
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(DidClickCommentInDynamicsCell:)]) {
            [_delegate DidClickCommentInDynamicsCell:self];
        }
    }
}
#pragma mark - getter
-(UIImageView *)portrait
{
    if(!_portrait){
        _portrait = [UIImageView new];
        _portrait.userInteractionEnabled = YES;
        _portrait.backgroundColor = [UIColor grayColor];
        WS(weakSelf);
        UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(DynamicsCell:didClickUser:)]) {
                [weakSelf.delegate DynamicsCell:weakSelf didClickUser:weakSelf.layout.model.userid];
            }
        }];
        [_portrait addGestureRecognizer:tapGR];
    }
    return _portrait;
}
-(YYLabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [YYLabel new];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = [UIColor colorWithRed:74/255.0 green:90/255.0 blue:133/255.0 alpha:1];
        WS(weakSelf);
        UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(DynamicsCell:didClickUser:)]) {
                [weakSelf.delegate DynamicsCell:weakSelf didClickUser:weakSelf.layout.model.userid];
            }
        }];
        [_nameLabel addGestureRecognizer:tapGR];
    }
    return _nameLabel;
}
-(YYLabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [YYLabel new];
        _detailLabel.textLongPressAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
//            containerView.backgroundColor = RGBA_COLOR(1, 1, 1, .2);
            [SVProgressHUD showSuccessWithStatus:@"文字复制成功!"];
            UIPasteboard * board = [UIPasteboard generalPasteboard];
            board.string = text.string;
//            [Utils delayTime:.5 TimeOverBlock:^{
//                containerView.backgroundColor = [UIColor clearColor];
//            }];
        };
    }
    return _detailLabel;
}
-(UIButton *)moreLessDetailBtn
{
    if (!_moreLessDetailBtn) {
        _moreLessDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreLessDetailBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_moreLessDetailBtn setTitleColor:[UIColor colorWithRed:74/255.0 green:90/255.0 blue:133/255.0 alpha:1] forState:UIControlStateNormal];
        _moreLessDetailBtn.hidden = YES;
        WS(weakSelf);
        [_moreLessDetailBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(DidClickMoreLessInDynamicsCell:)]) {
                [weakSelf.delegate DidClickMoreLessInDynamicsCell:weakSelf];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreLessDetailBtn;
}
-(SDWeiXinPhotoContainerView *)picContainerView
{
    if (!_picContainerView) {
        _picContainerView = [SDWeiXinPhotoContainerView new];
        _picContainerView.hidden = YES;
    }
    return _picContainerView;
}
-(UIButton *)spreadBtn
{
    if (!_spreadBtn) {
        _spreadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _spreadBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _spreadBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [_spreadBtn setTitleColor:[UIColor colorWithRed:74/255.0 green:90/255.0 blue:133/255.0 alpha:1] forState:UIControlStateNormal];
        WS(weakSelf);
        [_spreadBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.delegate != nil && [weakSelf.delegate respondsToSelector:@selector(DidClickSpreadInDynamicsCell:)]) {
                [weakSelf.delegate DidClickSpreadInDynamicsCell:weakSelf];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _spreadBtn;
}
-(NewDynamicsGrayView *)grayView
{
    if (!_grayView) {
        _grayView = [NewDynamicsGrayView new];
        _grayView.cell = self;
    }
    return _grayView;
}
-(YYLabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [YYLabel new];
        _dateLabel.textColor = [UIColor lightGrayColor];
        _dateLabel.font = [UIFont systemFontOfSize:13];
    }
    return _dateLabel;
}
-(UIButton *)deleteBtn
{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        _deleteBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        _deleteBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_deleteBtn setTitleColor:[UIColor colorWithRed:74/255.0 green:90/255.0 blue:133/255.0 alpha:1] forState:UIControlStateNormal];
        WS(weakSelf);
        [_deleteBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.delegate != nil && [weakSelf.delegate respondsToSelector:@selector(DidClickDeleteInDynamicsCell:)]) {
                [weakSelf.delegate DidClickDeleteInDynamicsCell:weakSelf];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}
-(UIButton *)menuBtn
{
    if (!_menuBtn) {
        _menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _menuBtn.contentMode = UIViewContentModeScaleAspectFit;
        [_menuBtn setImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
        WS(weakSelf);
        [_menuBtn bk_addEventHandler:^(id sender) {
            [weakSelf presentMenuController];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _menuBtn;
}
-(NewDynamicsThumbCommentView *)thumbCommentView
{
    if (!_thumbCommentView) {
        _thumbCommentView = [NewDynamicsThumbCommentView new];
        _thumbCommentView.cell = self;
    }
    return _thumbCommentView;
}
-(UIView *)dividingLine
{
    if (!_dividingLine) {
        _dividingLine = [UIView new];
        _dividingLine.backgroundColor = [UIColor lightGrayColor];
        _dividingLine.alpha = .3;
    }
    return _dividingLine;
}

- (NSString *)formateDate:(NSString *)dateString withFormate:(NSString *) formate
{
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    
    NSDate * nowDate = [NSDate date];
    
    /////  将需要转换的时间转换成 NSDate 对象
    NSDate * needFormatDate = [dateFormatter dateFromString:dateString];
    /////  取当前时间和转换时间两个日期对象的时间间隔
    /////  这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:  typedef double NSTimeInterval;
    NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
    
    //// 再然后，把间隔的秒数折算成天数和小时数：
    
    NSString *dateStr = @"";
    
    if (time<=60) {  //// 1分钟以内的
        dateStr = @"刚刚";
    }else if(time<=60*60){  ////  一个小时以内的
        
        int mins = time/60;
        dateStr = [NSString stringWithFormat:@"%d分钟前",mins];
        
    }else if(time<=60*60*24){   //// 在两天内的
        
        [dateFormatter setDateFormat:@"YYYY/MM/dd"];
        NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
        NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
        
        [dateFormatter setDateFormat:@"HH:mm"];
        if ([need_yMd isEqualToString:now_yMd]) {
            //// 在同一天
            dateStr = [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:needFormatDate]];
        }else{
            ////  昨天
            dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:needFormatDate]];
        }
    }else {
        
        [dateFormatter setDateFormat:@"yyyy"];
        NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
        NSString *nowYear = [dateFormatter stringFromDate:nowDate];
        
        if ([yearStr isEqualToString:nowYear]) {
            ////  在同一年
            [dateFormatter setDateFormat:@"MM月dd日"];
            dateStr = [dateFormatter stringFromDate:needFormatDate];
        }else{
            [dateFormatter setDateFormat:@"yyyy/MM/dd"];
            dateStr = [dateFormatter stringFromDate:needFormatDate];
        }
    }
    
    return dateStr;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
