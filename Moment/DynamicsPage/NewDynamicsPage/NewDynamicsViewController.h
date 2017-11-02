//
//  NewDynamicsViewController.h
//  LooyuEasyBuy
//
//  Created by Andy on 2017/9/27.
//  Copyright © 2017年 Doyoo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MJRefresh.h>
//#import "XMChatBar.h"


@interface NewDynamicsViewController : UIViewController

@property(nonatomic,copy)NSString * dynamicsUserId;
@property(nonatomic,strong)UITableView * dynamicsTable;
@property(nonatomic,strong)NSMutableArray * layoutsArr;
@property(nonatomic,copy)NSString * toUserName;
@property(nonatomic,assign)NSIndexPath * commentIndexPath;
@property(nonatomic,strong)UITextField * commentInputTF;


@end
