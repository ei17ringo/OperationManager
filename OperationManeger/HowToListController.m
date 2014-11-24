//
//  DetailViewController.m
//  SampleTableView003
//
//  Created by Ryohei Terakata on 2014/07/17.
//  Copyright (c) 2014年 Ryohei Terakata. All rights reserved.
//

#import "HowToListController.h"
#import "DetailViewController.h"

@interface HowToListController ()
{
    NSArray *_operationList;
    
}
@end

@implementation HowToListController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}


- (void)viewDidLoad
    {
        [super viewDidLoad];
        
        
        NSBundle *bundle=[NSBundle mainBundle];
        
        //読み込みプロパティリストのファイルパス（場所）を指定
        NSString *path = [bundle pathForResource:@"OperationList" ofType:@"plist"];
        
        //プロパティリストの中身のデータを取得
        //※_HowToListにはrootそのものをとってくる。
        _HowToList = [NSDictionary dictionaryWithContentsOfFile:path];
        
        //rootはディクショナリー型なので、キーで引っ張ってくる。
        //キーの名前はOperationList(Root["OperationList"]という形になってる)
        NSArray *temp = [_HowToList objectForKey:@"OperationList"];
        
        //tempは配列型なので、数値で引っ張ってくる。selectnumには、前の画面で、
        //押された行番号が入っている。
        //tempはArray型、temp[0],temp[1]はディクショナリー型
        //temp[押された行番号]に対してはキーで引っ張ってくる必要がある。
        //今回引っ張りたいキーはHowToList.
        _TitileList = [temp[self.selectnum] objectForKey:@"HowToList"];
        
        
        //ここでいったん処理終了、実際に表示する部分はcellForRowAtIndexPathにまかせる。
        
        //NSLog(@"------------------------------");
        
        
        self.howtoTableView.delegate = self;
        self.howtoTableView.dataSource = self;

        
    }


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

return _TitileList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier ];
        
        Mybutton *aButton = [[Mybutton alloc] initWithFrame:CGRectMake(10, 8, 30, 30)];
        aButton.tag = 10000;
        aButton.backgroundColor = [UIColor blueColor];
        [aButton addTarget:aButton
                    action:@selector(buttonDidTouchDown:)
          forControlEvents:UIControlEventTouchDown];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *favouriteList =[userDefaults mutableArrayValueForKey:@"favoriteList"];
        
        // お気に入りとして登録してあるデータをチェックする。
        // もし、既に登録してあれば、お気に入りから削除して処理を終了
        //（終了というのは、returnの部分です。returnを書くとそれ以降の処理をせずに終了します。）
        for(NSDictionary *favoriteHowto in favouriteList){
            NSDictionary *howto = self.TitileList[indexPath.row];
            if ([favoriteHowto isEqual:howto]) {
                //aButton.titleLabel = @"★";
                [aButton setTitle:@"★" forState:UIControlStateNormal];
            }
        }
        [cell addSubview:aButton];
    }
    

    Mybutton *theButton = (Mybutton *)[cell viewWithTag:10000];
   if (theButton) {
       theButton.section = [indexPath section];
       theButton.row = [indexPath row];
       theButton.HowTo = _TitileList[indexPath.row];
    }
    
    NSLog(@"row:: %@", _TitileList[indexPath.row]);
    NSDictionary *dic = _TitileList[indexPath.row];
    NSLog(@"dict:: %@", dic[@"Name"]);
    cell.textLabel.text=[NSString stringWithFormat:@"      %@", dic[@"Name"]];
    
    
    return cell;


    {
        static NSString *CellIndentifier=@"Cell";
        
        //セルの再利用
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIndentifier];
        
        if(cell==nil)
        {
            //表示スタイルを決定
            cell=[[UITableViewCell alloc]
                  initWithStyle:
                  UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
        }
        
        
        NSLog(@"row:: %@", _operationList[indexPath.row]);
        NSDictionary *dic = _operationList[indexPath.row];
        NSLog(@"dict:: %@", dic[@"Name"]);
        cell.textLabel.text=[NSString stringWithFormat:@"%@", dic[@"Name"]];
        
        
        NSDictionary *how = dic[@"how to"];
        NSLog(@"content:: %@", how[@"content"]);
        
        
        return cell;
    }
    
}
    

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Tap:%d",indexPath.row);
    
    DetailViewController *dvc=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    
    //行番号を保存
    
    dvc.selectnum=indexPath.row;
    
    // セルの選択状態解除
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //友達リストをDetailViewControllerに渡す
    
    NSString *content = [_TitileList[indexPath.row] objectForKey:@"Content"];
    dvc.content = content;

    
    
    //ナビゲーションコントローラーの機能で画面遷移
    [[self navigationController]
     pushViewController:dvc animated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
}

@end
