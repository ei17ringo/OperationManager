//
//  ViewController.h
//  OperationManeger
//
//  Created by Ryohei Terakata on 2014/08/01.
//  Copyright (c) 2014年 Ryohei Terakata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//検索機能
//@property (nonatomic,strong) IBOutlet UITextField *serch;
@property (weak, nonatomic) IBOutlet UIButton *FavoriteBotten;
@property (nonatomic) UITextField *textFields;
-(void)textFieldView;
-(void)textFieldAction:(id)sender;
@end
