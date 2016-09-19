//
//  MainViewController.h
//  ShataLive
//
//  Created by hanzhong.yan on 16/5/17.
//  Copyright © 2016年 shata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@end
