//
//  ViewController.m
//  OperationManeger
//
//  Created by Ryohei Terakata on 2014/08/01.
//  Copyright (c) 2014年 Ryohei Terakata. All rights reserved.
//

#import "ViewController.h"
#import "HowToListController.h"

@interface ViewController ()
{
    NSArray *_operationList;
    
}

@end


@implementation ViewController
//検索機能
@synthesize textFields;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //検索機能
    NSBundle *bundle=[NSBundle mainBundle];
    
    //読み込みプロパティリストのファイルパス（場所）を指定
    
    NSString *path = [bundle pathForResource:@"OperationList" ofType:@"plist"];
    
    //プロパティリストの中身のデータを取得
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSLog(@"%@",dic);
    
    _operationList=[dic objectForKey:@"OperationList"];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _operationList.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexpath
{
    static NSString *CellIndentifier=@"Cell";
    
    //セルの再利用
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    
    if(cell == nil)
    {
        //表示スタイルを決定
        cell=[[UITableViewCell alloc]
              initWithStyle:
              UITableViewCellStyleDefault reuseIdentifier:_operationList[indexpath.row]];
    }
    
    
    
    NSLog(@"row:: %@", _operationList[indexpath.row]);
    NSDictionary *dic = _operationList[indexpath.row];
    NSLog(@"dict:: %@", dic[@"Name"]);
    cell.textLabel.text=[NSString stringWithFormat:@"%@", dic[@"Name"]];

    //TODO: Cellのサムネイルを表示させる
    //TODO: 画像の配列を用意
    //TODO: 画像の配列を取得して表示
    cell.imageView.image=[UIImage imageNamed:[_operationList[indexpath.row] objectForKey:@"Img"]];
    
    if (indexpath.row % 2 == 0) {
      cell.backgroundColor = [UIColor colorWithRed:0.961 green:0.961 blue:0.961 alpha:1];
     
    }
    //0.863,0.863,0.863
    
    NSArray* sam = [[NSArray alloc] init];
    sam = @[@"business②.png",@"business③.png",@"business④.png",@"business⑤.png",@"business⑥.png",@"business⑦.png",@"business⑧.png"];
    
//    NSLog(@"%@", sam);
    NSLog(@"%@", sam);
    
    
    

    NSDictionary *how = dic[@"how to"];
    NSLog(@"content:: %@", how[@"content"]);
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"Tap:%d",indexPath.row);
    
    HowToListController *hvc=[self.storyboard instantiateViewControllerWithIdentifier:@"HowToListController"];
    //行番号を保存
    
    hvc.selectnum=indexPath.row;
    
    //友達リストをDetailViewControllerに渡す
    hvc.HowToList=_operationList [indexPath.row];

    
    
    //ナビゲーションコントローラーの機能で画面遷移
    [[self navigationController]
     pushViewController:hvc animated:YES];
}

//-(void)textFieldView {
//    textFields = [[UITextField alloc] initWithFrame:CGRectMake(10.0, 80.0, 300.0, 40.0)];
//    
//    textFields.borderStyle = UITextBorderStyleRoundedRect;
//    
//    textFields.font = [UIFont systemFontOfSize:20.0];
//    
//    textFields.textColor = [UIColor blackColor];
//    
//    textFields.textAlignment = NSTextAlignmentLeft;
//    
//    textFields.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    
//    textFields.backgroundColor = [UIColor whiteColor];
//    
//    textFields.placeholder = @"検索";
//    
//    textFields.autocorrectionType = UITextAutocorrectionTypeNo;
//    
//    textFields.autocapitalizationType = UITextAutocapitalizationTypeNone;
//    
//    textFields.keyboardType = UIKeyboardTypeDefault;
//    
//    textFields.returnKeyType = UIReturnKeySearch;
//    
//    textFields.clearButtonMode = UITextFieldViewModeWhileEditing;
//    
//    textFields.delegate = self;
//    
//    [textFields addTarget:self action:@selector(textFieldAction:) forControlEvents:UIControlEventEditingDidEnd];
//    
//    //[textFields becomeFirstResponder];
//    
//    [self.view addSubview:textFields];
//
//}
//

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    return YES;
    
}

-(BOOL)textFieldShouldClear:(UITextField*)textField
{
    return YES;
}



/*
- (IBAction)serch:(id)sender
{
    [self.serch setPlaceholder:@"検索"];
    [self.serch setTextAlignment:NSTextAlignmentLeft];
    
}
*/
@end
