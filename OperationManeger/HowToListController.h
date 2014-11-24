//
//  DetailViewController.h
//  SampleTableView003
//
//  Created by Ryohei Terakata on 2014/07/17.
//  Copyright (c) 2014年 Ryohei Terakata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyButton.h"

@interface HowToListController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,assign)NSInteger selectnum;
@property (weak, nonatomic) IBOutlet UILabel *ProgramName;
@property (weak, nonatomic) IBOutlet UITextView *descriptionText;
@property (weak, nonatomic) IBOutlet UITableView *howtoTableView;
@property (nonatomic,strong) NSDictionary *HowToList;
@property (nonatomic,strong) NSArray *TitileList;
@end
