//
//  additionalViewController.h
//  OperationManeger
//
//  Created by Ryohei Terakata on 2014/08/14.
//  Copyright (c) 2014年 Ryohei Terakata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface additionalViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *additionalList;


@end
