//
//  DetailViewController.h
//  SampleTableView003
//
//  Created by Ryohei Terakata on 2014/07/17.
//  Copyright (c) 2014年 Ryohei Terakata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface DetailViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate>

@property(nonatomic,assign)NSInteger selectnum;
@property (weak, nonatomic) IBOutlet UILabel *ProgramName;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (nonatomic,strong) NSDictionary *HowTo;
@property (nonatomic,strong) NSString *content;
@property (weak, nonatomic) IBOutlet UITextView *contentTextVew;
@property (weak, nonatomic) IBOutlet UIButton *tapButton;
@property (weak, nonatomic) IBOutlet UIButton *memoButton;
- (IBAction)tapMemo:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *memoThumb;



@end
