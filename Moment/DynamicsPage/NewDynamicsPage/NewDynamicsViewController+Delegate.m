//
//  NewDynamicsViewController+Delegate.m
//  LooyuEasyBuy
//
//  Created by Andy on 2017/9/28.
//  Copyright © 2017年 Doyoo. All rights reserved.
//

#import "NewDynamicsViewController+Delegate.h"

@implementation NewDynamicsViewController (Delegate)

#pragma mark - TableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewDynamicsLayout * layout = self.layoutsArr[indexPath.row];
    return layout.height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.layoutsArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewDynamicsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewDynamicsTableViewCell"];
    cell.layout = self.layoutsArr[indexPath.row];
    cell.delegate = self;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [JRMenuView dismissAllJRMenu];
}
#pragma mark - ScollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [JRMenuView dismissAllJRMenu];//收回JRMenuView
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.commentInputTF resignFirstResponder];
}
#pragma mark - NewDynamiceCellDelegate
-(void)DynamicsCell:(NewDynamicsTableViewCell *)cell didClickUser:(NSString *)userId
{
    NSLog(@"点击了用户");
}
-(void)DidClickMoreLessInDynamicsCell:(NewDynamicsTableViewCell *)cell
{
    NSIndexPath * indexPath = [self.dynamicsTable indexPathForCell:cell];
    NewDynamicsLayout * layout = self.layoutsArr[indexPath.row];
    layout.model.isOpening = !layout.model.isOpening;
    [layout resetLayout];
    CGRect cellRect = [self.dynamicsTable rectForRowAtIndexPath:indexPath];

    [self.dynamicsTable reloadData];

    if (cellRect.origin.y < self.dynamicsTable.contentOffset.y + 64) {
        [self.dynamicsTable scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}
-(void)DidClickGrayViewInDynamicsCell:(NewDynamicsTableViewCell *)cell
{
    NSLog(@"点击了灰色区域");
}
-(void)DidClickThunmbInDynamicsCell:(NewDynamicsTableViewCell *)cell
{
    NSIndexPath * indexPath = [self.dynamicsTable indexPathForCell:cell];
    NewDynamicsLayout * layout = self.layoutsArr[indexPath.row];
    DynamicsModel * model = layout.model;

    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"12345678910",@"userid",@"Andy",@"nick", nil];
    NSMutableArray * newThumbArr = [NSMutableArray arrayWithArray:model.optthumb];
    [newThumbArr addObject:dic];
    model.optthumb = [newThumbArr copy];
    [layout resetLayout];
    [self.dynamicsTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)DidClickCancelThunmbInDynamicsCell:(NewDynamicsTableViewCell *)cell
{
    NSIndexPath * indexPath = [self.dynamicsTable indexPathForCell:cell];
    NewDynamicsLayout * layout = self.layoutsArr[indexPath.row];
    DynamicsModel * model = layout.model;

    NSMutableArray * newThumbArr = [NSMutableArray arrayWithArray:model.optthumb];
    WS(weakSelf);
    [newThumbArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary * thumbDic = obj;
        if ([thumbDic[@"userid"] isEqualToString:@"12345678910"]) {
            [newThumbArr removeObject:obj];
            model.optthumb = [newThumbArr copy];
            [layout resetLayout];
            [weakSelf.dynamicsTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            *stop = YES;
        }
    }];
}
-(void)DidClickCommentInDynamicsCell:(NewDynamicsTableViewCell *)cell
{
    NSIndexPath * indexPath = [self.dynamicsTable indexPathForCell:cell];
    self.commentIndexPath = indexPath;

    self.commentInputTF.placeholder = @"输入评论...";
    [self.commentInputTF becomeFirstResponder];
    self.commentInputTF.hidden = NO;
}
-(void)DidClickSpreadInDynamicsCell:(NewDynamicsTableViewCell *)cell
{
    NSLog(@"点击了推广");
}
- (void)DidClickDeleteInDynamicsCell:(NewDynamicsTableViewCell *)cell
{
    WS(weakSelf);
    [UIAlertView bk_showAlertViewWithTitle:nil message:@"是否确定删除朋友圈" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            NSIndexPath * indexPath = [self.dynamicsTable indexPathForCell:cell];
            [SVProgressHUD showSuccessWithStatus:@"删除成功!"];
            [weakSelf.dynamicsTable beginUpdates];
            [weakSelf.layoutsArr removeObjectAtIndex:indexPath.row];
            [weakSelf.dynamicsTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [weakSelf.dynamicsTable endUpdates];
        }
    }];
}
-(void)DynamicsCell:(NewDynamicsTableViewCell *)cell didClickUrl:(NSString *)url PhoneNum:(NSString *)phoneNum
{
    if (url) {
        if ([url rangeOfString:@"wemall"].length != 0 || [url rangeOfString:@"t.cn"].length != 0) {
            if (![url hasPrefix:@"http://"]) {
                url = [NSString stringWithFormat:@"http://%@",url];
            }
            NSLog(@"点击了链接:%@",url);
        }else{
            [SVProgressHUD showErrorWithStatus:@"暂不支持打开外部链接"];
        }
    }
    if (phoneNum) {
        NSLog(@"点击了电话:%@",phoneNum);
    }
}
#pragma mark - UITextfield Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger commentRow = self.commentIndexPath.row;
    NewDynamicsLayout * layout = [self.layoutsArr objectAtIndex:commentRow];
    DynamicsModel * model = layout.model;
        if (![self.commentInputTF.text isEqualToString:@""]) {

            NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"12345678910",@"userid",@"andy",@"nick",textField.text,@"message",nil,@"touser",nil,@"tonick", nil];//toUserID可能为nil,需放在最后
            NSMutableArray * newCommentArr = [NSMutableArray arrayWithArray:model.optcomment];
            [newCommentArr addObject:dic];
            model.optcomment = [newCommentArr copy];
            [layout resetLayout];
            [self.dynamicsTable reloadRowsAtIndexPaths:@[self.commentIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            
            self.commentInputTF.text = nil;
            [self.commentInputTF resignFirstResponder];
        }
    return YES;
}
@end
